Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285590AbRLWI1F>; Sun, 23 Dec 2001 03:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285591AbRLWI0v>; Sun, 23 Dec 2001 03:26:51 -0500
Received: from mout0.freenet.de ([194.97.50.131]:4076 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S285590AbRLWI0n>;
	Sun, 23 Dec 2001 03:26:43 -0500
Message-ID: <3C2595A0.3030804@athlon.maya.org>
Date: Sun, 23 Dec 2001 09:28:16 +0100
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: pcmcia / hotplugging in kernel 2.4.16/17 with Thinkpad T21
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Some hints for using pcmcia / hotplugging feature with kernel 2.4.16/17. 
Please notice my mail "[2.4.17rc1] various hotplugging problems" too.

My laptop is a IBM Thinkpad T21. I have the PCMCIA-card
Xircom CBEM56G-100 CardBus 10/ 100 CardBus 10/100 Ethernet + 56K Modem.
APM is enabled. "Ignore user suspend" and "allow interrupts during APM 
BIOS calls" seem to have no effect.


There are potentially two ways to get pcmcia working:

1. Using hotplug-function of kernel 2.4.x
I could get it working (basic modules statically linked
in the kernel) with some restrictions:
- No ethernet connects with autonegotiation 100Mb/FD are possible.
- Forcing 100Mb/FD on client and server is possible with a lot of errors
   on the laptop.
- apm -s crashes the laptop.
- Hotplugging feature doesn't recognize the modem on the Xircom card.

2. Using no hotplugging of the kernel but only the pcmcia-cs-package 
(3.1.29/30)
It was for me the best way with the fewest restrictions.

Restarting of pcmcia after stopping and laptop has been once in suspend 
mode before doesn't work. Not later than the next card-change, the 
laptop hangs.
That's why it is good to leave cardmgr / pcmcia untouched once it is 
started.
If you leave cardmgr and modules untouched, apm -s or HW-suspend via 
Fn-F4 seems to work.


Another problem was the hotplugging of the cdrom or the floppy drive.
It is necessary to put the boot option "hdc=cdrom" in lilo.conf to give
the kernel the chance to find the cdrom drive plugged in after booting.
The floppy drive is found with /dev/fd1 (not fd0).
If you change the floppy drive / cdrom drive, it is necessary to do a
HW-suspend and wake up (with Fn-F4 - key combination) to give the kernel
a chance to recognize the changed HW.
Because of this, it's very important to have a working suspend mode - no 
matter
if hw-mode or sw-mode.


I would be glad to hear your experiences / comments,
regards,
Andreas Hartmann

