Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312104AbSCUN5x>; Thu, 21 Mar 2002 08:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312133AbSCUN5l>; Thu, 21 Mar 2002 08:57:41 -0500
Received: from harley.unix-ag.uni-siegen.de ([141.99.42.44]:47849 "EHLO
	harley.unix-ag.uni-siegen.de") by vger.kernel.org with ESMTP
	id <S312104AbSCUN5T>; Thu, 21 Mar 2002 08:57:19 -0500
Date: Thu, 21 Mar 2002 14:57:11 +0100
From: Fionn Behrens <Fionn.Behrens@unix-ag.org>
To: linux-kernel@vger.kernel.org
Subject: SMP IRQ management issues in 2.4.x
Message-Id: <20020321145711.47a90758.fionn@unix-ag.org>
Organization: United Fools Of Bugaloo
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After changing from 2.2.18 to 2.4.17 recently, I noticed that after booting 2.4 my interrupts were routed a lot less effectively than under 2.2

I did not take it too seriously until the beginning of this week when I plugged in an extra Promise controller. I have a gigabyte 6BXD Dual Pentium Board which is a quite nice piece of hardware. Just the Award BIOS is crappy in that you cant assign IRQs directly to certain slots but only reserve certain interrupts from being distributed among the PCI Units. Anyway, until Linux 2.4, the kernel did cope quite well with that and distributed IRQs equally using the whole range of interrupts the IO-APIC delivers.

Now, I have this Promise controller and my IRQ table looks like this:

           CPU0       CPU1
  0:      21400      20144    IO-APIC-edge  timer
  1:       1349       1173    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  5:          5          3    IO-APIC-edge  serial
  8:          1          1    IO-APIC-edge  rtc
 12:       3138       3046    IO-APIC-edge  PS/2 Mouse
 14:        857       6088    IO-APIC-edge  ide0
 15:        452       3855    IO-APIC-edge  ide1
 16:      24354      24086   IO-APIC-level  aic7xxx, aic7xxx, aic7xxx, ide2,  
                                                               ide3, nvidia
 18:        501        445   IO-APIC-level  EMU10K1
 19:        822        765   IO-APIC-level  usb-uhci, eth0

Given that IRQs<6 are all locked for serial IO that means IRQ 7,9,11 and 17
are completely unused but there are a whopping 6 devices on IRQ 16.

Needless to say that Harddrives connected to ide2 and ide3 (Promise) constantly lose interrupts when used as long as X is running (nvidia), bringing the system to crawl.

I have tried virtually everything to make Linux (and the BIOS) reconsider IRQ distribution and failed.
And yes, all DMA stuff is properly set, the disks are recognized with their real size, partitioned and initialized correctly and so on. In fact they work like a charm as long as I don't use the graphics card.

Is there any way to reassign IRQs under 2.4.x to stabilize the system?
Is there any way to make Linux-2.4.x-SMP distribute IRQs in the same fashion
Linux-2.2.x-SMP did?
Any help appreciated (including pointers on what to patch in the kernel)

Regards,
        Fionn
-- 
I believe we have been called by history to lead the world.
                                                       G.W. Bush, 2002-03-01
