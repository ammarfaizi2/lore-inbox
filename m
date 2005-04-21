Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVDUN4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVDUN4L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 09:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbVDUN4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 09:56:11 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:50376 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S261384AbVDUNz7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 09:55:59 -0400
To: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
Cc: akpm@osdl.org, vgoyal@in.ibm.com
MIME-Version: 1.0
Subject: Kdump Testing
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF5975C9DE.231115EA-ON65256FEA.004A436D-65256FEA.004D0D1E@in.ibm.com>
From: Nagesh Sharyathi <sharyathi@in.ibm.com>
Date: Thu, 21 Apr 2005 19:26:11 +0530
X-MIMETrack: Serialize by Router on d23m0069/23/M/IBM(Release 6.51HF653 | October 18, 2004) at
 21/04/2005 19:25:43,
	Serialize complete at 21/04/2005 19:25:43
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I tested the kdump tool on x235 and x206 machines and found this problem 
where on kernel Panic, system instead of booting into the panic kernel 
jumps into BIOS and machine restarts.
(I have given the hardware specifications at the bottom of the mail)

Software:
- 2.6.12-rc2-mm1
- kexec-tools-1.101 
- Five kdump user space patches 
  [http://marc.theaimsgroup.com/?l=linux-kernel&m=111201661400892&w=2]

Test Procedure:
- Built first kernel for 1M location with CONFIG_KEXEC enabled.
- Booted into first kernel with command line options crashkernel=48M@16M.
- Built second kernel for 16M location with CONFIG_CRASH_DUMP, and 
  CONFIG_PROC_VMCORE enabled.
- Loaded second kernel with following kexec command.

  kexec -p vmlinux-16M --args-linux --crash-dump --append="root=<root-dev>
  init 1"

- Inserted a module or echo into sysrq-trigger to invoke panic.
- System jumps  into BIOS directly instead of booting into secondary 
kernel.

Summary Observation:

- Earlier I was able to make kdump work on x330 machine by removing 
maxcpus=1 (as specified in kdump.txt) option during loading panic kernel, 
through kexec tool. But this work around doesn't seems to work with the 
hardware x235 and x206. On kernel panic machine jumps to BIOS rather than 
to panic kernel without displaying any error message.


HARDWARE SPECIFICATIONS
------------

A) Hardware  x330: 
- SMP, 2way, Pentium III (Coppermine) 1 GHz, 1.3G RAM
- Network Interface (e100)
- Disk I/O
  SCSI storage controller: Adaptec Ultra160 
-----------
B)Hardware x235
- SMP, 2way, Xeon TM 2.8GHz, 1.5g RAM
- Network Interface (Tigon3)
- Disk I/O
  SCSI storage controller: IBM Serve RAID
-------------
C)Hardware x206
- SMP, 1way, Pentium IV 2.8GHz, 2g RAM
- Network Interface (e1000)
- Disk I/O
  SCSI storage controller: Adaptec Ultra320

