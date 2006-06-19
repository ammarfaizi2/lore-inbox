Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932554AbWFSVqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbWFSVqw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 17:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbWFSVqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 17:46:52 -0400
Received: from orangecode.net ([69.36.165.200]:9162 "EHLO orangecode.net")
	by vger.kernel.org with ESMTP id S932548AbWFSVqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 17:46:50 -0400
Message-ID: <44971B43.7090802@antselovich.com>
Date: Mon, 19 Jun 2006 14:46:43 -0700
From: Konstantin Antselovich <konstantin@antselovich.com>
Reply-To: Konstantin Antselovich <konstantin@antselovich.com>
Organization: http://konstantin.antselovich.com
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: Infinite interrupt loop, INTSTAT = 8 ( WAS:  BUG: spinlock recursion
 on CPU, kernel 2.6.16.20 &  2.6.16-1.2122_FC5[smp])
References: <200606190600_MC3-1-C2D8-23E5@compuserve.com>
In-Reply-To: <200606190600_MC3-1-C2D8-23E5@compuserve.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------060801050702060606090203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060801050702060606090203
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

on 06/19/2006 02:57 AM Chuck Ebbert said:
> In-Reply-To: <4491933C.7060100@antselovich.com>
> 
> On Thu, 15 Jun 2006 10:05:00 -0700, Konstantin Antselovich wrote:
> 
>> Jun 10 00:57:35 192.168.0.201 BUG: spinlock recursion on CPU#2, swapper/0

<skip>

> Please try 2.6.17.  The spinlock was removed.
> 

Thanks!  Yes, spinlock recursion bug has gone away in 2.6.17.

But other some problems evolved: when I take a HDD out then push it
right back, kernel freezes and the following messages are logged:

---(see detailed log in attachment)---
Jun 19 13:52:05 192.168.0.201 Infinite interrupt loop, INTSTAT = 8
Jun 19 13:52:05 192.168.0.201 scsi0: At time of recovery, card was paused
Jun 19 13:52:05 192.168.0.201 >>>>>>>>>>>>>>>>>> Dump Card State Begins
<<<<<<<<<<<<<<<<<
Jun 19 13:52:05 192.168.0.201 scsi0: Dumping Card State at program
address 0x0 Mode 0x33
Jun 19 13:52:05 192.168.0.201 Card was paused
------

because SCSI Card is paused for quite a while, other HDDs are put
offline, md1 on which / partition resides (3 disks raid5) array brakes
as 2nd HDD is lost.

After some more scsi messages are logged, other issue with networking
pops up (see below).  At that point top shows 100% CPU is taken by event
kernel thread, machine locks and I had to push restart.


----
Jun 19 13:53:18 192.168.0.6 kernel: BUG: warning at
include/net/dst.h:154/dst_release()
Jun 19 13:53:18 192.168.0.6 kernel:  <c0293b7e> __kfree_skb+0x30/0xce
<c0293c52> skb_queue_purge+0xa/0x17
Jun 19 13:53:18 192.168.0.6 kernel:  <c02a51bb>
pfifo_fast_reset+0x14/0x2f  <c02a495a> qdisc_reset+0x10/0x11
Jun 19 13:53:18 192.168.0.6 kernel:  <c02a49f8> dev_deactivate+0x26/0x76
 <c029ee51> linkwatch_run_queue+0x121/0x141
Jun 19 13:53:18 192.168.0.6 kernel:  <c029ee93>
linkwatch_event+0x22/0x27  <c012ee7a> run_workqueue+0x7f/0xba
Jun 19 13:53:18 192.168.0.6 kernel:  <c029ee71> linkwatch_event+0x0/0x27
 <c012f682> worker_thread+0x0/0x106
Jun 19 13:53:18 192.168.0.6 kernel:  <c012f757> worker_thread+0xd5/0x106
 <c011bf79> default_wake_function+0x0/0xc
Jun 19 13:53:18 192.168.0.6 kernel:  <c0131bfd> kthread+0x9d/0xc9
<c0131b60> kthread+0x0/0xc9
Jun 19 13:53:18 192.168.0.6 kernel:  <c0102005> kernel_thread_helper+0x5/0xb
----


Let me know if more info is needed.

Thanks,
Konstantin


-- 
Konstantin Antselovich
mailto: konstantin@antselovich.com
http://konstantin.antselovich.com



--------------060801050702060606090203
Content-Type: text/x-log;
 name="smicro-2.6.17.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smicro-2.6.17.log"

