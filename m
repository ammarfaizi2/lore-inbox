Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWEQK11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWEQK11 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 06:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWEQK10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 06:27:26 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:45448 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S932071AbWEQK10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 06:27:26 -0400
Message-ID: <446AFA7D.1070707@uni-hd.de>
Date: Wed, 17 May 2006 12:27:09 +0200
From: Martin Braun <mbraun@uni-hd.de>
Reply-To: mbraun@uni-hd.de
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: hard lock (no oops) with 2.6.16.x on webserver with scsi/smp/raid
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been trying to upgrade kernel to 2.6.16 (2.6.16.14 #1 SMP Tue May 9
14:23:19 CEST 2006 i686 i686 i386 GNU/Linux). The server boots
normally w/o errors, but after a while (from several hours up to 2
hours) the Kernel hangs/freezes: no keyboard input possible, no oops, no
trace on the serial console on the attached laptop. It seems to happen
when the server is on high load (bzip2, many samba connections).

We had Problems with Kernel 2.6.13 with AACRaid - this seems to be
solved for 2.6.15. After the 2.6.16.x Kernels Crashed again we moved the
system partitions to the external easy-raid system and connected the
easyraid-system and a scsi-harddisk for the boot-partition to the
adaptec mainboard controller and put off the Adaptec Raid Controller.

But with no success - we have still the kernel-crashes.

With no OOPS/Core dump - how can I get more Debug Information?

We  ran vendor's hardware testing utilitys (cpu burn-in, memtest, etc.)
- but everything seeems to be ok.

This Monday we  changed the server-hardware completly,  and yesterday we
had the issue that the boot-partition on the external hardisk vanished,
there was no crash and after a while we could remount the partition. I
don't now if this correlates to the original Problem.


==
Message log with new server hardware,
==
May 16 16:43:47 pers109 kernel: sd 0:0:0:0: SCSI error: return code =
0x8000002
May 16 16:43:47 pers109 kernel: sda: Current: sense key: Aborted Command
May 16 16:43:47 pers109 kernel:     Additional sense: Scsi parity error
May 16 16:43:47 pers109 kernel: end_request: I/O error, dev sda, sector 575
May 16 16:43:47 pers109 kernel: EXT3-fs error (device sda1):
ext3_readdir: directory #2 contains a hole at offset 0
May 16 16:43:47 pers109 kernel: Aborting journal on device sda1.
May 16 16:43:47 pers109 kernel: sd 0:0:0:0: SCSI error: return code =
0x8000002
May 16 16:43:47 pers109 kernel: sda: Current: sense key: Aborted Command
May 16 16:43:47 pers109 kernel:     Additional sense: Scsi parity error
May 16 16:43:47 pers109 kernel: end_request: I/O error, dev sda, sector 601
May 16 16:43:47 pers109 kernel: Buffer I/O error on device sda1, logical
block 269
May 16 16:43:47 pers109 kernel: lost page write due to I/O error on sda1
May 16 16:43:47 pers109 kernel: sd 0:0:0:0: SCSI error: return code =
0x8000002
May 16 16:43:47 pers109 kernel: sda: Current: sense key: Aborted Command
May 16 16:43:47 pers109 kernel:     Additional sense: Scsi parity error
May 16 16:43:47 pers109 kernel: end_request: I/O error, dev sda, sector 65
May 16 16:43:47 pers109 kernel: Buffer I/O error on device sda1, logical
block 1
May 16 16:43:47 pers109 kernel: lost page write due to I/O error on sda1
May 16 16:43:47 pers109 kernel: sd 0:0:0:0: SCSI error: return code =
0x8000002
May 16 16:43:47 pers109 kernel: sda: Current: sense key: Aborted Command
May 16 16:43:47 pers109 kernel:     Additional sense: Scsi parity error




=====
lspci (new Hardware)
=====

0000:00:00.0 Host bridge: Intel Corporation E7320 Memory Controller Hub
(rev 0c)
0000:00:00.1 Class ff00: Intel Corporation E7320 Error Reporting
Registers (rev 0c)
0000:00:02.0 PCI bridge: Intel Corporation E7525/E7520/E7320 PCI Express
Port A (rev 0c)
0000:00:03.0 PCI bridge: Intel Corporation E7525/E7520/E7320 PCI Express
Port A1 (rev 0c)
0000:00:1c.0 PCI bridge: Intel Corporation 6300ESB 64-bit PCI-X Bridge
(rev 02)
0000:00:1d.0 USB Controller: Intel Corporation 6300ESB USB Universal
Host Controller (rev 02)
0000:00:1d.1 USB Controller: Intel Corporation 6300ESB USB Universal
Host Controller (rev 02)
0000:00:1d.4 System peripheral: Intel Corporation 6300ESB Watchdog Timer
(rev 02)
0000:00:1d.5 PIC: Intel Corporation 6300ESB I/O Advanced Programmable
Interrupt Controller (rev 02)
0000:00:1d.7 USB Controller: Intel Corporation 6300ESB USB2 Enhanced
Host Controller (rev 02)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 0a)
0000:00:1f.0 ISA bridge: Intel Corporation 6300ESB LPC Interface
Controller (rev 02)
0000:00:1f.1 IDE interface: Intel Corporation 6300ESB PATA Storage
Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corporation 6300ESB SMBus Controller (rev 02)
0000:02:00.0 Ethernet controller: Marvell Technology Group Ltd. Gigabit
Ethernet Controller (rev 18)
0000:03:03.0 SCSI storage controller: Adaptec ASC-29320A U320 (rev 10)
0000:04:02.0 VGA compatible controller: ATI Technologies Inc Rage XL
(rev 27)
0000:04:03.0 Ethernet controller: Intel Corporation 82541GI/PI Gigabit
Ethernet Controller (rev 05)




=====
lspci (old hardware)
=====
0000:00:00.0 Host bridge: Intel Corp. E7501 Memory Controller Hub (rev 01)
0000:00:02.0 PCI bridge: Intel Corp. E7500/E7501 Hub Interface B
PCI-to-PCI Bridge (rev 01)
0000:00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02)
0000:00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 42)
0000:00:1f.0 ISA bridge: Intel Corp. 82801CA LPC Interface Controller
(rev 02)
0000:00:1f.1 IDE interface: Intel Corp. 82801CA Ultra ATA Storage
Controller (rev 02)
0000:01:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04)
0000:01:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04)
0000:01:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04)
0000:01:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04)
0000:02:05.0 SCSI storage controller: Adaptec AIC-7902 U320 (rev 03)
0000:02:05.1 SCSI storage controller: Adaptec AIC-7902 U320 (rev 03)
0000:03:03.0 Ethernet controller: Intel Corp. 82544GC Gigabit Ethernet
Controller (LOM) (rev 02)
0000:04:01.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet
Controller (rev 02)
0000:04:02.0 VGA compatible controller: ATI Technologies Inc Rage XL
(rev 27)
=================
cat /proc/cpuinfo  (first cpu-output) (old hardware)
=================
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Xeon(TM) CPU 2.80GHz
stepping	: 7
cpu MHz		: 1595.696
cache size	: 512 KB
physical id	: 0
siblings	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips	: 3153.92



The Server is used as Webserver w/ Apache2/Tomcat/PHP/Samba with high
load. Samba is extensivly used.

thanks in advance.
martin



