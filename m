Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267200AbTGLAnE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 20:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267201AbTGLAnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 20:43:04 -0400
Received: from pa208.myslowice.sdi.tpnet.pl ([213.76.228.208]:49281 "EHLO
	finwe.eu.org") by vger.kernel.org with ESMTP id S267200AbTGLAm7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 20:42:59 -0400
Date: Sat, 12 Jul 2003 02:57:38 +0200
From: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
To: Russell King <rmk@arm.linux.org.uk>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.75, 8250 Oops
Message-ID: <20030712005738.GA15060@finwe.eu.org>
Mail-Followup-To: Russell King <rmk@arm.linux.org.uk>,
	Theodore Ts'o <tytso@mit.edu>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Kreatorzy Kreacji Bialej
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

pppd was trying to open /dev/ttyS0  (persist & maxfail 0, etc.), but
I had not created alias for it....

Jul 12 01:29:19 finwe pppd[643]: Failed to open /dev/ttyS0: No such device

...so I manually loaded 8250 and:

 Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
 ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
 Unable to handle kernel NULL pointer dereference at virtual address 00000014
  printing eip:
 d08c6b21
 *pde = 00000000
 Oops: 0000 [#1]
 CPU:    0
 EIP:    0060:[_end+274047177/1070142888]    Not tainted
 EFLAGS: 00010282
 EIP is at uart_close+0x11/0x200 [core]
 eax: d08c6b10   ebx: cbdfe000   ecx: 00000000   edx: cee66000
 esi: cbbe6600   edi: 00000000   ebp: cbdfe000   esp: cec79e58
 ds: 007b   es: 007b   ss: 0068
 Process pppd (pid: 643, threadinfo=cec78000 task=c139f980)
 Stack: 00000000 c01bb9d5 ffffffff cbbe6600 00000000 cbdfe000 cbbe6600 00000001 
        00000000 c01bb4c1 cbdfe000 cbbe6600 00000000 d08c9bc0 c010822c d08c9bc0 
        00000000 00000004 d08c84a6 d08b7b8e 00000001 00000000 00000004 00000000 
 Call Trace:
  [tty_fasync+133/320] tty_fasync+0x85/0x140
  [release_dev+1777/1840] release_dev+0x6f1/0x730
  [__down_failed+8/12] __down_failed+0x8/0xc
  [_end+274053710/1070142888] .text.lock.core+0xcd/0x1a5 [core]
  [_end+274049152/1070142888] uart_open+0x58/0x160 [core]
  [tty_open+300/880] tty_open+0x12c/0x370
  [chrdev_open+242/544] chrdev_open+0xf2/0x220
  [dentry_open+336/528] dentry_open+0x150/0x210
  [filp_open+104/112] filp_open+0x68/0x70
  [sys_open+91/144] sys_open+0x5b/0x90
  [syscall_call+7/11] syscall_call+0x7/0xb
 
 Code: 8b 47 14 89 44 24 10 b8 00 e0 ff ff 21 e0 8b 00 8b 40 14 85 

 ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A

Linux finwe 2.5.75 #1 Fri Jul 11 01:02:39 CEST 2003 i686 GNU/Linux

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 11
model name	: Intel(R) Celeron(TM) CPU                1300MHz
stepping	: 1
cpu MHz		: 1305.846
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 2580.48

 
Gnu C                  3.3.1
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
e2fsprogs              1.34-WIP
jfsutils               1.1.1
xfsprogs               2.4.12
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.9
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0


config: http://zeus.polsl.gliwice.pl/~jfk/kernel/2.5.75/config1

jk :)


-- 
Jacek Kawa
