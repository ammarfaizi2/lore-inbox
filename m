Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265309AbUFXTMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265309AbUFXTMh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 15:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265282AbUFXTLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 15:11:40 -0400
Received: from washoe.rutgers.edu ([165.230.95.67]:1751 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S265233AbUFXTK1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 15:10:27 -0400
Date: Thu, 24 Jun 2004 15:10:26 -0400
From: Yaroslav Halchenko <kernel@onerussian.com>
To: linux-kernel@vger.kernel.org
Subject: alienware hardware
Message-ID: <20040624191026.GP728@washoe.rutgers.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Image-Url: http://www.onerussian.com/img/yoh.png
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear kernel-people,

Please give me hints

How can I track down next problem: we've got a new laptop from alienware
(Septa model seems to me). We've tried kernels shipped with debian:
2.4.26 and 2.6.6 but then I moved to vanila 2.6.7-bk7
and problem persisted: during boot after some point it becomes way too
slow : like it is running 100MHz, but checking
/proc/acpi/processor/CPU1/* showed that it didn't switch to any
throtelling mode or anything like that. Just it runs the process in "R"
mode on 99.9% cpu utilization user mode:
CPU states:  99.8% user,   0.2% system,   0.0% nice,   0.0% idle

It seems that it slows down right after starting work with IDE... though
I can be wrong. Probably it is linked to the fact that most of the
devices are not recognized by the kernel and it uses some bad defaults?

Also I've tried to specify idebus=66 because it was complaining about
setting default 33 but it didn't quite help...

Here are some detailes about the machine:


alien:/proc# lspci  
00:00.0 Host bridge: Intel Corp.: Unknown device 3580 (rev 02)
00:00.1 System peripheral: Intel Corp.: Unknown device 3584 (rev 02)
00:00.3 System peripheral: Intel Corp.: Unknown device 3585 (rev 02)
00:02.0 VGA compatible controller: Intel Corp.: Unknown device 3582 (rev 02)
00:02.1 Display controller: Intel Corp.: Unknown device 3582 (rev 02)
00:1d.0 USB Controller: Intel Corp.: Unknown device 24c2 (rev 03)
00:1d.1 USB Controller: Intel Corp.: Unknown device 24c4 (rev 03)
00:1d.2 USB Controller: Intel Corp.: Unknown device 24c7 (rev 03)
00:1d.7 USB Controller: Intel Corp.: Unknown device 24cd (rev 03)
00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (-M) (rev 83)
00:1f.0 ISA bridge: Intel Corp.: Unknown device 24cc (rev 03)
00:1f.1 IDE interface: Intel Corp.: Unknown device 24ca (rev 03)
00:1f.3 SMBus: Intel Corp.: Unknown device 24c3 (rev 03)
00:1f.5 Multimedia audio controller: Intel Corp.: Unknown device 24c5 (rev 03)
00:1f.6 Modem: Intel Corp.: Unknown device 24c6 (rev 03)
01:00.0 CardBus bridge: O2 Micro, Inc.: Unknown device 6972
01:01.0 FireWire (IEEE 1394): VIA Technologies, Inc. OHCI Compliant IEEE 1394 Host Controller (rev 80)
01:02.0 Network controller: Intel Corp.: Unknown device 4220 (rev 05)
01:08.0 Ethernet controller: Intel Corp.: Unknown device 103a (rev 83)


alien:/proc# cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 9
model name      : Intel(R) Pentium(R) M processor 1700MHz
stepping        : 5
cpu MHz         : 1693.651
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 apic sep mtrr pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 tm pbe tm2 est
bogomips        : 3350.52



alien:/proc# cat /proc/interrupts 
           CPU0       
  0:    2224762    IO-APIC-edge  timer
  1:       1741    IO-APIC-edge  i8042
  8:          3    IO-APIC-edge  rtc
  9:         13   IO-APIC-level  acpi
 12:       9473    IO-APIC-edge  i8042
 14:       4784    IO-APIC-edge  ide0
 15:         13    IO-APIC-edge  ide1
 16:          0   IO-APIC-level  uhci_hcd
 17:          0   IO-APIC-level  Intel 82801DB-ICH4
 18:          0   IO-APIC-level  uhci_hcd
 19:          0   IO-APIC-level  uhci_hcd
 20:      13049   IO-APIC-level  eth0
 23:          0   IO-APIC-level  ehci_hcd
NMI:          0 
LOC:    2224931 
ERR:          0
MIS:          0


-- 
                                                  Yaroslav Halchenko
                  Research Assistant, Psychology Department, Rutgers
          Office  (973) 353-5440 x263
   Ph.D. Student  CS Dept. NJIT
             Key  http://www.onerussian.com/gpg-yoh.asc
 GPG fingerprint  3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8

