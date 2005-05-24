Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVEXJI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVEXJI4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 05:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVEXJI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:08:56 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:4756 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S261453AbVEXJIr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:08:47 -0400
To: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
Cc: mjbligh <Martin.Bligh@us.ibm.com>, pbadari <pbadari@us.ibm.com>
MIME-Version: 1.0
Subject: kdump test update
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFA0D3C130.0ED83C93-ON6525700B.0030EAEB-6525700B.0032C0D5@in.ibm.com>
From: Nagesh Sharyathi <sharyathi@in.ibm.com>
Date: Tue, 24 May 2005 14:38:42 +0530
X-MIMETrack: Serialize by Router on d23m0069/23/M/IBM(Release 6.51HF653 | October 18, 2004) at
 24/05/2005 14:38:43
Content-Type: multipart/mixed; boundary="=_mixed 0032C0D36525700B_="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=_mixed 0032C0D36525700B_=
Content-Type: text/plain; charset="US-ASCII"

These I have tested on the kernel 2.6.12-rc4-mm1 with the following test
suites , with kdump enabled 

Once test suites PASS/SUCCESS, force the machine to hang(lock up) by 
disabling irqs with the attached SPINLOCK test module from Badari 
Pulavarthy, 
try to take dump either with sysrq key or nmi_watchdog=2 kernel parameter.

Test Suite: 
-----------
LTP Runall, FSracer(race condition in file system) with LVM partitions 
(over ext2, ext3, JFS, XFS), FS stress, Mem Test/Bash Memory, Cerberus, 
KernBench, NetPerf.

System Info:
------------
Distro: SLES 9 SP1

Software/kernel variables:
--------------------------
1. kernel - linux-2.6.12-rc4-mm1 
2. kexec-tools-1.101 + kdump patches
3. kernel.sysrq=1
 
Command line parameters for first kernel:
-----------------------------------------
  root = <> vga=0x31a selinux=0 splash=silent resume=<> elevator=cfq 
showpts
  crashkernel=48M@16M console=tty0 console=ttyS0,38400n1
 
Hardwares on which is test cases are run:
-----------------------------------------

A) 1way, Pentium IV 2.8GHz, 2G RAM
   - Network Interface (e1000)
   - Disk I/O: SCSI storage controller: Adaptec Ultra320

   o Ran test suite KERNBENCH and CERBERUS test ran successfully. Forced 
     system hang by inserting spinlock test module and tried to invoke 
     panic with sysrq+c, but it failed to force Panic. I failed to take 
the 
     dump as sysrq keys failed to respond during hang.

   o Booted with nmi_watchdog=2 and ran similar tests and then forced 
system 
     hang by inserting spinlock module, nmi_watchdog caused kernel panic 
and 
     the system booted to panic kernel. I was able to take dump. The first 

     kernel was rebuilt after applying Vivek's following patch to fix 
kexec 
     on panic with nmi watchdog enabled
                 
http://marc.theaimsgroup.com/?l=linux-kernel&m=111631994607762&w=2

B) SMP, 2way, Pentium III (Coppermine) 1 GHz, 1.3G RAM
   - Network Interface (e100)
   - Disk I/O: SCSI storage controller: Adaptec Ultra160

   o Ran test suite MemTest and Bash Memory, after running the test for 
some
     time (< 1hr.), forced system hang by inserting spinlock test module 
     and tried to invoke kernel panic with sysrq-c, but it failed to force 

     panic and hence couldn't initiate kdump. 

   o Booted with nmi_watchdog=2 and ran similar tests and then forced 
system 
     hang by inserting spinlock module, nmi_watchdog caused kernel panic 
and 
     the system booted to panic kernel. I was able to take dump. The first 

     kernel was rebuilt after applying Vivek's following patch to fix 
kexec 
     on panic with nmi watchdog enabled
                 
http://marc.theaimsgroup.com/?l=linux-kernel&m=111631994607762&w=2
 
   o Ran the same test suite, after running the test for more than 10hours 

     kernel OOps have occured (bugme 4653) but kdump failed to boot to 
     secondary kernel as there was no kernel panic and just an kernel 
oops.

     Now I have set kernel sysctl parameter kernel.panic_on_oops=1, 
testing in 
     progress to capture the oops in kdump 
 
   o While testing the functionality of kdump, encountered this driver 
hardening
     issue (bugme:4631) also.


C) SMP, 2way, Xeon TM 2.8GHz, 1.5G RAM
   - Network Interface (Tigon3)
   - Disk I/O: SCSI storage controller: IBM Serve RAID
 
   o Ran test suite FSracer over LVM partition and the test ran without 
     failures. Forced system hang by inserting spinlock test module and 
then 
     invoked kernel panic with sysrq-c. Secondary kernel booted properly 
     without any issues. I was able to take the dump using sysrq keys.


For more details please mail me

Attachment:

--=_mixed 0032C0D36525700B_=
Content-Type: application/octet-stream; name="spinlock.c"
Content-Disposition: attachment; filename="spinlock.c"
Content-Transfer-Encoding: base64

I2luY2x1ZGU8bGludXgvaW5pdC5oPg0KI2luY2x1ZGU8YXNtL3VhY2Nlc3MuaD4NCiNpbmNsdWRl
PGxpbnV4L3NwaW5sb2NrLmg+DQoNCnNwaW5sb2NrX3QgbXlsb2NrID0gU1BJTl9MT0NLX1VOTE9D
S0VEOw0KLy9zdGF0aWMgaW50IGhhbmdfaW5pdCh2b2lkKQ0Kc3RhdGljIGludCBfX2luaXQgaGFu
Z19pbml0KHZvaWQpDQp7DQoJc3Bpbl9sb2NrX2lycSgmbXlsb2NrKTsNCglzcGluX2xvY2tfaXJx
KCZteWxvY2spOw0KCXJldHVybigxKTsNCn0NCg0KbW9kdWxlX2luaXQoaGFuZ19pbml0KTsNCg0K

--=_mixed 0032C0D36525700B_=--
