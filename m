Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262097AbVERFu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbVERFu0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 01:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbVERFu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 01:50:26 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:62173 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S262097AbVERFuN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 01:50:13 -0400
To: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
MIME-Version: 1.0
Subject: Kdump test update
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF4BD7A275.A4D056FB-ON65257005.001FD461-65257005.00208609@in.ibm.com>
From: Nagesh Sharyathi <sharyathi@in.ibm.com>
Date: Wed, 18 May 2005 11:19:59 +0530
X-MIMETrack: Serialize by Router on d23m0069/23/M/IBM(Release 6.51HF653 | October 18, 2004) at
 18/05/2005 11:19:59,
	Serialize complete at 18/05/2005 11:19:59
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These I have tested the kernel 2.6.12-rc3-mm3 with the following test
suites, with kdump enabled

Test Suite: 
NetPerf, FSracer(race condition in file system) with LVM partitions 
(over ext2,ext3,JFS,XFS), NetPipe, ltpRunall, Cerberus, KernBench

System Info:
Distro: SLES 9 SP1
Hardwares on which is test cases are run:
A) 1way, Pentium IV 2.8GHz, 2G RAM
   - Network Interface (e1000)
   - Disk I/O: SCSI storage controller: Adaptec Ultra320

B) SMP, 2way, Pentium III (Coppermine) 1 GHz, 1.3G RAM
   - Network Interface (e100)
   - Disk I/O: SCSI storage controller: Adaptec Ultra160

C) SMP, 2way, Xeon TM 2.8GHz, 1.5G RAM
   - Network Interface (Tigon3)
   - Disk I/O: SCSI storage controller: IBM Serve RAID


Software:
1. kernel - linux-2.6.12-rc3-mm3
2. kexec-tools-1.101 + kdump patches

Command line parameters
root = <> vga=0x31a selinux=0 splash=silent resume=<> elevator=cfq showpts
crashkernel=48M@16M console=tty0 console=ttyS0,38400n1

Test:
All test were run with the kdump enabled.

o On SMP 2 way 1.5G machine ran test suite FSracer over LVM partition and 
  the test ran without failures. Manually caused panic by triggering 
  through sysrq-trigger.Secondary kernel booted properly without any 
issues. 
  I was able to take the dump.

o On SMP 2 way 1.5G machine ran test suite netPerf as full duplex (both as 

  server and client) with SMP 2 way 1.3G machine serving as the other 
  end of the duplex. Manually caused panic through sysrq-trigger in SMP 
  2 way 1.5G machine and able to get dump successfully.

o SMP 2 way 1.3G machine ran Netperf, the test ran successfully. along 
  with full duplex NetPipe test that I mentioned earlier. Manually 
  caused panic in SMP 2 way 1.3G machine through insmod  and able to get 
  dump successfully.

o SMP 2 way 1.3G machine ran test ltp, test came out with failures (Bug 
  No: 4604,4612,4618). Manually Caused panic with insmod and second 
  kernel booted successfully and able to take dump.

o On 1way 2G RAM machine ran test cerberus, test ran successfully and 
  manually caused panic through sysrq-trigger and able to get dump 
  successfully.

o On 1way 2G RAM machine ran test KERNBENCH, test ran successfully and 
  manually caused panic through sysrq-trigger and able to get dump 
  successfully.


