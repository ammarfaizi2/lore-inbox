Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751577AbVKBLBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbVKBLBW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 06:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbVKBLBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 06:01:22 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:972 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751577AbVKBLBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 06:01:21 -0500
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Roman Kagan <rkagan@sw.ru>
Subject: Re: [PATCH]  Eagle and ADI 930 usb adsl modem driver
Date: Wed, 2 Nov 2005 12:01:17 +0100
User-Agent: KMail/1.8.3
Cc: David Woodhouse <dwmw2@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, usbatm@lists.infradead.org,
       linux-usb-devel@lists.sourceforge.net
References: <4363F9B5.6010907@free.fr> <1130850242.21212.29.camel@hades.cambridge.redhat.com> <20051102104617.GA2098@panda.sw.ru>
In-Reply-To: <20051102104617.GA2098@panda.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511021201.17686.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman, glad to see you're still alive!

On Wednesday 2 November 2005 11:46, Roman Kagan wrote:
> On Tue, Nov 01, 2005 at 01:04:02PM +0000, David Woodhouse wrote:
> > On Tue, 2005-11-01 at 13:40 +0100, Duncan Sands wrote:
> > > this code looks like a 'orrible hack to work around a common problem
> > > with USB modem's of this type: if the modem is plugged in while the
> > > system boots, the driver may look for firmware before the filesystem
> > > holding the firmware is mounted; I guess the delay usually gives
> > > the filesystem enough time to be mounted.  I'm told that the correct
> > > solution is to stick the firmware in an initramfs as well. 
> > 
> > Why can't we request the firmware again when the device is first used,
> > if it wasn't present when the driver was first loaded?
> 
> Because the firmware loading can take long, and apps may legitimately
> give up opening the device after a timeout.
> 
> Besides, it doesn't look logical.  An uninitialized device is not
> particularly useful for anything but initialization.  You don't create,
> say, a network device for your ethernet card until you're finished with
> its PCI setup, do you?
> 
> I think the async firmware loading can do the job nicely, in a generic
> manner.  BTW the usbatm drivers do it already (wasn't it you who
> implemented it? :), long before request_firmware_nowait() was available.
> So it's only a matter of tools adjusting, which seems to be going on.

I can't help feeling that it is wrong to add ad-hoc code to drivers (such
as: if the firmware wasn't there, try to load it again later) in an attempt
to work around what is, in the end, a userspace configuration problem.  The
fact that configuring userspace correctly seems to be tricky is sad, but not
the driver's problem.

I don't mind using request_firmware_nowait by the way.  The lack of a
timeout is no problem as long as we make it possible for the user to shoot
the firmware loading down by sending a signal.

Ciao,

Duncan.

PS: On the other hand, users are feeling the pain, which means I get to feel
their pain, which tempts me to hack in a workaround ;)
