Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319229AbSHNGeq>; Wed, 14 Aug 2002 02:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319231AbSHNGeq>; Wed, 14 Aug 2002 02:34:46 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:20735 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S319229AbSHNGep>; Wed, 14 Aug 2002 02:34:45 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Ivan Gyurdiev <ivangurdiev@attbi.com>
Reply-To: ivangurdiev@attbi.com
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.5.31 SCSI emulation and cd burner....severe filesystem corruption
Date: Sun, 11 Aug 2002 10:46:44 -0400
User-Agent: KMail/1.4.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200208111046.44879.ivangurdiev@attbi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I'm out of my mind... I'm aware of that... 
But that's just me... I'm a forward looking person
so I just have to run the latest 2.5 kernel :)

Here's my story...you decide where and what the problem is...
There might be several unrelated problems, but there's a minimum of one,
since I have a kernel oops to support it.
========================================

I purchased a brand new Toshiba 8x8x8x32 burner
and decided to test it out on my 2.5.31 kernel.
I've been running 2.5 kernels for several weeks with my IDE
IBM drive and no problems at all.

So I configured the drive with SCSI emulation
and the SCSI-CDROM and SCSI-generic support, disabling IDE ATAPI support.
I configured xcdroast, and tried to burn an image.
The result was a drive that kept powering up and shutting down, with the
yellow light on most of the time... X froze, keyboard froze, mouse froze...
Sysrq - sync, unmount, reboot.
Tried it again, same thing. This time fsck refused to work on machine powerup.
It froze. I powered up my backup system and did fsck on /. The system showed 
clean. Forced fsck detected massive filesystem corruption erasing important 
libraries which took a while to recover.

Some people just don't learn, though. So I fixed all the important stuff,
and tried it again, this time with DMA for CD disabled, since someone hinted 
me that it could cause problems. Exactly the same thing happend.
I managed to kill X somehow and CTRL-ALT-DEL while my burner
was still trying to do something. The result was a kernel oops.
After another forced fsck I lost most symlinks in /etc, kernel sources and 
parts of glibc... when I fixed some of it, I did: ksymoops /var/log/messages
to get this:  (this is the oops on attempted machine shutdown while the 
burner was trying to burn a CD)
=======================================================
I should mention this machine is a uniprocessor Athlon XP 1600+ with
local APIC enabled and I/O apic disabled. I use acpi.
=======================================================

>>EIP; c0113b7f <smp_apic_timer_interrupt+f/100>   <=====

>>eax; c032c000 <init_thread_union+0/2000>
>>ebx; d3ebd800 <END_OF_CODE+13b146c4/????>
>>ecx; 00f5cae7 Before first symbol
>>esi; d3ebd8ac <END_OF_CODE+13b14770/????>
>>edi; 00004008 Before first symbol
>>ebp; c032df5c <init_thread_union+1f5c/2000>
>>esp; c032df50 <init_thread_union+1f50/2000>

Trace; c0109402 <apic_timer_interrupt+1a/20>
Trace; c01c8447 <acpi_processor_idle+177/230>
Trace; c0107170 <default_idle+0/30>
Trace; c01c82d0 <acpi_processor_idle+0/230>
Trace; c0107170 <default_idle+0/30>
Trace; c0107211 <cpu_idle+31/40>
Trace; c0105000 <_stext+0/0>

Code;  c0113b7f <smp_apic_timer_interrupt+f/100>
00000000 <_EIP>:
Code;  c0113b7f <smp_apic_timer_interrupt+f/100>   <=====
   0:   c7 05 b0 e0 ff ff 00      movl   $0x0,0xffffe0b0   <=====
Code;  c0113b86 <smp_apic_timer_interrupt+16/100>
   7:   00 00 00 
Code;  c0113b89 <smp_apic_timer_interrupt+19/100>
   a:   ff 05 00 91 37 c0         incl   0xc0379100
Code;  c0113b8f <smp_apic_timer_interrupt+1f/100>
  10:   81 40 10 00 00 00 00      addl   $0x0,0x10(%eax)

Aug 13 01:36:47 cobra kernel:  <0>Kernel panic: Attempted to kill the idle 
task!

2 warnings issued.  Results may not be reliable.





