Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273371AbRINM3n>; Fri, 14 Sep 2001 08:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273368AbRINM3W>; Fri, 14 Sep 2001 08:29:22 -0400
Received: from pD9508A29.dip.t-dialin.net ([217.80.138.41]:41517 "EHLO
	bennew01.localdomain") by vger.kernel.org with ESMTP
	id <S273371AbRINM3R>; Fri, 14 Sep 2001 08:29:17 -0400
Date: Fri, 14 Sep 2001 14:30:21 +0200
From: Matthias Haase <matthias_haase@bennewitz.com>
To: linux-kernel@vger.kernel.org
Subject: repeatable SMP lockups - kernel 2.4.9
Message-Id: <20010914143021.0a5c9791.matthias_haase@bennewitz.com>
X-Operating-System: linux smp kernel 2.4* on i686
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Our new SMP file- and printserver locks always hard up, if higher load
come on the NIC. True stable without networking (X11, DRI

1. First, I have changed the NIC from 3Com (vortex-driver) to noname,
driven by Realtek
RTL-8139 (rev 10) and the lockup occurs some later, but it occurs
repeatable if I copy large file on LAN, or export an X11 environment to
another box.
2. Changing the kernel to 2.2.19 results the same thing.

Donald Becker wrote, that he think, this apparently could be a bug with
the interrupt handling in the 2.4.9 kernel, not inside
the (his) driver itself.

The boot on the mainboard (Asus CUV266-D, 2x PIII 1 GHz, 512 mb DDR-RAM)
is always o.k. with APIC, excepting the 'unexpected IO-APIC, please mail'
- warning.
The lockup occurs too with 'noapic' on boot.

At third stage I can try another and 'smp-cleaner' (I think)  NIC, D-Link
DFE-500 TX, based on DEC-Chip, using the tulip-driver.

Nothing is wrote about this in /var/log messages. The box is SCSI only,
Adaptec 29160N.

/proc/interrupts:

           CPU0       CPU1       
  0:     273705     282423    IO-APIC-edge  timer
  1:       4891       5117    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          0          1    IO-APIC-edge  rtc
 10:       8578       8328   IO-APIC-level  aic7xxx
 11:     962066     961390   IO-APIC-level  mga@PCI:1:0:0, es1371
 12:     109685     111089    IO-APIC-edge  PS/2 Mouse
 15:       2273       2295   IO-APIC-level  eth0
NMI:          0          0 
LOC:     556044     556060 
ERR:          0
MIS:          0


Looks clean :-(

Are there any patches, hints or recommendations known about this?


__ 
Best regards from Germany

Matthias




