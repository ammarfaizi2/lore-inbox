Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbUCPMNF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 07:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbUCPMNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 07:13:05 -0500
Received: from mail.cs.tu-berlin.de ([130.149.17.13]:38365 "EHLO
	mail.cs.tu-berlin.de") by vger.kernel.org with ESMTP
	id S261537AbUCPMM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 07:12:58 -0500
Date: Tue, 16 Mar 2004 13:08:59 +0100 (MET)
From: Peter Daum <gator@cs.tu-berlin.de>
Reply-To: Peter Daum <gator@cs.tu-berlin.de>
To: <linux-kernel@vger.kernel.org>, <linux-atm-general@lists.sourceforge.net>
Subject: ATM (LANE) - related Kernel-Crashes
Message-ID: <Pine.LNX.4.30.0403161249270.9408-100000@swamp.bayern.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a bunch of machines with Forerunner LE ATM NICS running LANE.
Already for years (the first such occurence was still with kernel
2.2.x) I have been struggeling with kernel crashes that occur in
irregular intervals and without any obvious system.

Further information can be found at:
http://sourceforge.net/tracker/index.php?func=detail&aid=917247&group_id=7812&atid=107812
http://sourceforge.net/tracker/index.php?func=detail&aid=445059&group_id=7812&atid=107812

Unfortunately, I usually don't have any reasonable possibility to capture
crash dump data. This time for the first time in a while, I managed to
get a stack trace (Kernel 2.4.25):

Oops: 0000
CPU:    0
EIP:    0010:[<c02a4f5b>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: c5934800   ebx: c645a080   ecx: c645a080   edx: 00000000
esi: 00000000   edi: 0000000e   ebp: c7fc0000   esp: c680fdf4
ds: 0018   es: 0018   ss: 0018
Process lt-zeppelin (pid: 107, stackpage=c680f000)
Stack: c7fc0000 c01ea242 c7fc0000 00000000 00000000 c5934800 c7fe6384
00000000
       0000000e c7fc0000 c01e984a c5934800 c645a080 ffffffff 0009f25f
       00030002
       0000000a ffffffff 00000005 00000000 0000006c 00000246 ffffffff
       c56145a0
Call Trace:    [<c01ea242>] [<c01e984a>] [<c01e8f3c>] [<c01e7e0d>]
[<c010a6f5>]
  [<c010a8b9>] [<c010cfc8>] [<c02a51e3>] [<c02a2380>] [<c02a044e>]
  [<c02a16b8>]
  [<c02460f6>] [<c014c2e0>] [<c012c0f2>] [<c010911f>]
Code: 8b 6a 6c 0f 84 70 01 00 00 fc 8b b3 84 00 00 00 bf c0 ed 31


>>EIP; c02a4f5b <lec_push+2b/220>   <=====

Trace; c01ea242 <dequeue_sm_buf+142/170>
Trace; c01e984a <dequeue_rx+8da/e90>
Trace; c01e8f3c <process_rsq+3c/70>
Trace; c01e7e0d <ns_irq_handler+36d/430>
Trace; c010a6f5 <handle_IRQ_event+45/70>
Trace; c010a8b9 <do_IRQ+69/b0>
Trace; c010cfc8 <call_do_IRQ+5/d>
Trace; c02a51e3 <lec_vcc_attach+93/b0>
Trace; c02a2380 <atm_push_raw+0/70>
Trace; c02a044e <try_atm_lane_ops+3e/60>
Trace; c02a16b8 <vcc_ioctl+258/350>
Trace; c02460f6 <sock_ioctl+26/30>
Trace; c014c2e0 <sys_ioctl+b0/260>
Trace; c012c0f2 <sys_munmap+42/70>
Trace; c010911f <system_call+33/38>

Code;  c02a4f5b <lec_push+2b/220>
00000000 <_EIP>:
Code;  c02a4f5b <lec_push+2b/220>   <=====
   0:   8b 6a 6c                  mov    0x6c(%edx),%ebp   <=====
Code;  c02a4f5e <lec_push+2e/220>
   3:   0f 84 70 01 00 00         je     179 <_EIP+0x179> c02a50d4
   <lec_push+1a4/220>
Code;  c02a4f64 <lec_push+34/220>
   9:   fc                        cld
Code;  c02a4f65 <lec_push+35/220>
   a:   8b b3 84 00 00 00         mov    0x84(%ebx),%esi
Code;  c02a4f6b <lec_push+3b/220>
  10:   bf c0 ed 31 00            mov    $0x31edc0,%edi

 <0>Kernel panic: Aiee, killing interrupt handler!

