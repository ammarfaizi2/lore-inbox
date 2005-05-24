Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbVEXNVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbVEXNVc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 09:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbVEXNVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 09:21:31 -0400
Received: from mailfe04.swip.net ([212.247.154.97]:42428 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262060AbVEXNNy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 09:13:54 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: kdump test update
From: Alexander Nyberg <alexn@telia.com>
To: Nagesh Sharyathi <sharyathi@in.ibm.com>
Cc: pbadari <pbadari@us.ibm.com>, mjbligh <Martin.Bligh@us.ibm.com>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <OFA0D3C130.0ED83C93-ON6525700B.0030EAEB-6525700B.0032C0D5@in.ibm.com>
References: <OFA0D3C130.0ED83C93-ON6525700B.0030EAEB-6525700B.0032C0D5@in.ibm.com>
Content-Type: text/plain
Date: Tue, 24 May 2005 15:13:51 +0200
Message-Id: <1116940431.999.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tis 2005-05-24 klockan 14:38 +0530 skrev Nagesh Sharyathi:
> These I have tested on the kernel 2.6.12-rc4-mm1 with the following test
> suites , with kdump enabled 
> 
> Once test suites PASS/SUCCESS, force the machine to hang(lock up) by 
> disabling irqs with the attached SPINLOCK test module from Badari 
> Pulavarthy, 
> try to take dump either with sysrq key or nmi_watchdog=2 kernel parameter.
> 
> Test Suite: 
> -----------
> LTP Runall, FSracer(race condition in file system) with LVM partitions 
> (over ext2, ext3, JFS, XFS), FS stress, Mem Test/Bash Memory, Cerberus, 
> KernBench, NetPerf.
> 
> System Info:
> ------------
> Distro: SLES 9 SP1
> 
> Software/kernel variables:
> --------------------------
> 1. kernel - linux-2.6.12-rc4-mm1 
> 2. kexec-tools-1.101 + kdump patches
> 3. kernel.sysrq=1
>  
> Command line parameters for first kernel:
> -----------------------------------------
>   root = <> vga=0x31a selinux=0 splash=silent resume=<> elevator=cfq 
> showpts
>   crashkernel=48M@16M console=tty0 console=ttyS0,38400n1
>  
> Hardwares on which is test cases are run:
> -----------------------------------------
> 
> A) 1way, Pentium IV 2.8GHz, 2G RAM
>    - Network Interface (e1000)
>    - Disk I/O: SCSI storage controller: Adaptec Ultra320
> 
>    o Ran test suite KERNBENCH and CERBERUS test ran successfully. Forced 
>      system hang by inserting spinlock test module and tried to invoke 
>      panic with sysrq+c, but it failed to force Panic. I failed to take 
> the 
>      dump as sysrq keys failed to respond during hang.

This is expected, your spinlock module disables interrupts so
sysrq-crashdump has not a chance to get through. NMI watchdog is highly
necessary. (this is even more reason to have NMI watchdog on by default
on at least newer cpus even on x86 if kdump enters mainline and wants to
be useful).


