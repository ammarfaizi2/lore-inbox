Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932563AbWHHIZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbWHHIZc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 04:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbWHHIZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 04:25:32 -0400
Received: from kunzite.stewarts.org.uk ([80.68.93.148]:26125 "EHLO
	kunzite.stewarts.org.uk") by vger.kernel.org with ESMTP
	id S932563AbWHHIZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 04:25:31 -0400
Date: Tue, 8 Aug 2006 09:24:29 +0100
To: linux-kernel@vger.kernel.org
Subject: Only 3.2G ram out of 4G seen in an i386 box
Message-ID: <20060808082429.GA1068@stewarts.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Thomas Stewart <thomas@stewarts.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have a Dell Optiplex GX280, a Pentium 4 with an Intel chipset. It has
4G of ram. The problem is I can only see 3.2G, even tho the bios reports
4G.

While using debian 2.6.16-2-686:
thomas@coke:~$ uname -a
Linux coke 2.6.16-2-686 #1 Sat Jul 15 21:59:21 UTC 2006 i686 GNU/Linux
thomas@coke:~$ grep MemTotal /proc/meminfo
MemTotal:      3375484 kB

This is expected as the standard debian kernels don't set
CONFIG_HIGHMEM64G. My understanding is that this needs to be set for the
full 4G to work on i386.

So I downloaded 2.6.18-rc3-git3 and 2.6.18-rc2-mm1 to give them a try. I
used the debian config as a starting point for oldconfig. Then from
menuconfig, "Processor type and featues" -> "High Memory Support" and
selected 64G. I then compiled both, rebooted and got these results:

2.6.18-rc2-mm1  reported MemTotal: 3376192 kB
2.6.18-rc3-git3 reported MemTotal: 3376236 kB

Is there anything I can do to make use of the 800M or so of ram that's
unused? Changing to amd64 or anything else that's sane or better does
not count ;-)

thomas@coke:~$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 3
model name      : Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping        : 4
cpu MHz         : 2992.591
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 3
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe constant_tsc pni monitor ds_cpl cid xtpr
bogomips        : 5990.72

thomas@coke:~$ lspci
00:00.0 Host bridge: Intel Corporation 915G/P/GV/GL/PL/910GL Express Memory Controller Hub (rev 04)
00:01.0 PCI bridge: Intel Corporation 915G/P/GV/GL/PL/910GL Express PCI Express Root Port (rev 04)
00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 1 (rev 03)
00:1c.1 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 2 (rev 03)
00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 (rev 03)
00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2 (rev 03)
00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 03)
00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4 (rev 03)
00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller (rev 03)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d3)
00:1e.2 Multimedia audio controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Audio Controller (rev 03)
00:1f.0 ISA bridge: Intel Corporation 82801FB/FR (ICH6/ICH6R) LPC Interface Bridge (rev 03)
00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE Controller (rev 03)
00:1f.2 IDE interface: Intel Corporation 82801FB/FW (ICH6/ICH6W) SATA Controller (rev 03)
00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller (rev 03)
01:00.0 VGA compatible controller: ATI Technologies Inc RV370 5B60 [Radeon X300 (PCIE)]
01:00.1 Display controller: ATI Technologies Inc RV370 [Radeon X300SE]
02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5751 Gigabit Ethernet PCI Express (rev 01)
thomas@coke:~$

Regards
--
Tom
(Please CC me as I'm off the list)