Jun 19 13:48:28 192.168.0.6 kernel: Linux version 2.6.17 (root@smicro.myhome) (gcc version 4.1.1 20060525 (Red Hat 4.1.1-1)) #1 SMP Mon Jun 19 12:53:29 PDT 2006
....
Jun 19 13:48:30 192.168.0.6 kernel: SCSI subsystem initialized
Jun 19 13:48:30 192.168.0.6 kernel: ACPI: PCI Interrupt 0000:06:02.0[A] -> GSI 76 (level, low) -> IRQ 17
Jun 19 13:48:30 192.168.0.6 kernel: scsi0 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 3.0
Jun 19 13:48:30 192.168.0.6 kernel:         <Adaptec AIC7902 Ultra320 SCSI adapter>
Jun 19 13:48:30 192.168.0.6 kernel:         aic7902: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 101-133Mhz, 512 SCBs
Jun 19 13:48:30 192.168.0.6 kernel:
Jun 19 13:48:30 192.168.0.6 kernel:   Vendor: FUJITSU   Model: MAP3735NC         Rev: 0108
Jun 19 13:48:30 192.168.0.6 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jun 19 13:48:30 192.168.0.6 kernel:  target0:0:0: asynchronous
Jun 19 13:48:30 192.168.0.6 kernel: scsi0:A:0:0: Tagged Queuing enabled.  Depth 4
Jun 19 13:48:30 192.168.0.6 kernel:  target0:0:0: Beginning Domain Validation
Jun 19 13:48:30 192.168.0.6 kernel:  target0:0:0: wide asynchronous
Jun 19 13:48:30 192.168.0.6 kernel:  target0:0:0: FAST-160 WIDE SCSI 320.0 MB/s DT IU QAS RTI PCOMP (6.25 ns, offset 127)
Jun 19 13:48:30 192.168.0.6 kernel:  target0:0:0: Ending Domain Validation
Jun 19 13:48:30 192.168.0.6 kernel: SCSI device sda: 143571316 512-byte hdwr sectors (73509 MB)
Jun 19 13:48:30 192.168.0.6 kernel: sda: Write Protect is off
Jun 19 13:48:30 192.168.0.6 kernel: SCSI device sda: drive cache: write back
Jun 19 13:48:30 192.168.0.6 kernel: SCSI device sda: 143571316 512-byte hdwr sectors (73509 MB)
Jun 19 13:48:30 192.168.0.6 kernel: sda: Write Protect is off
Jun 19 13:48:30 192.168.0.6 kernel: SCSI device sda: drive cache: write back
Jun 19 13:48:30 192.168.0.6 kernel:  sda: sda1 sda2 sda3
Jun 19 13:48:30 192.168.0.6 kernel: sd 0:0:0:0: Attached scsi disk sda
Jun 19 13:48:30 192.168.0.6 kernel:   Vendor: FUJITSU   Model: MAP3735NC         Rev: 0108
Jun 19 13:48:30 192.168.0.6 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jun 19 13:48:30 192.168.0.6 kernel:  target0:0:1: asynchronous
Jun 19 13:48:30 192.168.0.6 kernel: scsi0:A:1:0: Tagged Queuing enabled.  Depth 4
Jun 19 13:48:30 192.168.0.6 kernel:  target0:0:1: Beginning Domain Validation
Jun 19 13:48:30 192.168.0.6 kernel:  target0:0:1: wide asynchronous
Jun 19 13:48:30 192.168.0.6 kernel:  target0:0:1: FAST-160 WIDE SCSI 320.0 MB/s DT IU QAS RTI PCOMP (6.25 ns, offset 127)
Jun 19 13:48:30 192.168.0.6 kernel:  target0:0:1: Ending Domain Validation
Jun 19 13:48:30 192.168.0.6 kernel: SCSI device sdb: 143571316 512-byte hdwr sectors (73509 MB)
Jun 19 13:48:30 192.168.0.6 kernel: sdb: Write Protect is off
Jun 19 13:48:30 192.168.0.6 kernel: SCSI device sdb: drive cache: write back
Jun 19 13:48:30 192.168.0.6 kernel: SCSI device sdb: 143571316 512-byte hdwr sectors (73509 MB)
Jun 19 13:48:30 192.168.0.6 kernel: sdb: Write Protect is off
Jun 19 13:48:30 192.168.0.6 kernel: SCSI device sdb: drive cache: write back
Jun 19 13:48:30 192.168.0.6 kernel:  sdb: sdb1 sdb2 sdb3
Jun 19 13:48:30 192.168.0.6 kernel: sd 0:0:1:0: Attached scsi disk sdb
Jun 19 13:48:31 192.168.0.6 kernel:   Vendor: FUJITSU   Model: MAP3735NC         Rev: 0108
Jun 19 13:48:31 192.168.0.6 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jun 19 13:48:31 192.168.0.6 kernel:  target0:0:2: asynchronous
Jun 19 13:48:31 192.168.0.6 kernel: scsi0:A:2:0: Tagged Queuing enabled.  Depth 4
Jun 19 13:48:31 192.168.0.6 kernel:  target0:0:2: Beginning Domain Validation
Jun 19 13:48:31 192.168.0.6 kernel:  target0:0:2: wide asynchronous
Jun 19 13:48:31 192.168.0.6 kernel:  target0:0:2: FAST-160 WIDE SCSI 320.0 MB/s DT IU QAS RTI PCOMP (6.25 ns, offset 127)
Jun 19 13:48:31 192.168.0.6 kernel:  target0:0:2: Ending Domain Validation
Jun 19 13:48:31 192.168.0.6 kernel: SCSI device sdc: 143571316 512-byte hdwr sectors (73509 MB)
Jun 19 13:48:31 192.168.0.6 kernel: sdc: Write Protect is off
Jun 19 13:48:31 192.168.0.6 kernel: SCSI device sdc: drive cache: write back
Jun 19 13:48:31 192.168.0.6 kernel: SCSI device sdc: 143571316 512-byte hdwr sectors (73509 MB)
Jun 19 13:48:31 192.168.0.6 kernel: sdc: Write Protect is off
Jun 19 13:48:31 192.168.0.6 kernel: SCSI device sdc: drive cache: write back
Jun 19 13:48:31 192.168.0.6 kernel:  sdc: sdc1 sdc2 sdc3
Jun 19 13:48:31 192.168.0.6 kernel: sd 0:0:2:0: Attached scsi disk sdc
Jun 19 13:48:31 192.168.0.6 kernel:   Vendor: SUPER     Model: GEM318            Rev: 0
Jun 19 13:48:31 192.168.0.6 kernel:   Type:   Processor                          ANSI SCSI revision: 02
Jun 19 13:48:31 192.168.0.6 kernel:  target0:0:6: asynchronous
Jun 19 13:48:31 192.168.0.6 kernel:  target0:0:6: Beginning Domain Validation
Jun 19 13:48:31 192.168.0.6 kernel:  target0:0:6: Ending Domain Validation
Jun 19 13:48:31 192.168.0.6 kernel: ACPI: PCI Interrupt 0000:06:02.1[B] -> GSI 77 (level, low) -> IRQ 18
Jun 19 13:48:31 192.168.0.6 kernel: scsi1 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 3.0
Jun 19 13:48:31 192.168.0.6 kernel:         <Adaptec AIC7902 Ultra320 SCSI adapter>
Jun 19 13:48:31 192.168.0.6 kernel:         aic7902: Ultra320 Wide Channel B, SCSI Id=7, PCI-X 101-133Mhz, 512 SCBs

---

Jun 19 13:51:00 192.168.0.201 end_request: I/O error, dev sda, sector 143556687
Jun 19 13:51:00 192.168.0.6 kernel: sd 0:0:0:0: SCSI error: return code = 0x10000
Jun 19 13:51:00 192.168.0.201 raid5: Disk failure on sda3, disabling device. Operation continuing on 2 devices
Jun 19 13:51:00 192.168.0.201 RAID5 conf printout:
Jun 19 13:51:00 192.168.0.201  --- rd:3 wd:2 fd:1
Jun 19 13:51:00 192.168.0.201  disk 0, o:0, dev:sda3
Jun 19 13:51:00 192.168.0.201  disk 1, o:1, dev:sdb3
Jun 19 13:51:00 192.168.0.201  disk 2, o:1, dev:sdc3
Jun 19 13:51:00 192.168.0.201 RAID5 conf printout:
Jun 19 13:51:00 192.168.0.201  --- rd:3 wd:2 fd:1
Jun 19 13:51:00 192.168.0.201  disk 1, o:1, dev:sdb3
Jun 19 13:51:00 192.168.0.201  disk 2, o:1, dev:sdc3
Jun 19 13:51:00 192.168.0.6 kernel: end_request: I/O error, dev sda, sector 143556687
Jun 19 13:51:00 192.168.0.6 kernel: raid5: Disk failure on sda3, disabling device. Operation continuing on 2 devices
Jun 19 13:51:00 192.168.0.6 kernel: RAID5 conf printout:
Jun 19 13:51:00 192.168.0.6 kernel:  --- rd:3 wd:2 fd:1
Jun 19 13:51:00 192.168.0.6 kernel:  disk 0, o:0, dev:sda3
Jun 19 13:51:00 192.168.0.6 kernel:  disk 1, o:1, dev:sdb3
Jun 19 13:51:00 192.168.0.6 kernel:  disk 2, o:1, dev:sdc3
Jun 19 13:51:00 192.168.0.6 kernel: RAID5 conf printout:
Jun 19 13:51:00 192.168.0.6 kernel:  --- rd:3 wd:2 fd:1
Jun 19 13:51:00 192.168.0.6 kernel:  disk 1, o:1, dev:sdb3
Jun 19 13:51:00 192.168.0.6 kernel:  disk 2, o:1, dev:sdc3

