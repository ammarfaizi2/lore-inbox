Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264004AbSJJUqA>; Thu, 10 Oct 2002 16:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264008AbSJJUqA>; Thu, 10 Oct 2002 16:46:00 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:3548 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264004AbSJJUp4>; Thu, 10 Oct 2002 16:45:56 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200210102051.g9AKpUo31633@devserv.devel.redhat.com>
Subject: Re: Xbox Linux Kernel Patches Questions
To: mist@c64.org (Michael Steil)
Date: Thu, 10 Oct 2002 16:51:30 -0400 (EDT)
Cc: torvalds@transmeta.com, alan@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <CE3A2942-DC8C-11D6-B7BF-003065E1FB16@c64.org> from "Michael Steil" at Oct 10, 2002 10:13:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The Xbox chipset has a PCI bug that makes the system hang when reading 
> from 00:00.2 or 00:00.3 in the PCI configuration space. We have added a 
> check that ignores these devices, embraced by #ifdef CONFIG_XBOX in 
> drivers/pci/pci.c

Can you tell the xbox by the subsystem id on the root bridges ?

> 2) System timer fix
> The system timer runs about 6% faster than on a PC. We have added a 
> #ifdef CONFIG_XBOX section to include/asm-i386/timex.h

It isnt actually alone in that - 2.5 probably makes that pretty easy to
accomodate. We have subtrees for x86 variants as a patch set now and used
for the voyager platform. The newer IBM and certain other vendor "big x86"
boxes are pretty weird probably weirder than X-box 8)

> 3) Shutdown/Reboot
> The Xbox doesn't support standardized APM to shut down and doesn't have 
> a keyboard controller to reset the system. We have added code to shut 
> down and reboot the Xbox in arch/i386/kernel/process.c.

Ok. Thats true of some embedded x86 too

> 4) No keyboard controller
> There already seems to be a patch available that doesn't print 100 
> warnings and allocate IRQ1 for the keyboard if there is no keyboard 
> controller present and we add the command line parameter "kbd-reset". 
> This patch is in 2.4.19-16mdk, but not in plain vanilla 2.4.19. Without 
> this patch, we have an interrupt conflict on IRQ1.

The latest code has a kbd_present function. That lets you add the logic
you need.

> Do we have a chance for our kernel fixes for the Xbox to be included 
> into the standard kernel? All our changes are tiny and #ifdef 
> CONFIG_XBOX and change nothing on a i386 PC or on any other 
> architecture.

Probably. I suspect the primary questions are political/lawyer ones rather than
technical ones. Things like the IDE drive password are touchy obviously
but that can be done from an initrd loaded with the kernel I guess.

> Would it be better to have a runtime check at kernel initialization to 
> detect the Xbox and put all Xbox specific code between if (xbox) {}?

IMHO yes. 

> the way, FATX doesn't only make sense on the Xbox, it's a multi-purpose 
> filesystem that might also be used for other applications, because of 
> it's simplicity and its small kernel footprint. (Please note that our 
> FATX code is still in beta).
> 
> Can our additional drivers be added to the standard kernel once they 
> are finished?

Yes - you should probably aim at 2.5 for merging rather than 2.4 however, 
especially for things like the FATX file system work.
