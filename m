Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbTINUt7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 16:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbTINUt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 16:49:59 -0400
Received: from 67-50-116-12.br1.fod.ia.frontiernet.net ([67.50.116.12]:8576
	"EHLO www.duskglow.com") by vger.kernel.org with ESMTP
	id S261345AbTINUt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 16:49:57 -0400
Date: Sun, 14 Sep 2003 15:54:29 -0500
From: Russell Miller <rmiller@duskglow.com>
To: linux-kernel@vger.kernel.org
Subject: [SUMMARY] rebooting problem solved - athlon/SiS incompatibility.
Message-ID: <20030914205429.GA3535@www.duskglow.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As a follow up to a message that I sent earlier, I've found
the reason that my machine would reboot on 2.6 kernels.  It
could be argued that it's no fault of the kernel, but perhaps
the documentation should be updated.

I traced the problem to between the gunzip() call and the
startup32 call.  There are very few options that affect this,
obviously.  Two that do are CONFIG_SMP and the coprocessor
emulation option.  After turning them off and rebuilding,
the kernel started.  It hung on ACPI, but after compiling that
out of the kernel, it booted fine and I'm running it now.

This is the output of lspci, to show the configuration that will
cause this problem:

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 730 Host (rev 02)
00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
00:01.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
00:01.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
00:01.4 Multimedia audio controller: Silicon Integrated Systems [SiS] SiS PCI Audio Accelerator (rev 02)
00:02.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] SiS630 GUI Accelerator+3D (rev 31)

and:

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 4
model name	: AMD Athlon(tm) processor
stepping	: 2
cpu MHz		: 902.169
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips	: 1785.85

Which basically seems to mean:  you cannot enable SMP and turn off coprocessor
emulation on an SiS motherboard containing an Athlon Thunderbird processor.  The
kernel will not even get past the "Ok, booting the kernel" stage.

--Russell