----


Jun 19 13:52:05 192.168.0.201 Infinite interrupt loop, INTSTAT = 8
Jun 19 13:52:05 192.168.0.201 scsi0: At time of recovery, card was paused 
Jun 19 13:52:05 192.168.0.201 >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<< 
Jun 19 13:52:05 192.168.0.201 scsi0: Dumping Card State at program address 0x0 Mode 0x33 
Jun 19 13:52:05 192.168.0.201 Card was paused 
Jun 19 13:52:05 192.168.0.201 INTSTAT[0x8]
Jun 19 13:52:05 192.168.0.201  
Jun 19 13:52:05 192.168.0.201 SELOID[0x1]
Jun 19 13:52:05 192.168.0.201  
Jun 19 13:52:05 192.168.0.201 SELID[0x10]
Jun 19 13:52:05 192.168.0.201  
Jun 19 13:52:05 192.168.0.201 HS_MAILBOX[0x0]
Jun 19 13:52:05 192.168.0.201  
Jun 19 13:52:05 192.168.0.201  
Jun 19 13:52:05 192.168.0.201 INTCTL[0x80]
Jun 19 13:52:05 192.168.0.201  
Jun 19 13:52:05 192.168.0.201 SEQINTSTAT[0x0]
Jun 19 13:52:05 192.168.0.201  
Jun 19 13:52:05 192.168.0.201 SAVED_MODE[0x11]
Jun 19 13:52:06 192.168.0.201  
Jun 19 13:52:06 192.168.0.201 DFFSTAT[0x33]
Jun 19 13:52:06 192.168.0.201  
Jun 19 13:52:06 192.168.0.201  
Jun 19 13:52:06 192.168.0.201 SCSISIGI[0x0]
Jun 19 13:52:06 192.168.0.201  
Jun 19 13:52:06 192.168.0.201 SCSIPHASE[0x0]
Jun 19 13:52:06 192.168.0.201  
Jun 19 13:52:06 192.168.0.201 SCSIBUS[0x0]
Jun 19 13:52:06 192.168.0.201  
Jun 19 13:52:06 192.168.0.201 LASTPHASE[0x1]
Jun 19 13:52:06 192.168.0.201  
Jun 19 13:52:06 192.168.0.201  
Jun 19 13:52:06 192.168.0.201 SCSISEQ0[0x0]
Jun 19 13:52:06 192.168.0.201  
Jun 19 13:52:06 192.168.0.201 SCSISEQ1[0x12]
Jun 19 13:52:06 192.168.0.201  
Jun 19 13:52:06 192.168.0.201 SEQCTL0[0x0]
Jun 19 13:52:06 192.168.0.201  
Jun 19 13:52:06 192.168.0.201 SEQINTCTL[0x0]
Jun 19 13:52:06 192.168.0.201  
Jun 19 13:52:06 192.168.0.201  
Jun 19 13:52:06 192.168.0.201 SEQ_FLAGS[0x0]
Jun 19 13:52:06 192.168.0.201  
Jun 19 13:52:06 192.168.0.201 SEQ_FLAGS2[0x4]
Jun 19 13:52:06 192.168.0.201  
Jun 19 13:52:06 192.168.0.201 QFREEZE_COUNT[0x3]
Jun 19 13:52:06 192.168.0.201  
Jun 19 13:52:06 192.168.0.201  
Jun 19 13:52:06 192.168.0.201 KERNEL_QFREEZE_COUNT[0x3]
Jun 19 13:52:06 192.168.0.201  
Jun 19 13:52:06 192.168.0.201 MK_MESSAGE_SCB[0xff00]
Jun 19 13:52:06 192.168.0.201  
Jun 19 13:52:06 192.168.0.201  
Jun 19 13:52:06 192.168.0.201 MK_MESSAGE_SCSIID[0xff]
Jun 19 13:52:06 192.168.0.201  
Jun 19 13:52:06 192.168.0.201 SSTAT0[0x0]
Jun 19 13:52:06 192.168.0.201  
Jun 19 13:52:06 192.168.0.201 SSTAT1[0x20]
Jun 19 13:52:06 192.168.0.201  
Jun 19 13:52:06 192.168.0.201 SSTAT2[0x0]
Jun 19 13:52:06 192.168.0.201 LQISTAT2[0x0]
Jun 19 13:52:06 192.168.0.201 QINFIFO:
Jun 19 13:52:06 192.168.0.201  
Jun 19 13:52:06 192.168.0.201  
Jun 19 13:52:06 192.168.0.201 9 
Jun 19 13:52:06 192.168.0.201  
Jun 19 13:52:06 192.168.0.201  
Jun 19 13:52:06 192.168.0.201 scsi0: FIFO0 Free, LONGJMP == 0x8071, SCB 0x3 
Jun 19 13:52:06 192.168.0.201  
Jun 19 13:52:06 192.168.0.201 SOFFCNT[0x0]
Jun 19 13:52:06 192.168.0.201  
Jun 19 13:52:06 192.168.0.201 SEQINTSRC[0x0]
Jun 19 13:52:06 192.168.0.201  
Jun 19 13:52:06 192.168.0.201 SHADDR = 0x00, SHCNT = 0x0 
Jun 19 13:52:06 192.168.0.201  
Jun 19 13:52:06 192.168.0.201 0x0 
Jun 19 13:52:06 192.168.0.201 scsi0: LQISTATE = 0x0, LQOSTATE = 0x0, OPTIONMODE = 0x52 
Jun 19 13:52:06 192.168.0.201 scsi0: SAVED_SCSIID = 0x0 SAVED_LUN = 0x0 
Jun 19 13:52:06 192.168.0.201 scsi0: SCBPTR == 0x3, SCB_NEXT == 0xff40, SCB_NEXT2 == 0xffca 
Jun 19 13:52:06 192.168.0.201  0x0
Jun 19 13:52:06 192.168.0.201  0x0
Jun 19 13:52:06 192.168.0.201 scsi0:0:2:0: Cmd aborted from QINFIFO 
Jun 19 13:52:16 192.168.0.201 Infinite interrupt loop, INTSTAT = 8
Jun 19 13:52:16 192.168.0.201 scsi0: At time of recovery, card was paused 
Jun 19 13:52:16 192.168.0.201 >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<< 
Jun 19 13:52:16 192.168.0.201 scsi0: Dumping Card State at program address 0x0 Mode 0x33 
Jun 19 13:52:16 192.168.0.201 Card was paused 
Jun 19 13:52:16 192.168.0.201 INTSTAT[0x8]
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201 SELOID[0x1]
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201 SELID[0x10]
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201 HS_MAILBOX[0x0]
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201 INTCTL[0x80]
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201 SEQINTSTAT[0x0]
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201 SAVED_MODE[0x11]
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201 DFFSTAT[0x33]
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201 SCSISIGI[0x0]
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201 SCSIPHASE[0x0]
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201 SCSIBUS[0x0]
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201 LASTPHASE[0x1]
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201 SCSISEQ0[0x0]
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201 SCSISEQ1[0x12]
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201 SEQCTL0[0x0]
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201 SEQINTCTL[0x0]
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201 SEQ_FLAGS[0x0]
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201 SEQ_FLAGS2[0x4]
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201 QFREEZE_COUNT[0x3]
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201 KERNEL_QFREEZE_COUNT[0x3]
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201 MK_MESSAGE_SCB[0xff00]
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201 MK_MESSAGE_SCSIID[0xff]
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201 SSTAT0[0x0]
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201 SSTAT1[0x20]
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201 SSTAT2[0x0]
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201 SSTAT3[0x0]
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201 PERRDIAG[0x0]
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201 SIMODE1[0xa4]
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201 SCB Count = 12 CMDS_PENDING = 0 LASTSCB 0x3 CURRSCB 0x3 NEXTSCB 0xff40 
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201 last message repeated 2 times
Jun 19 13:52:16 192.168.0.201 2 
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201 SEQIMODE[0x3f]
Jun 19 13:52:16 192.168.0.201 DFFSXFRCTL[0x0]
Jun 19 13:52:16 192.168.0.201 MDFFSTAT[0x5]
Jun 19 13:52:16 192.168.0.201 scsi0: FIFO1 Free, LONGJMP == 0x8063, SCB 0x2 
Jun 19 13:52:16 192.168.0.201 DFCNTRL[0x0]
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201 0x0 
Jun 19 13:52:16 192.168.0.201 0x0 
Jun 19 13:52:16 192.168.0.201 scsi0: LQISTATE = 0x0, LQOSTATE = 0x0, OPTIONMODE = 0x52 
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:16 192.168.0.201 CDB 35 0 0 0 0 0 
Jun 19 13:52:16 192.168.0.201  0x0
Jun 19 13:52:16 192.168.0.201  
Jun 19 13:52:17 192.168.0.201 Infinite interrupt loop, INTSTAT = 8
Jun 19 13:52:17 192.168.0.201 scsi0: At time of recovery, card was paused 
Jun 19 13:52:17 192.168.0.201 >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<< 
Jun 19 13:52:17 192.168.0.201 scsi0: Dumping Card State at program address 0x0 Mode 0x33 
Jun 19 13:52:17 192.168.0.201 Card was paused 
Jun 19 13:52:17 192.168.0.201 INTSTAT[0x8]
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201 SELOID[0x1]
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201 SELID[0x10]
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201 HS_MAILBOX[0x0]
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201 INTCTL[0x80]
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201 SEQINTSTAT[0x0]
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201 SAVED_MODE[0x11]
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201 DFFSTAT[0x33]
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201 SCSISIGI[0x0]
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201 SCSIPHASE[0x0]
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201 SCSIBUS[0x0]
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201 LASTPHASE[0x1]
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201 SCSISEQ0[0x0]
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201 SCSISEQ1[0x12]
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201 SEQCTL0[0x0]
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201 SEQINTCTL[0x0]
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201 SEQ_FLAGS[0x0]
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201 SEQ_FLAGS2[0x4]
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201 QFREEZE_COUNT[0x3]
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201 KERNEL_QFREEZE_COUNT[0x3]
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201 MK_MESSAGE_SCB[0xff00]
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201 MK_MESSAGE_SCSIID[0xff]
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201 SSTAT0[0x0]
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201 SSTAT1[0x20]
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201 SSTAT2[0x0]
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201 SSTAT3[0x0]
Jun 19 13:52:17 192.168.0.201 LQISTAT1[0x0]
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201 qinstart = 11642 qinfifonext = 11643 
Jun 19 13:52:17 192.168.0.201 WAITING_TID_QUEUES: 
Jun 19 13:52:17 192.168.0.201 Total 1 
Jun 19 13:52:17 192.168.0.201 7 
Jun 19 13:52:17 192.168.0.201 Sequencer Complete list: 
Jun 19 13:52:17 192.168.0.201 Sequencer On QFreeze and Complete list: 
Jun 19 13:52:17 192.168.0.201 SEQINTSRC[0x0]
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201 last message repeated 2 times
Jun 19 13:52:17 192.168.0.201 scsi0: FIFO1 Free, LONGJMP == 0x8063, SCB 0x2 
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201 last message repeated 2 times
Jun 19 13:52:17 192.168.0.201 0x0 
Jun 19 13:52:17 192.168.0.201 0x0 
Jun 19 13:52:17 192.168.0.201 scsi0: LQISTATE = 0x0, LQOSTATE = 0x0, OPTIONMODE = 0x52 
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201 scsi0: SCBPTR == 0x3, SCB_NEXT == 0xff40, SCB_NEXT2 == 0xffca 
Jun 19 13:52:17 192.168.0.201  
Jun 19 13:52:17 192.168.0.201 scsi0:0:1:0: Cmd aborted from QINFIFO 
Jun 19 13:53:08 192.168.0.201 Infinite interrupt loop, INTSTAT = 8
Jun 19 13:53:08 192.168.0.201 scsi0: At time of recovery, card was paused 
Jun 19 13:53:08 192.168.0.201 >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<< 
Jun 19 13:53:08 192.168.0.201 scsi0: Dumping Card State at program address 0x0 Mode 0x33 
Jun 19 13:53:08 192.168.0.201 Card was paused 
Jun 19 13:53:08 192.168.0.201 INTSTAT[0x8]
Jun 19 13:53:08 192.168.0.201  
Jun 19 13:53:08 192.168.0.201 SELOID[0x1]
Jun 19 13:53:08 192.168.0.201  
Jun 19 13:53:08 192.168.0.201 SELID[0x10]
Jun 19 13:53:08 192.168.0.201  
Jun 19 13:53:08 192.168.0.201 HS_MAILBOX[0x0]
Jun 19 13:53:08 192.168.0.201  
Jun 19 13:53:08 192.168.0.201  
Jun 19 13:53:08 192.168.0.201 INTCTL[0x80]
Jun 19 13:53:08 192.168.0.201  
Jun 19 13:53:08 192.168.0.201 SEQINTSTAT[0x0]
Jun 19 13:53:08 192.168.0.201  
Jun 19 13:53:08 192.168.0.201 SAVED_MODE[0x11]
Jun 19 13:53:08 192.168.0.201  
Jun 19 13:53:08 192.168.0.201 DFFSTAT[0x33]
Jun 19 13:53:08 192.168.0.201  
Jun 19 13:53:08 192.168.0.201  
Jun 19 13:53:08 192.168.0.201 SCSISIGI[0x0]
Jun 19 13:53:08 192.168.0.201  
Jun 19 13:53:08 192.168.0.201 SCSIPHASE[0x0]
Jun 19 13:53:08 192.168.0.201  
Jun 19 13:53:08 192.168.0.201 SCSIBUS[0x0]
Jun 19 13:53:08 192.168.0.201  
Jun 19 13:53:08 192.168.0.201 LASTPHASE[0x1]
Jun 19 13:53:08 192.168.0.201  
Jun 19 13:53:08 192.168.0.201  
Jun 19 13:53:08 192.168.0.201 SCSISEQ0[0x0]
Jun 19 13:53:08 192.168.0.201  
Jun 19 13:53:08 192.168.0.201 SCSISEQ1[0x12]
Jun 19 13:53:08 192.168.0.201  
Jun 19 13:53:08 192.168.0.201 SEQCTL0[0x0]
Jun 19 13:53:08 192.168.0.201  
Jun 19 13:53:08 192.168.0.201 SEQINTCTL[0x0]
Jun 19 13:53:08 192.168.0.201  
Jun 19 13:53:08 192.168.0.201  
Jun 19 13:53:08 192.168.0.201 SEQ_FLAGS[0x0]
Jun 19 13:53:08 192.168.0.201  
Jun 19 13:53:08 192.168.0.201 SEQ_FLAGS2[0x4]
Jun 19 13:53:08 192.168.0.201  
Jun 19 13:53:08 192.168.0.201 QFREEZE_COUNT[0x3]
Jun 19 13:53:08 192.168.0.201  
Jun 19 13:53:08 192.168.0.201  
Jun 19 13:53:08 192.168.0.201 KERNEL_QFREEZE_COUNT[0x3]
Jun 19 13:53:08 192.168.0.201  
Jun 19 13:53:08 192.168.0.201 MK_MESSAGE_SCB[0xff00]
Jun 19 13:53:08 192.168.0.201  
Jun 19 13:53:08 192.168.0.201  
Jun 19 13:53:08 192.168.0.201 MK_MESSAGE_SCSIID[0xff]
Jun 19 13:53:08 192.168.0.201  
Jun 19 13:53:08 192.168.0.201 SSTAT0[0x0]
Jun 19 13:53:08 192.168.0.201  
Jun 19 13:53:08 192.168.0.201 SSTAT1[0x20]
Jun 19 13:53:08 192.168.0.201  
Jun 19 13:53:08 192.168.0.201  
Jun 19 13:53:08 192.168.0.201 SSTAT2[0x0]
Jun 19 13:53:08 192.168.0.201  
Jun 19 13:53:08 192.168.0.201 last message repeated 2 times
Jun 19 13:53:08 192.168.0.201  0x0
Jun 19 13:53:08 192.168.0.201 WAITING_TID_QUEUES: 
Jun 19 13:53:08 192.168.0.201 SCB_CONTROL[0x6a]
Jun 19 13:53:08 192.168.0.201 Total 3 
Jun 19 13:53:08 192.168.0.201 4 
Jun 19 13:53:08 192.168.0.201  
Jun 19 13:53:08 192.168.0.201 last message repeated 5 times
Jun 19 13:53:08 192.168.0.201 scsi0: FIFO1 Free, LONGJMP == 0x8063, SCB 0x2 
Jun 19 13:53:08 192.168.0.201 SG_STATE[0x0]
Jun 19 13:53:08 192.168.0.201 SOFFCNT[0x0]
Jun 19 13:53:08 192.168.0.201 0x8 
Jun 19 13:53:08 192.168.0.201 0x0 
Jun 19 13:53:08 192.168.0.201 0x0 
Jun 19 13:53:08 192.168.0.201 scsi0: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x1 
Jun 19 13:53:08 192.168.0.201  
Jun 19 13:53:08 192.168.0.201 CDB 35 0 0 0 0 0 
Jun 19 13:53:08 192.168.0.201  0x0
Jun 19 13:53:08 192.168.0.201 sd 0:0:2:0: rejecting I/O to offline device 
Jun 19 13:53:08 192.168.0.201 sd 0:0:2:0: rejecting I/O to offline device 
Jun 19 13:53:08 192.168.0.201 raid5: Disk failure on sdc3, disabling device. Operation continuing on 1 devices 
Jun 19 13:53:08 192.168.0.201 raid5: Disk failure on sdb3, disabling device. Operation continuing on 0 devices 
Jun 19 13:53:08 192.168.0.201 I/O error in filesystem ("dm-3") meta-data dev dm-3 block 0x3c08fcd       ("xlog_iodone") error 5 buf count 1024 
Jun 19 13:53:08 192.168.0.201  --- rd:3 wd:0 fd:3 
Jun 19 13:53:08 192.168.0.201  disk 2, o:0, dev:sdc3 
Jun 19 13:53:08 192.168.0.201 Filesystem "dm-3": Log I/O Error Detected.  Shutting down filesystem: dm-3 
Jun 19 13:53:08 192.168.0.6 kernel: sd 0:0:2:0: Attempting to queue an ABORT message:CDB: 0x35 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 
Jun 19 13:53:08 192.168.0.6 kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<< 
Jun 19 13:53:08 192.168.0.6 kernel: SSTAT2[0x0] SSTAT3[0x0] PERRDIAG[0x0] SIMODE1[0xa4]  
Jun 19 13:53:08 192.168.0.6 kernel: LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0x0] LQOSTAT0[0x0]  
Jun 19 13:53:08 192.168.0.6 kernel: LQOSTAT1[0x0] LQOSTAT2[0xe1]  
Jun 19 13:53:08 192.168.0.6 kernel:  
Jun 19 13:53:08 192.168.0.6 kernel: SCB Count = 12 CMDS_PENDING = 0 LASTSCB 0x3 CURRSCB 0x3 NEXTSCB 0xff40 
Jun 19 13:53:08 192.168.0.6 kernel: qinstart = 11642 qinfifonext = 11644 
Jun 19 13:53:08 192.168.0.6 kernel: QINFIFO: 0x3 0x0 
Jun 19 13:53:08 192.168.0.6 kernel: WAITING_TID_QUEUES: 
Jun 19 13:53:08 192.168.0.6 kernel: Pending list: 
Jun 19 13:53:08 192.168.0.6 kernel:   0 FIFO_USE[0x0] SCB_CONTROL[0x6a] SCB_SCSIID[0x27]  
Jun 19 13:53:08 192.168.0.6 kernel:   3 FIFO_USE[0x0] SCB_CONTROL[0x6a] SCB_SCSIID[0x17]  
Jun 19 13:53:08 192.168.0.6 kernel: Total 2 
Jun 19 13:53:08 192.168.0.6 kernel: Kernel Free SCB list: 8 6 7 10 4 9 1 2 5 11  
Jun 19 13:53:08 192.168.0.6 kernel: Sequencer Complete DMA-inprog list:  
Jun 19 13:53:08 192.168.0.6 kernel: Sequencer Complete list:  
Jun 19 13:53:08 192.168.0.6 kernel: Sequencer DMA-Up and Complete list:  
Jun 19 13:53:08 192.168.0.6 kernel: Sequencer On QFreeze and Complete list:  
Jun 19 13:53:08 192.168.0.6 kernel:  
Jun 19 13:53:08 192.168.0.6 kernel:  
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: FIFO0 Free, LONGJMP == 0x8071, SCB 0x3 
Jun 19 13:53:08 192.168.0.6 kernel: SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x4] DFSTATUS[0x89]  
Jun 19 13:53:08 192.168.0.6 kernel: SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0]  
Jun 19 13:53:08 192.168.0.6 kernel: SOFFCNT[0x0] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0  
Jun 19 13:53:08 192.168.0.6 kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10]  
Jun 19 13:53:08 192.168.0.6 kernel:  
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: FIFO1 Free, LONGJMP == 0x8063, SCB 0x2 
Jun 19 13:53:08 192.168.0.6 kernel: SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89]  
Jun 19 13:53:08 192.168.0.6 kernel: SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0]  
Jun 19 13:53:08 192.168.0.6 kernel: SOFFCNT[0x0] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0  
Jun 19 13:53:08 192.168.0.6 kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10]  
Jun 19 13:53:08 192.168.0.6 kernel: LQIN: 0x8 0x0 0x0 0x3 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0  
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: LQISTATE = 0x0, LQOSTATE = 0x0, OPTIONMODE = 0x52 
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x1 
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: SAVED_SCSIID = 0x0 SAVED_LUN = 0x0 
Jun 19 13:53:08 192.168.0.6 kernel: SIMODE0[0xc]  
Jun 19 13:53:08 192.168.0.6 kernel: CCSCBCTL[0x0]  
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: REG0 == 0xa, SINDEX = 0x104, DINDEX = 0x104 
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: SCBPTR == 0x3, SCB_NEXT == 0xff40, SCB_NEXT2 == 0xffca 
Jun 19 13:53:08 192.168.0.6 kernel: CDB 35 0 0 0 0 0 
Jun 19 13:53:08 192.168.0.6 kernel: STACK: 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 
Jun 19 13:53:08 192.168.0.6 kernel: <<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>> 
Jun 19 13:53:08 192.168.0.6 kernel: scsi0:0:2:0: Cmd aborted from QINFIFO 
Jun 19 13:53:08 192.168.0.6 kernel: sd 0:0:2:0: Attempting to queue an ABORT message:CDB: 0x0 0x0 0x0 0x0 0x0 0x0 
Jun 19 13:53:08 192.168.0.6 kernel: Infinite interrupt loop, INTSTAT = 8scsi0: At time of recovery, card was paused 
Jun 19 13:53:08 192.168.0.6 kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<< 
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: Dumping Card State at program address 0x0 Mode 0x33 
Jun 19 13:53:08 192.168.0.6 kernel: Card was paused 
Jun 19 13:53:08 192.168.0.6 kernel: INTSTAT[0x8] SELOID[0x1] SELID[0x10] HS_MAILBOX[0x0]  
Jun 19 13:53:08 192.168.0.6 kernel: INTCTL[0x80] SEQINTSTAT[0x0] SAVED_MODE[0x11] DFFSTAT[0x33]  
Jun 19 13:53:08 192.168.0.6 kernel: SCSISIGI[0x0] SCSIPHASE[0x0] SCSIBUS[0x0] LASTPHASE[0x1]  
Jun 19 13:53:08 192.168.0.6 kernel: SCSISEQ0[0x0] SCSISEQ1[0x12] SEQCTL0[0x0] SEQINTCTL[0x0]  
Jun 19 13:53:08 192.168.0.6 kernel: SEQ_FLAGS[0x0] SEQ_FLAGS2[0x4] QFREEZE_COUNT[0x3]  
Jun 19 13:53:08 192.168.0.6 kernel: KERNEL_QFREEZE_COUNT[0x3] MK_MESSAGE_SCB[0xff00]  
Jun 19 13:53:08 192.168.0.6 kernel: MK_MESSAGE_SCSIID[0xff] SSTAT0[0x0] SSTAT1[0x20]  
Jun 19 13:53:08 192.168.0.6 kernel: SSTAT2[0x0] SSTAT3[0x0] PERRDIAG[0x0] SIMODE1[0xa4]  
Jun 19 13:53:08 192.168.0.6 kernel: LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0x0] LQOSTAT0[0x0]  
Jun 19 13:53:08 192.168.0.6 kernel: LQOSTAT1[0x0] LQOSTAT2[0xe1]  
Jun 19 13:53:08 192.168.0.6 kernel:  
Jun 19 13:53:08 192.168.0.6 kernel: SCB Count = 12 CMDS_PENDING = 0 LASTSCB 0x3 CURRSCB 0x3 NEXTSCB 0xff40 
Jun 19 13:53:08 192.168.0.6 kernel: qinstart = 11642 qinfifonext = 11644 
Jun 19 13:53:08 192.168.0.6 kernel: QINFIFO: 0x0 0x3 
Jun 19 13:53:08 192.168.0.6 kernel: WAITING_TID_QUEUES: 
Jun 19 13:53:08 192.168.0.6 kernel: Pending list: 
Jun 19 13:53:08 192.168.0.6 kernel:   3 FIFO_USE[0x0] SCB_CONTROL[0x6a] SCB_SCSIID[0x17]  
Jun 19 13:53:08 192.168.0.6 kernel:   0 FIFO_USE[0x0] SCB_CONTROL[0x6a] SCB_SCSIID[0x27]  
Jun 19 13:53:08 192.168.0.6 kernel: Total 2 
Jun 19 13:53:08 192.168.0.6 kernel: Kernel Free SCB list: 8 6 7 10 4 9 1 2 5 11  
Jun 19 13:53:08 192.168.0.6 kernel: Sequencer Complete DMA-inprog list:  
Jun 19 13:53:08 192.168.0.6 kernel: Sequencer Complete list:  
Jun 19 13:53:08 192.168.0.6 kernel: Sequencer DMA-Up and Complete list:  
Jun 19 13:53:08 192.168.0.6 kernel: Sequencer On QFreeze and Complete list:  
Jun 19 13:53:08 192.168.0.6 kernel:  
Jun 19 13:53:08 192.168.0.6 kernel:  
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: FIFO0 Free, LONGJMP == 0x8071, SCB 0x3 
Jun 19 13:53:08 192.168.0.6 kernel: SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x4] DFSTATUS[0x89]  
Jun 19 13:53:08 192.168.0.6 kernel: SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0]  
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: FIFO1 Free, LONGJMP == 0x8063, SCB 0x2 
Jun 19 13:53:08 192.168.0.6 kernel: SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89]  
Jun 19 13:53:08 192.168.0.6 kernel: SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0]  
Jun 19 13:53:08 192.168.0.6 kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10]  
Jun 19 13:53:08 192.168.0.6 kernel: LQIN: 0x8 0x0 0x0 0x3 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0  
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: SAVED_SCSIID = 0x0 SAVED_LUN = 0x0 
Jun 19 13:53:08 192.168.0.6 kernel: CCSCBCTL[0x0]  
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: REG0 == 0xa, SINDEX = 0x104, DINDEX = 0x104 
Jun 19 13:53:08 192.168.0.6 kernel: CDB 35 0 0 0 0 0 
Jun 19 13:53:08 192.168.0.6 kernel: STACK: 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 
Jun 19 13:53:08 192.168.0.6 kernel: <<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>> 
Jun 19 13:53:08 192.168.0.6 kernel: scsi0:0:2:0: Cmd aborted from QINFIFO 
Jun 19 13:53:08 192.168.0.6 kernel: sd 0:0:1:0: Attempting to queue an ABORT message:CDB: 0x35 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 
Jun 19 13:53:08 192.168.0.6 kernel: Infinite interrupt loop, INTSTAT = 8scsi0: At time of recovery, card was paused 
Jun 19 13:53:08 192.168.0.6 kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<< 
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: Dumping Card State at program address 0x0 Mode 0x33 
Jun 19 13:53:08 192.168.0.6 kernel: Card was paused 
Jun 19 13:53:08 192.168.0.6 kernel: INTSTAT[0x8] SELOID[0x1] SELID[0x10] HS_MAILBOX[0x0]  
Jun 19 13:53:08 192.168.0.6 kernel: INTCTL[0x80] SEQINTSTAT[0x0] SAVED_MODE[0x11] DFFSTAT[0x33]  
Jun 19 13:53:08 192.168.0.6 kernel: SCSISIGI[0x0] SCSIPHASE[0x0] SCSIBUS[0x0] LASTPHASE[0x1]  
Jun 19 13:53:08 192.168.0.6 kernel: SCSISEQ0[0x0] SCSISEQ1[0x12] SEQCTL0[0x0] SEQINTCTL[0x0]  
Jun 19 13:53:08 192.168.0.6 kernel: SEQ_FLAGS[0x0] SEQ_FLAGS2[0x4] QFREEZE_COUNT[0x3]  
Jun 19 13:53:08 192.168.0.6 kernel: KERNEL_QFREEZE_COUNT[0x3] MK_MESSAGE_SCB[0xff00]  
Jun 19 13:53:08 192.168.0.6 kernel: MK_MESSAGE_SCSIID[0xff] SSTAT0[0x0] SSTAT1[0x20]  
Jun 19 13:53:08 192.168.0.6 kernel: SSTAT2[0x0] SSTAT3[0x0] PERRDIAG[0x0] SIMODE1[0xa4]  
Jun 19 13:53:08 192.168.0.6 kernel: LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0x0] LQOSTAT0[0x0]  
Jun 19 13:53:08 192.168.0.6 kernel: LQOSTAT1[0x0] LQOSTAT2[0xe1]  
Jun 19 13:53:08 192.168.0.6 kernel:  
Jun 19 13:53:08 192.168.0.6 kernel: SCB Count = 12 CMDS_PENDING = 0 LASTSCB 0x3 CURRSCB 0x3 NEXTSCB 0xff40 
Jun 19 13:53:08 192.168.0.6 kernel: qinstart = 11642 qinfifonext = 11643 
Jun 19 13:53:08 192.168.0.6 kernel: QINFIFO: 0x0 
Jun 19 13:53:08 192.168.0.6 kernel: WAITING_TID_QUEUES: 
Jun 19 13:53:08 192.168.0.6 kernel: Pending list: 
Jun 19 13:53:08 192.168.0.6 kernel:   0 FIFO_USE[0x0] SCB_CONTROL[0x6a] SCB_SCSIID[0x27]  
Jun 19 13:53:08 192.168.0.6 kernel: Total 1 
Jun 19 13:53:08 192.168.0.6 kernel: Kernel Free SCB list: 3 8 6 7 10 4 9 1 2 5 11  
Jun 19 13:53:08 192.168.0.6 kernel: Sequencer Complete DMA-inprog list:  
Jun 19 13:53:08 192.168.0.6 kernel: Sequencer Complete list:  
Jun 19 13:53:08 192.168.0.6 kernel: Sequencer DMA-Up and Complete list:  
Jun 19 13:53:08 192.168.0.6 kernel: Sequencer On QFreeze and Complete list:  
Jun 19 13:53:08 192.168.0.6 kernel:  
Jun 19 13:53:08 192.168.0.6 kernel:  
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: FIFO0 Free, LONGJMP == 0x8071, SCB 0x3 
Jun 19 13:53:08 192.168.0.6 kernel: SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x4] DFSTATUS[0x89]  
Jun 19 13:53:08 192.168.0.6 kernel: SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0]  
Jun 19 13:53:08 192.168.0.6 kernel: SOFFCNT[0x0] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0  
Jun 19 13:53:08 192.168.0.6 kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10]  
Jun 19 13:53:08 192.168.0.6 kernel:  
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: FIFO1 Free, LONGJMP == 0x8063, SCB 0x2 
Jun 19 13:53:08 192.168.0.6 kernel: SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89]  
Jun 19 13:53:08 192.168.0.6 kernel: SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0]  
Jun 19 13:53:08 192.168.0.6 kernel: SOFFCNT[0x0] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0  
Jun 19 13:53:08 192.168.0.6 kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10]  
Jun 19 13:53:08 192.168.0.6 kernel: LQIN: 0x8 0x0 0x0 0x3 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0  
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: LQISTATE = 0x0, LQOSTATE = 0x0, OPTIONMODE = 0x52 
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x1 
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: SAVED_SCSIID = 0x0 SAVED_LUN = 0x0 
Jun 19 13:53:08 192.168.0.6 kernel: SIMODE0[0xc]  
Jun 19 13:53:08 192.168.0.6 kernel: CCSCBCTL[0x0]  
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: REG0 == 0xa, SINDEX = 0x104, DINDEX = 0x104 
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: SCBPTR == 0x3, SCB_NEXT == 0xff40, SCB_NEXT2 == 0xffca 
Jun 19 13:53:08 192.168.0.6 kernel: CDB 35 0 0 0 0 0 
Jun 19 13:53:08 192.168.0.6 kernel: STACK: 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 
Jun 19 13:53:08 192.168.0.6 kernel: <<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>> 
Jun 19 13:53:08 192.168.0.6 kernel: scsi0:0:1:0: Cmd aborted from QINFIFO 
Jun 19 13:53:08 192.168.0.6 kernel: sd 0:0:1:0: Attempting to queue an ABORT message:CDB: 0x0 0x0 0x0 0x0 0x0 0x0 
Jun 19 13:53:08 192.168.0.6 kernel: Infinite interrupt loop, INTSTAT = 8scsi0: At time of recovery, card was paused 
Jun 19 13:53:08 192.168.0.6 kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<< 
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: Dumping Card State at program address 0x0 Mode 0x33 
Jun 19 13:53:08 192.168.0.6 kernel: Card was paused 
Jun 19 13:53:08 192.168.0.6 kernel: INTSTAT[0x8] SELOID[0x1] SELID[0x10] HS_MAILBOX[0x0]  
Jun 19 13:53:08 192.168.0.6 kernel: INTCTL[0x80] SEQINTSTAT[0x0] SAVED_MODE[0x11] DFFSTAT[0x33]  
Jun 19 13:53:08 192.168.0.6 kernel: SCSISEQ0[0x0] SCSISEQ1[0x12] SEQCTL0[0x0] SEQINTCTL[0x0]  
Jun 19 13:53:08 192.168.0.6 kernel: KERNEL_QFREEZE_COUNT[0x3] MK_MESSAGE_SCB[0xff00]  
Jun 19 13:53:08 192.168.0.6 kernel: SSTAT2[0x0] SSTAT3[0x0] PERRDIAG[0x0] SIMODE1[0xa4]  
Jun 19 13:53:08 192.168.0.6 kernel: LQOSTAT1[0x0] LQOSTAT2[0xe1]  
Jun 19 13:53:08 192.168.0.6 kernel: SCB Count = 12 CMDS_PENDING = 0 LASTSCB 0x3 CURRSCB 0x3 NEXTSCB 0xff40 
Jun 19 13:53:08 192.168.0.6 kernel: QINFIFO: 0x0 
Jun 19 13:53:08 192.168.0.6 kernel: Pending list: 
Jun 19 13:53:08 192.168.0.6 kernel: Total 1 
Jun 19 13:53:08 192.168.0.6 kernel: Sequencer Complete DMA-inprog list:  
Jun 19 13:53:08 192.168.0.6 kernel: Sequencer DMA-Up and Complete list:  
Jun 19 13:53:08 192.168.0.6 kernel:  
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: FIFO0 Free, LONGJMP == 0x8071, SCB 0x3 
Jun 19 13:53:08 192.168.0.6 kernel: SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0]  
Jun 19 13:53:08 192.168.0.6 kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10]  
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: FIFO1 Free, LONGJMP == 0x8063, SCB 0x2 
Jun 19 13:53:08 192.168.0.6 kernel: SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0]  
Jun 19 13:53:08 192.168.0.6 kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10]  
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: LQISTATE = 0x0, LQOSTATE = 0x0, OPTIONMODE = 0x52 
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: SAVED_SCSIID = 0x0 SAVED_LUN = 0x0 
Jun 19 13:53:08 192.168.0.6 kernel: CCSCBCTL[0x0]  
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: SCBPTR == 0x3, SCB_NEXT == 0xff40, SCB_NEXT2 == 0xffca 
Jun 19 13:53:08 192.168.0.6 kernel: STACK: 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 
Jun 19 13:53:08 192.168.0.6 kernel: scsi0:0:1:0: Cmd aborted from QINFIFO 
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: Device reset code sleeping 
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: Device reset returning 0x2003 
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: Device reset code sleeping 
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: Device reset returning 0x2003 
Jun 19 13:53:08 192.168.0.6 kernel: sd 0:0:2:0: Attempting to queue an ABORT message:CDB: 0x0 0x0 0x0 0x0 0x0 0x0 
Jun 19 13:53:08 192.168.0.6 kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<< 
Jun 19 13:53:08 192.168.0.6 kernel: Card was paused 
Jun 19 13:53:08 192.168.0.6 kernel: INTCTL[0x80] SEQINTSTAT[0x0] SAVED_MODE[0x11] DFFSTAT[0x33]  
Jun 19 13:53:08 192.168.0.6 kernel: SCSISEQ0[0x0] SCSISEQ1[0x12] SEQCTL0[0x0] SEQINTCTL[0x0]  
Jun 19 13:53:08 192.168.0.6 kernel: KERNEL_QFREEZE_COUNT[0x3] MK_MESSAGE_SCB[0xff00]  
Jun 19 13:53:08 192.168.0.6 kernel: SSTAT2[0x0] SSTAT3[0x0] PERRDIAG[0x0] SIMODE1[0xa4]  
Jun 19 13:53:08 192.168.0.6 kernel: LQOSTAT1[0x0] LQOSTAT2[0xe1]  
Jun 19 13:53:08 192.168.0.6 kernel: SCB Count = 12 CMDS_PENDING = 0 LASTSCB 0x3 CURRSCB 0x3 NEXTSCB 0xff40 
Jun 19 13:53:08 192.168.0.6 kernel: QINFIFO: 0x0 0x3 0x8 
Jun 19 13:53:08 192.168.0.6 kernel: Pending list: 
Jun 19 13:53:08 192.168.0.6 kernel:   3 FIFO_USE[0x0] SCB_CONTROL[0x6a] SCB_SCSIID[0x17]  
Jun 19 13:53:08 192.168.0.6 kernel: Total 3 
Jun 19 13:53:08 192.168.0.6 kernel: Sequencer Complete DMA-inprog list:  
Jun 19 13:53:08 192.168.0.6 kernel: Sequencer DMA-Up and Complete list:  
Jun 19 13:53:08 192.168.0.6 kernel:  
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: FIFO0 Free, LONGJMP == 0x8071, SCB 0x3 
Jun 19 13:53:08 192.168.0.6 kernel: SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0]  
Jun 19 13:53:08 192.168.0.6 kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10]  
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: FIFO1 Free, LONGJMP == 0x8063, SCB 0x2 
Jun 19 13:53:08 192.168.0.6 kernel: SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0]  
Jun 19 13:53:08 192.168.0.6 kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10]  
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: LQISTATE = 0x0, LQOSTATE = 0x0, OPTIONMODE = 0x52 
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: SAVED_SCSIID = 0x0 SAVED_LUN = 0x0 
Jun 19 13:53:08 192.168.0.6 kernel: CCSCBCTL[0x0]  
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: SCBPTR == 0x3, SCB_NEXT == 0xff40, SCB_NEXT2 == 0xffca 
Jun 19 13:53:08 192.168.0.6 kernel: Infinite interrupt loop, INTSTAT = 8scsi0: At time of recovery, card was paused 
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: Dumping Card State at program address 0x0 Mode 0x33 
Jun 19 13:53:08 192.168.0.6 kernel: INTSTAT[0x8] SELOID[0x1] SELID[0x10] HS_MAILBOX[0x0]  
Jun 19 13:53:08 192.168.0.6 kernel: MK_MESSAGE_SCSIID[0xff] SSTAT0[0x0] SSTAT1[0x20]  
Jun 19 13:53:08 192.168.0.6 kernel: qinstart = 11642 qinfifonext = 11645 
Jun 19 13:53:08 192.168.0.6 kernel:   0 FIFO_USE[0x0] SCB_CONTROL[0x6a] SCB_SCSIID[0x27]  
Jun 19 13:53:08 192.168.0.6 kernel: SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x4] DFSTATUS[0x89]  
Jun 19 13:53:08 192.168.0.6 kernel: SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89]  
Jun 19 13:53:08 192.168.0.6 kernel: scsi0: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x1 
Jun 19 13:53:08 192.168.0.6 kernel: sd 0:0:2:0: rejecting I/O to offline device 
Jun 19 13:53:08 192.168.0.6 kernel: I/O error in filesystem ("dm-3") meta-data dev dm-3 block 0x3c08fcd       ("xlog_iodone") error 5 buf count 1024 
Jun 19 13:53:08 192.168.0.6 kernel: lost page write due to I/O error on dm-3 

--------------060801050702060606090203--
