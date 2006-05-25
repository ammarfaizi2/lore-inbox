Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbWEYPIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbWEYPIM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 11:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbWEYPIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 11:08:12 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:12457 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030222AbWEYPIL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 11:08:11 -0400
Message-ID: <4475C845.5000801@garzik.org>
Date: Thu, 25 May 2006 11:07:49 -0400
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
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>	 <9e4733910605241656r6a88b5d3hda8c8a4e72edc193@mail.gmail.com>	 <4475007F.7020403@garzik.org> <200605250237.20644.dhazelton@enter.net>	 <44756E70.9020207@garzik.org> <9e4733910605250704m68235d88lcd8eaedfda5e63cf@mail.gmail.com>
In-Reply-To: <9e4733910605250704m68235d88lcd8eaedfda5e63cf@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 5/25/06, Jeff Garzik <jeff@garzik.org> wrote:
>> * Review Dave Airlie's posts, he's been pretty spot-on in this thread.
>> There needs to be a lowlevel driver that handles PCI functionality, and
>> registers itself with the fbdev and DRM layers.  The fbdev/DRM
>> registrations need to be aware of each other.  Once that is done, work
>> will proceed more rapidly.
> 
> Controlling which driver is bound to the hardware is an easy problem
> that a low level driver handles nicely. But controlling binding
> doesn't really fix anything. All of the drivers binding to it still
> have to duplicate all of the code for things like VRAM allocation, GPU
> start/stop, mode setting, etc. That's because the second level drivers
> can't count on the other drivers being loaded. The giant mess of whose
> state is loaded into the hardware still exists too. Just consider the
> simple problem of who EOI's an interrupt.

In Linux, the lowlevel driver registers irq handlers, so your simple 
problem has the simple and obvious answer.  Further, reviewing my 
statement above, if fbdev/DRM are aware of each other, and if they both 
are layered on top of the lowlevel driver, then it should also be 
obvious that they are cooperatively sharing resources, not competing 
against one another.


> I would instead start by making fbdev the low level driver. DRM could
> then bind to it and redundant code in DRM could be removed. 90% of the
> code in fbdev is always needed.  Hopefully X could be convinced to use

Take your pick.  An fbdev driver is nothing but a PCI driver that 
registers itself with the fbdev subsystem.  Ditto a DRM driver, though 
the DRM and agpgart layering is royally screwed up ATM.  Regardless, he 
who codes, wins.


> the services offered by the fbdev/DRM pair. New memory management code

No "hopefully."  X must be forced to use this driver, otherwise the 
system is unworkable.


> would be added to this base driver since everyone needs it. Fbdev

If fbdev and DRM are cooperating, then obviously they will cooperate 
when managing resources.  GPU memory is but one example of a resource.


> would also pick up the ability to reset secondary cards at boot.

But if you think the kernel will grow an x86 emulator, you're dreaming. 
That's what initramfs and friends are for.

	Jeff



