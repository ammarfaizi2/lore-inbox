Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262950AbVCDRAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262950AbVCDRAK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 12:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262962AbVCDQ5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 11:57:04 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:47298 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262948AbVCDQyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 11:54:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=jdy/aSaGEFad4yLYBnJaMUNEyiGk5nl3tLVJU6jObIxeACA7Md60qzR8KCAtjFFhuuhAbnthxswDn8I0GlB2Jz+He4tx3FrE86spVGanoDwe8Hqr7HS5Cp5pRl3KQZyVJS97bt3bV+buj34mwhOeu2s7ncLkwWrZ3LRHWrGQfUQ=
Message-ID: <d120d50005030408544462c9ea@mail.gmail.com>
Date: Fri, 4 Mar 2005 11:54:18 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Hans-Christian Egtvedt <hc@mivu.no>
Subject: Re: [PATCH] new driver for ITM Touch touchscreen
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1109953224.3069.39.camel@charlie.itk.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1109932223.5453.16.camel@charlie.itk.ntnu.no>
	 <200503041403.37137.adobriyan@mail.ru>
	 <d120d50005030406525896b6cb@mail.gmail.com>
	 <1109953224.3069.39.camel@charlie.itk.ntnu.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Mar 2005 17:20:24 +0100, Hans-Christian Egtvedt <hc@mivu.no> wrote:
> On Fri, 2005-03-04 at 09:52 -0500, Dmitry Torokhov wrote:
> > On Fri, 4 Mar 2005 14:03:37 +0200, Alexey Dobriyan <adobriyan@mail.ru> wrote:
> > > On Friday 04 March 2005 12:30, Hans-Christian Egtvedt wrote:
> 
> <snip info about kref>
> 
> > As far as the driver goes:
> >
> > - yes, it does need input_sync;
> 
> One problem with input_sync is that the panel get's too fast, and double
> click is experienced quite often, maybe some threshold is needed for low
> values in Z-direction?
> 
> I'm probably doing something wrong here since I experience easy
> doubleclicks when I just lightly touch the screen.
>

Yes, I think you need to use some threshold when reporting BTN_TOUCH
event. Still, always report ABS_PRESSURE as is. This way the
touchscreen is useable via legacy interfaces (mousedev. tsdev) and if
a specialized userspace driver is written it still can get pretty much
unmangled data from /dev/input/eventX. This will also allow such
driver adjust touchpad sensitivity, if needed.

> > Also, is there a way to query the screen for actual size?
> 
> Sorry, the panel is a fixed size, and it gives out coordinates from 0 ->
> 4095 in both X- and Y-direction. In Z-direction (pressure strength) it
> goes from 0 to 255.
> 
> Or did you want the size of the screen? Meaning you want to know if it's
> a 15", 17" and so on?
> 

No, not physical sizes. I was wondering if soe touchscreens are
reporting let's say actual coordinates from 1100-3600 and others from
600-3850, instead of full 0-4096. Is there a way to query the hardware
and find the actual min and max for a device so it can be reported to
userspace.

-- 
Dmitry

P.S. When you post the updated version could you please CC Vojtech
Pavlik <vojtech@suse.cz> as he is the current input system maintainer
and linux-input mailing list at linux-input@atrey.karlin.mff.cuni.cz.
Thanks!
