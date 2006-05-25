Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965184AbWEYXTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965184AbWEYXTz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 19:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965181AbWEYXTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 19:19:54 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:50104 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965184AbWEYXTy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 19:19:54 -0400
Message-ID: <44763B8E.3050200@garzik.org>
Date: Thu, 25 May 2006 19:19:42 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: "D. Hazelton" <dhazelton@enter.net>, Dave Airlie <airlied@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>	 <9e4733910605241656r6a88b5d3hda8c8a4e72edc193@mail.gmail.com>	 <4475007F.7020403@garzik.org> <200605250237.20644.dhazelton@enter.net>	 <44756E70.9020207@garzik.org>	 <9e4733910605250704m68235d88lcd8eaedfda5e63cf@mail.gmail.com>	 <4475C845.5000801@garzik.org> <9e4733910605250837u59ad3881s75a0ed366fa2eefb@mail.gmail.com>
In-Reply-To: <9e4733910605250837u59ad3881s75a0ed366fa2eefb@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 5/25/06, Jeff Garzik <jeff@garzik.org> wrote:
>> Jon Smirl wrote:
>> In Linux, the lowlevel driver registers irq handlers, so your simple
>> problem has the simple and obvious answer.  Further, reviewing my
>> statement above, if fbdev/DRM are aware of each other, and if they both
>> are layered on top of the lowlevel driver, then it should also be
>> obvious that they are cooperatively sharing resources, not competing
>> against one another.
>>
>>
>> > I would instead start by making fbdev the low level driver. DRM could
>> > then bind to it and redundant code in DRM could be removed. 90% of the
>> > code in fbdev is always needed.  Hopefully X could be convinced to use
>>
>> Take your pick.  An fbdev driver is nothing but a PCI driver that
>> registers itself with the fbdev subsystem.  Ditto a DRM driver, though
>> the DRM and agpgart layering is royally screwed up ATM.  Regardless, he
>> who codes, wins.
> 
> There is significant architectural difference between the two schemes.
> Is the base driver an absolute minimal driver that only serves as a
> switch to route into the other drivers, or does the base driver
> contain all the common code? I'm in the common code camp, DaveA is in
> the minimal switch camp.

You are missing that both are the same camp.  It's just different paths 
to get to the same destination.  Common code will inevitably result.


> Take memory management for example. I think the memory manager should
> go into the base driver. The other strategy is for each driver to have
> their own memory manager and then the base provides a way to select
> which one is active. (Note that in all cases the complex part of
> memory management is running in user space).

That's an implementation detail that will naturally fall out of 
fbdev/DRM cooperation.  Don't worry, it will solve itself.


>> > the services offered by the fbdev/DRM pair. New memory management code
>>
>> No "hopefully."  X must be forced to use this driver, otherwise the
>> system is unworkable.
> 
> I have had no success in making this happen.

If the code is merged into the Linux kernel, X will follow.  Its axiomatic.

	Jeff


