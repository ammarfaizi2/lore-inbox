Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbUCED1X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 22:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbUCED1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 22:27:22 -0500
Received: from mail-ksi.ksimaging.com ([65.166.77.7]:26129 "EHLO
	mail-ksi.ksimaging.com") by vger.kernel.org with ESMTP
	id S262172AbUCED1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 22:27:17 -0500
Message-ID: <BDF8E7450E9ED311A5500090273CC5280629A4E9@mail-ksi.ksimaging.com>
From: "Dubler, Raymond" <RDubler@ksimaging.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: ide scsi dvd+rw udf kernel panic
Date: Thu, 4 Mar 2004 19:26:21 -0800 
X-Mailer: Internet Mail Service (5.5.2653.19)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are getting kernel panics while writing real-time video data (~750KBps)
to both hard disk (Ext3) and dvd+rw media (UDF).  The hardware and software
configuration along with the kernel oops message follow.  Any information as
to how this is happening would be helpful.

Thanks,
Remo

Hardware configuration:
	MIC E210882 motherboard (FW82815 chipset)
	256MB PC-100 RAM
	Primary IDE Master: DiamondMax Plus 8 (40GB) [cable select] /dev/hda
udma5
	Primary IDE Slave:  HP 200j v1.27 DVD Writer [cable select]
/dev/scd0 (via ide-scsi emulation) udma2
	
Software configuration:
	Distribution: Linux From Scratch (LFS) 4.0
	Kernel: 2.4.20
	1st patch: packet-2.4.20-2.patch
(http://w1.894.telia.com/~u89404340/patches/packet/2.4/old/)
	2nd patch: dvd-packet-2.4.20.patch
(http://w1.894.telia.com/~u89404340/patches/packet/2.4/)

Kernel Panic Messages:

Unable to handle kernel NULL pointer dereference at virtual address 00000018
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0010:[<d4a8d8db>] Tainted: P
EFLAGS: 00010286
eax: ceb12c80   ebx: c034ee20   ecx: cea41bc0   edx: cea41bc0
esi: 00000000   edi: 00000040   ebp: 00000000   esp: c02afe90
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02af000)
Stack: c01dd0bc 00000384 00000001 00000082 ceb12c80 00000000 c034ee20
00000040
       c034eca0 c01dd4a6 c034ee20 00000000 00000000 00000088 00000003
00000000
       c12d1d60 00000296 00000000 cfac2160 c034ee20 cfac2160 cea41bc0
c034eca0
Call Trace:    [<c01dd0bc>] [<c01dd4a6>] [<c01dd6ae>] [<c01dd98d>]
[<c01dd8a0>]
  [<c012167b>] [<c011d332>] [<c011d246>] [<c011d085>] [<c0108b9e>]
[<c0105360>]
  [<c010b208>] [<c0105360>] [<c0105383>] [<c0105412>] [<c0105000>]

Code: 8b 56 18 89 70 04 8b 46 1c c7 46 10 00 00 00 00 8b 7e 0c 89
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing



Call Trace:    
c01dd0bc	ide_wait_stat     c01dcff0
c01dd4a6	start_request     c01dd2e0
c01dd6ae	ide_do_request    c01dd5e0
c01dd98d	ide_timer_expiry  c01dd8a0
c01dd8a0	ide_timer_expiry  c01dd8a0
c012167b	run_timer_list    c0121570
c011d332	bh_action         c011d310
c011d246	tasklet_hi_action c011d200
c011d085	do_softirq        c011cff0
c0108b9e	do_IRQ            c0108b00
c0105360	default_idle      c0105360
c010b208	call_do_IRQ       c010b203
c0105360	default_idle      c0105360
c0105383	default_idle      c0105360
c0105412	cpu_idle          c01053c0
c0105000	rest_init         c0105000


Stack: 
c01dd0bc	ide_wait_stat
00000384	
00000001	
00000082	
ceb12c80	
00000000	 
c034ee20	ide_hwifs (c034eca0)
00000040	
c034eca0	ide_hwifs (c034eca0)
c01dd4a6	start_request (c01dd2e0)
c034ee20	ide_hwifs (c034eca0)
00000000	
00000000	
00000088	
00000003	
00000000	
c12d1d60	
00000296	
00000000	
cfac2160	
c034ee20	ide_hwifs (c034eca0)
cfac2160	
cea41bc0	
c034eca0	ide_hwifs (c034eca0)


========================================================================

Unable to handle kernel NULL Pointer dereference at virtual address 00000018
*pde = 0
Oops: 0002
CPU: 0
eip: 0010 [<d4a8d594>] Tainted: P
EFLAGS: 00010202
eax: 0 ebx: cfac2101 ecx: 0 edx: 0000001f7
esi: c694d800 edi: c034ee20 ebp: ce792620 esp: c02aff18
ds: 0018  es: 0018 ss: 0018
Process swapper pid 0 stackpage=c02af000
Stack
00000000 00000282 c01155b0 c02aff30 00000000 cfac2160 c034ee20 00000282
c034eca0 c01ddbd9 c034ee20 00000000 d4a8d540 c12c6800 04000001 c02affa0
0000000e c01089e5 0000000e cfac2160 c02affa0 c0326ac0 0000000e 000001c0
Call Trace
c01155b0 c01ddbd9 4da8d540 c01089e5 c0108b64 c0105360 c010b208 c0105360
c0105383 c0105412 c0105000 

Code
ff 41 18 8b 87 e4 00 00 00 8b 40 04 c7 04 24 01 00 00 00 89

Stack
00000000 
00000282 
c01155b0 	process_timeout (c01155b0)
c02aff30 	init_task_union (c02ae000)
00000000 
cfac2160 
c034ee20 	ide_hwifs (c034eca0)
00000282 
c034eca0 	ide_hwifs (c034eca0)
c01ddbd9 	ide_intr (c01ddb20)
c034ee20 	ide_hwifs (c034eca0)
00000000 
d4a8d540 
c12c6800 
04000001 
c02affa0 	init_task_union (c02ae000)
0000000e 
c01089e5 	handle_IRQ_event (c01089a0)
0000000e 
cfac2160 
c02affa0 	init_task_union (c02ae000)
c0326ac0 	irq_desc (c0326900)
0000000e 
000001c0

Call trace:
c01155b0 	process_timeout (c01155b0)
c01ddbd9 	ide_intr (c01ddb20)
4da8d540 
c01089e5 	handle_IRQ_event (c01089a0)
c0108b64 	do_IRQ
c0105360 	default_idle
c010b208 	call_do_IRQ
c0105360	default_idle
c0105383 	default_idle
c0105412 	cpu_idle
c0105000 	rest_init / _stext / stext ???

****************************************************************************
*********************
WARNING: E-MAILS CAN BE ALTERED, INTERCEPTED AND READ BY PERSONS OTHER THAN
THOSE FOR WHOM THE MESSAGES ARE INTENDED. Therefore, unless encrypted and
signed, the integrity of this and all other electronic communications cannot
be guaranteed.
