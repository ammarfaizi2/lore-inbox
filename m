Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263760AbSJJUYx>; Thu, 10 Oct 2002 16:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263758AbSJJUNS>; Thu, 10 Oct 2002 16:13:18 -0400
Received: from ns1.weihenstephan.org ([212.82.168.3]:691 "EHLO 
	mail.weihenstephan.org") by vger.kernel.org with ESMTP
	id <S262870AbSJJUHn>; Thu, 10 Oct 2002 16:07:43 -0400
Date: Thu, 10 Oct 2002 22:13:56 +0200
Subject: Xbox Linux Kernel Patches Questions
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v543)
Cc: torvalds@transmeta.com, alan@redhat.com
To: linux-kernel@vger.kernel.org
From: Michael Steil <mist@c64.org>
Content-Transfer-Encoding: 7bit
Message-Id: <CE3A2942-DC8C-11D6-B7BF-003065E1FB16@c64.org>
X-Mailer: Apple Mail (2.543)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I am Michael Steil from the Xbox Linux Project. As you might already 
know, we successfully run standard distributions on ("modded") 
Microsoft Xbox gaming consoles with only minimal kernel changes.

Our question is now what way our patches will have to be in order to 
have a chance for them to be accepted into the main kernel tree. I'll 
tell you a bit about our kernel changes first:

1) PCI chipset bugfix
The Xbox chipset has a PCI bug that makes the system hang when reading 
from 00:00.2 or 00:00.3 in the PCI configuration space. We have added a 
check that ignores these devices, embraced by #ifdef CONFIG_XBOX in 
drivers/pci/pci.c

2) System timer fix
The system timer runs about 6% faster than on a PC. We have added a 
#ifdef CONFIG_XBOX section to include/asm-i386/timex.h

3) Shutdown/Reboot
The Xbox doesn't support standardized APM to shut down and doesn't have 
a keyboard controller to reset the system. We have added code to shut 
down and reboot the Xbox in arch/i386/kernel/process.c.

4) No keyboard controller
There already seems to be a patch available that doesn't print 100 
warnings and allocate IRQ1 for the keyboard if there is no keyboard 
controller present and we add the command line parameter "kbd-reset". 
This patch is in 2.4.19-16mdk, but not in plain vanilla 2.4.19. Without 
this patch, we have an interrupt conflict on IRQ1.

There are some more drivers we're working on at the moment:

1) FATX driver
The Xbox uses a derivative of the MS-DOS FAT filesystem, but it's a lot 
simplified and completely legacy-free. Though, the file allocation 
table structure and the basic ideas of directory entries remain the 
same. We have done small changes to fs/fat/* and added a directory 
fs/fatx.

2) Xpad & remote control drivers
The Xpad (Xbox gamepad) driver module is already available in your 
latest development kernel, we can soon add additional or updated 
drivers for Xbox-specific (USB) hardware.

So these are our questions now:

Do we have a chance for our kernel fixes for the Xbox to be included 
into the standard kernel? All our changes are tiny and #ifdef 
CONFIG_XBOX and change nothing on a i386 PC or on any other 
architecture.

Would it be better to have a runtime check at kernel initialization to 
detect the Xbox and put all Xbox specific code between if (xbox) {}?

Can our FATX driver be accepted into the main kernel? It has been 
impossible to implement FATX on top of FAT without making the FATX code 
a bit more general. We hope that it wasn't too many changes there. By 
the way, FATX doesn't only make sense on the Xbox, it's a multi-purpose 
filesystem that might also be used for other applications, because of 
it's simplicity and its small kernel footprint. (Please note that our 
FATX code is still in beta).

Can our additional drivers be added to the standard kernel once they 
are finished?

Our project website is at http://xbox-linux.sourceforge.net/, we have 
our kernel changes in the CVS if you want to have a look at it. I 
didn't want to send a patch in this mail already, because we might have 
to discuss what way to do our patches first (especially on #ifdef 
CONFIG_XBOX vs. if (xbox) {}).

Thanks a lot for your time.

   Michael

