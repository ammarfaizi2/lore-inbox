Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbTJMOly (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 10:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbTJMOly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 10:41:54 -0400
Received: from dclient217-162-71-11.hispeed.ch ([217.162.71.11]:28565 "EHLO
	steudten.com") by vger.kernel.org with ESMTP id S261762AbTJMOls
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 10:41:48 -0400
Message-ID: <3F8AB9A9.9010502@steudten.com>
Date: Mon, 13 Oct 2003 16:41:45 +0200
From: Thomas Steudten <alpha@steudten.com>
Reply-To: alpha@steudten.com
Organization: STEUDTEN ENGINEERING
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: raid1.c and gcc problem/oops (was: [INFO] gcc versions used to
 compile a kernel
References: <3F8ACFA0.10239.10815846@localhost>
In-Reply-To: <3F8ACFA0.10239.10815846@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well maybe for x86.
On alpha, as i described in this list, i got an oops in raid1.c
for kernel 2.4.17..21, 2.6.0-test7 with gcc-2.95.3, gcc-3.3
(3.4 is in work by me).
It seems that´t this a problem with gcc and option -O2. With optimizing
set to -O0 everything is ok. So i think gcc gives bad assembler code.
BUT: This problem still exists until now - latest kernel, latest
stable gcc. Redhat have had a patch for this since RH 7.1  with gcc
2.26. The problem is still there!! OK, why change the kernel code in
raid1.c read_balance, if it´s a fault in gcc. And we use gcc 2.95-3,
gcc 3.2.2 ( i don´t test it, but i think 3.3 or 3.3.1 is newer
and contains fixes for 3.2.2 ..) and we got still this very old, well
known bug in raid1.c:read_balance() on alpha.

What to do? Everytime patch the raid1.c?

Unable to handle kernel paging request at virtual address 0000000000000059
swapper(1): Oops 0
pc = [<fffffc000050dd50>]  ra = [<fffffc000050e200>]  ps = 0007    Not tainted
v0 = 0000000000000000  t0 = 0000000000000002  t1 = 0000000000000001
t2 = 0000000000000000  t3 = fffffc000015d6e8  t4 = 0000000000000001
t5 = fffffc0000182c50  t6 = 0000000000000002  t7 = fffffc0000c24000
s0 = fffffc001fcad408  s1 = fffffc00001b26e0  s2 = 0000000000000002
s3 = fffffc0000182c50  s4 = fffffc00010d5f68  s5 = 0000000000000002
s6 = fffffc0000105148
a0 = 0000000000000007  a1 = fffffc00010d5f68  a2 = fffffc001fcad408
a3 = 0000000000000400  a4 = 0000000000000018  a5 = 0000000000000000
t8 = 0000000000000000  t9 = fffffc000015d6f8  t10= 0000000000000004
t11= 0000000000000001  pv = fffffc000043ba20  at = 0000000000000002
gp = fffffc00006df608  sp = fffffc0000c27b18
Trace:fffffc0000482c80 fffffc0000329320 fffffc0000482d68 fffffc000037a2c8 fffffc0000377340 fffffc00003
77784 fffffc00003d05ec fffffc000037da10 fffffc00003d04a0 fffffc00003d275c fffffc000035646d fffffc00003
7de58 fffffc000039a6a8 fffffc000039ab1c fffffc000039afb8 fffffc000039af94 fffffc0000310000 fffffc00003
101ac fffffc00003135b8
Code: a0a60010  47ff041f  40821524  40a03125  a4440000  e440000e <a0220058> e420000c

>>RA;  fffffc000050e200 <make_request+e0/3c0>

>>PC;  fffffc000050dd50 <read_balance+170/280>   <=====

Trace; fffffc0000482c80 <generic_make_request+220/260>
Trace; fffffc0000329320 <autoremove_wake_function+0/60>
Trace; fffffc0000482d68 <submit_bio+a8/c0>
Trace; fffffc000037a2c8 <submit_bh+1a8/1e0>
Trace; fffffc0000377340 <__bread_slow+a0/100>
Trace; fffffc0000377784 <__bread+24/40>
Trace; fffffc00003d05ec <ext3_fill_super+14c/f60>
Trace; fffffc000037da10 <get_sb_bdev+170/240>
Trace; fffffc00003d04a0 <ext3_fill_super+0/f60>
Trace; fffffc00003d275c <ext3_get_sb+1c/60>
Trace; fffffc000035646d <cache_alloc_refill+40d/5c0>
Trace; fffffc000037de58 <do_kern_mount+98/220>
Trace; fffffc000039a6a8 <do_add_mount+a8/220>
Trace; fffffc000039ab1c <do_mount+1dc/220>
Trace; fffffc000039afb8 <sys_mount+b8/160>
Trace; fffffc000039af94 <sys_mount+94/160>
Trace; fffffc0000310000 <_text+0/0>
Trace; fffffc00003101ac <init+2c/100>
Trace; fffffc00003135b8 <kernel_thread+28/90>

Code;  fffffc000050dd38 <read_balance+158/280>
0000000000000000 <_PC>:
Code;  fffffc000050dd38 <read_balance+158/280>
    0:   10 00 a6 a0       ldl  t4,16(t5)
Code;  fffffc000050dd3c <read_balance+15c/280>
    4:   1f 04 ff 47       nop
Code;  fffffc000050dd40 <read_balance+160/280>
    8:   24 15 82 40       subq t3,0x10,t3
Code;  fffffc000050dd44 <read_balance+164/280>
    c:   25 31 a0 40       subl t4,0x1,t4
Code;  fffffc000050dd48 <read_balance+168/280>
   10:   00 00 44 a4       ldq  t1,0(t3)
Code;  fffffc000050dd4c <read_balance+16c/280>
   14:   0e 00 40 e4       beq  t1,50 <_PC+0x50> fffffc000050dd88 <read_balance+1a8/280>
Code;  fffffc000050dd50 <read_balance+170/280>   <=====
   18:   58 00 22 a0       ldl  t0,88(t1)   <=====
Code;  fffffc000050dd54 <read_balance+174/280>
   1c:   0c 00 20 e4       beq  t0,50 <_PC+0x50> fffffc000050dd88 <read_balance+1a8/280>

 From raid1.c:
   if (!conf->mirrors[disk].rdev ||
                     !conf->mirrors[disk].rdev->in_sync)
                         continue;


Kernel panic: Attempted to kill init!


Sebastian Piecha wrote:

> The last days I had a lot of trouble getting different kernel 
> versions to run. Enclosed is a short report of the experience I made.
> 
> First I tried to compile all kernels with gcc 3.3.1.

> Then I used gcc 2.95.3 for compiling 2.4.20, 2.4.22-ac4 and 2.6.0-
> test7 and all kernels booted smoothly.
> 
> It's seems that at least in my configuration gcc 3.3.1 is doing a bad 
> job.
>
-- 
Tom

LINUX user since kernel 0.99.x 1994.
RPM Alpha packages at http://alpha.steudten.com/packages




