Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbWHQLkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWHQLkq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 07:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWHQLkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 07:40:46 -0400
Received: from i59F54408.versanet.de ([89.245.68.8]:4103 "EHLO max.erig.daheim")
	by vger.kernel.org with ESMTP id S964820AbWHQLkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 07:40:45 -0400
Date: Thu, 17 Aug 2006 13:40:42 +0200
From: Wolfgang Erig <Wolfgang.Erig@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: andreas.friedrich@fujitsu-siemens.com
Subject: Regression with hyper threading scheduling
Message-ID: <20060817114042.GA8309@erig.dyndns.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	andreas.friedrich@fujitsu-siemens.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello kernel hacker,

I have a regression with Hyper-Threading in my box.

If I try e.g. 'while true; do ((ii+=1)); done' on two xterms
   - with 2.6.8 both CPUs are running (looking at gkrellm or /proc/stat)
   - with 2.6.15/2.6.17 etc. only one CPU is running, sometimes CPU0, sometimes CPU1

Any idea? If you need more info, let me know,
Wolfgang


Kernel 2.6.8.1: Hyper-Threading works:
======================================
uname -a
Linux oak 2.6.8.1 #1 SMP Wed May 10 13:24:21 CEST 2006 i686 GNU/Linux

cat /proc/stat
cpu  22709 4502 2543 1008491 2881 92 1475
cpu0 12800 2428 1426 501276 1859 92 1472
cpu1 9909 2074 1117 507215 1021 0 2
intr 5909520 5214423 7297 0 2 2 0 2 1 0 0 0 0 92935 0 7422 13 0 224861 42603 0 0 0 319959 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
ctxt 6553093
btime 1155801409
processes 2525
procs_running 3
procs_blocked 0

Kernel 2.6.17.8 etc.: Hyper-Threading does not work:
====================================================
uname -a
Linux oak 2.6.17.8 #2 SMP PREEMPT Thu Aug 17 11:40:04 CEST 2006 i686 GNU/Linux

cat /proc/stat
cpu  5049 0 744 137292 3113 18 3 0
cpu0 36 0 53 72732 282 18 1 0
cpu1 5012 0 690 64560 2831 0 2 0
intr 221093 182798 880 0 3 4 0 3 1 0 0 0 0 28863 0 6718 12 1811 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
ctxt 458461
btime 1155807757
processes 3203
procs_running 1
procs_blocked 0

Some HW-Infos:
==============
lshw
    description: Mini Tower Computer
    product: SCENIC P / SCENICO P
    vendor: FUJITSU SIEMENS
    version: SCEP
    serial: YBEM738326
    width: 32 bits
    capabilities: smbios-2.31 dmi-2.31
    configuration: boot=normal chassis=mini-tower uuid=FA48F283-A977-D811-A847-912FD384AB1D
  *-core
       description: Motherboard
       product: D1561
       vendor: FUJITSU SIEMENS
       physical id: 0
       version: S26361-D1561
       slot: Serial-1
     *-firmware
          description: BIOS
          vendor: FUJITSU SIEMENS // Phoenix Technologies Ltd.
          physical id: 0
          version: 5.00 R2.14.1561.01 (11/25/2004)
          size: 109KB
          capacity: 448KB
          capabilities: pci pnp apm upgrade shadowing escd cdboot bootselect int13floppynec int13floppytoshiba int13floppy360 int13floppy1200 int13floppy720 int13floppy2880 int5printscreen int9keyboard int14serial int17printer int10video acpi usb agp ls120boot zipboot biosbootspecification
     *-cpu
          description: CPU
          product: Intel(R) Pentium(R) 4 CPU 2.60GHz
          vendor: Intel Corp.
          physical id: 4
          bus info: cpu@0
          version: 15.2.9
          slot: CPU
          size: 2600MHz
          capacity: 2600MHz
          width: 32 bits
          clock: 800MHz
          capabilities: fpu fpu_exception wp vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
          configuration: id=1
        *-cache:0
             description: L1 cache
             physical id: 5
             slot: L1 Cache
             size: 8KB
             capacity: 32KB
             capabilities: burst synchronous internal write-through data
        *-cache:1
             description: L2 cache
             physical id: 6
             slot: L2 Cache
             size: 512KB
             capacity: 1MB
             capabilities: burst internal write-back unified
        *-cache:2 DISABLED
             description: L3 cache
             physical id: 7
             slot: L3 Cache
             capacity: 16MB
             capabilities: internal write-back unified
        *-logicalcpu:0
             description: Logical CPU
             physical id: 1.1
             width: 32 bits
             capabilities: logical
        *-logicalcpu:1
             description: Logical CPU
             physical id: 1.2
             width: 32 bits
  ...

