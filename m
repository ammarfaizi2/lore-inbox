Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267284AbTBUAgf>; Thu, 20 Feb 2003 19:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267288AbTBUAgf>; Thu, 20 Feb 2003 19:36:35 -0500
Received: from services.erkkila.org ([24.97.94.217]:5258 "EHLO erkkila.org")
	by vger.kernel.org with ESMTP id <S267284AbTBUAgd>;
	Thu, 20 Feb 2003 19:36:33 -0500
Message-ID: <3E5576E5.7070206@erkkila.org>
Date: Fri, 21 Feb 2003 00:46:29 +0000
From: "Paul E. Erkkila" <pee@erkkila.org>
Reply-To: pee@erkkila.org
Organization: ErkkilaDotOrg
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030218
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Jens Axboe <axboe@suse.de>
Subject: BUG() kernel/timer.c:154 , aborting ide-scsi 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got this bug doing some testing with gnu vcdimager.  I hit cntr
c to break to I could change disks. vcdimager was from cvs (today)
command was : vcdxrip --cdrom-device=/dev/scd0

Kernel is 2.5.62 from bitkeeper , pulled yesterday evening. Drive
is a SONY DRU 500A(X) firmware 2.0c

ksymoops:

ide-scsi: abort called for 2982
ide-scsi: reset called for 2982
hdc: DMA disabled

kernel BUG at kernel/timer.c:154!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c012271c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: 00000001   ebx: dfc96880   ecx: c03b05a0   edx: c04638e8
esi: dfc968a4   edi: c0265d09   ebp: c17c1eec   esp: c17c1edc
ds: 007b   es: 007b   ss: 0068
Stack: c04638e8 00000000 dfc96880 00000092 c17c1f10 c0265c51 dfc968a4 
c04638e8
       c17c1f10 00000000 00000000 00000000 c04638e8 c17c1f40 c02662f2 
c04638e8
       c0265d09 00000032 00000000 dfc96880 c046383c 00000096 00000000 
c04638e8
Call Trace:
 [<c0265c51>] ide_set_handler+0x48/0x73
 [<c02662f2>] do_reset1+0x211/0x22e
 [<c0265d09>] atapi_reset_pollfunc+0x0/0x11a
 [<c026633d>] ide_do_reset+0x2e/0x62
 [<c028342c>] idescsi_reset+0xc3/0xf9
 [<c027c9d8>] scsi_try_bus_device_reset+0x46/0x65
 [<c027ca69>] scsi_eh_bus_device_reset+0x72/0xde
 [<c027d251>] scsi_unjam_host+0xb0/0xe3
 [<c010a0a2>] __down_failed_interruptible+0xa/0x10
 [<c027d39d>] scsi_error_handler+0x119/0x16e
 [<c027d284>] scsi_error_handler+0x0/0x16e
 [<c0109039>] kernel_thread_helper+0x5/0xb
Code: 0f 0b 9a 00 a2 af 33 c0 eb bf 55 31 c0 89 e5 83 ec 10 89 75
 
 
 >>EIP; c012271c <add_timer+5f/69>   <=====
 
 >>ecx; c03b05a0 <tvec_bases__per_cpu+0/101c>
 >>edx; c04638e8 <ide_hwifs+928/54d8>
 >>edi; c0265d09 <atapi_reset_pollfunc+0/11a>
 
Trace; c0265c51 <ide_set_handler+48/73>
Trace; c02662f2 <do_reset1+211/22e>
Trace; c0265d09 <atapi_reset_pollfunc+0/11a>
Trace; c026633d <ide_do_reset+2e/62>
Trace; c028342c <idescsi_attach+92/102>
Trace; c027c9d8 <scsi_try_bus_reset+17/dc>
Trace; c027ca69 <scsi_try_bus_reset+a8/dc>
Trace; c027d251 <scsi_error_handler+e1/16e>
Trace; c010a0a2 <__down_failed_interruptible+a/10>
Trace; c027d39d <scsi_reset_provider+5e/111>
Trace; c027d284 <scsi_error_handler+114/16e>
Trace; c0109039 <kernel_thread_helper+5/b>
 
Code;  c012271c <add_timer+5f/69>
00000000 <_EIP>:
Code;  c012271c <add_timer+5f/69>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012271e <add_timer+61/69>
   2:   9a 00 a2 af 33 c0 eb      lcall  $0xebc0,$0x33afa200
Code;  c0122725 <add_timer+68/69>
   9:   bf 55 31 c0 89            mov    $0x89c03155,%edi
Code;  c012272a <add_timer_on+4/69>
   e:   e5 83                     in     $0x83,%eax
Code;  c012272c <add_timer_on+6/69>
  10:   ec                        in     (%dx),%al
Code;  c012272d <add_timer_on+7/69>
  11:   10 89 75 00 00 00         adc    %cl,0x75(%ecx)



