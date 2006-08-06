Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751409AbWHFLTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWHFLTh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 07:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWHFLTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 07:19:37 -0400
Received: from mail.gmx.de ([213.165.64.20]:63175 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751409AbWHFLTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 07:19:36 -0400
X-Authenticated: #476490
From: Oliver Endriss <o.endriss@gmx.de>
Reply-To: v4l-dvb-maintainer@linuxtv.org
Organization: ESCAPE GmbH EDV-Loesungen
To: v4l-dvb-maintainer@linuxtv.org
Subject: Re: [v4l-dvb-maintainer] Options depending on STANDALONE
Date: Sun, 6 Aug 2006 13:18:59 +0200
User-Agent: KMail/1.6.2
Cc: Adrian Bunk <bunk@stusta.de>, Trent Piepho <xyzzy@speakeasy.org>,
       Zachary Amsden <zach@vmware.com>, Andrew Morton <akpm@osdl.org>,
       Jack Lo <jlo@vmware.com>, Greg KH <greg@kroah.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, linux-acpi@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>
References: <44D1CC7D.4010600@vmware.com> <Pine.LNX.4.58.0608031610110.9178@shell2.speakeasy.net> <20060805105122.GT25692@stusta.de>
In-Reply-To: <20060805105122.GT25692@stusta.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200608061319.00085@orion.escape-edv.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Thu, Aug 03, 2006 at 04:40:25PM -0700, Trent Piepho wrote:
> > On Thu, 3 Aug 2006, Adrian Bunk wrote:
> > > On Thu, Aug 03, 2006 at 03:56:17PM -0400, Dave Jones wrote:
> > > > You're describing PREVENT_FIRMWARE_BUILD.  The text Zach quoted is from
> > > > STANDALONE, which is something else completely.  That allows us to not
> > > > build drivers that pull in things from /etc and the like during compile.
> > > > (Whoever thought that was a good idea?)
> > >
> > > Is DVB_AV7110_FIRMWARE really still required?
> > > ALL other drivers work without such an option.
> > 
> > The other DVB drivers that need firmware load it when the device is opened
> > or used (ie.  a channel is tuned).  At least for the ones I'm familiar
> > with.  If they are compiled directly into the kernel, they can still use
> > FW_LOADER since the loading won't happen until utill well after booting is
> > done.
> > 
> > For AV7110, it looks like the firmware loading is done when the driver is
> > first initialized.  If AV7110 is compiled into the kernel, FW_LOADER can
> > not be used.  The filesystem with the firmware won't be mounted yet.
> > 
> > So AV7110 has an option to compile a firmware file into the driver.
> 
> But is there a technical reason why this has to be done this way?
> 
> This is the onle (non-OSS) driver doing it this way, and Zach has a 
> point that this is legally questionable.

This option _is_ useful because it allows allows a user to build an
av7110 driver without hotplug etc. I NAK any attempt to remove it.

Sorry, a kernel option cannot cause a legal issue. Only the user does.
For non-distribution kernels there is no difference whether firmware is
loaded at run-time or compiled-in.

Obviously, there might be a difference for distribution kernels if you
are not allowed to distribute the firmware (imho not a problem in this
case, but IANAL). Simple solution: Do not enable the option.

I have no problem if you want to remove STANDALONE: Simply remove the
dependency to STANDALONE, but keep DVB_AV7110_FIRMWARE with default 'n'.

CU
Oliver

-- 
--------------------------------------------------------
VDR Remote Plugin available at
http://www.escape-edv.de/endriss/vdr/
--------------------------------------------------------
