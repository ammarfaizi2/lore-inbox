Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262813AbSI3RyO>; Mon, 30 Sep 2002 13:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262814AbSI3RyO>; Mon, 30 Sep 2002 13:54:14 -0400
Received: from mail.scram.de ([195.226.127.117]:20685 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S262812AbSI3Rxa>;
	Mon, 30 Sep 2002 13:53:30 -0400
Date: Mon, 30 Sep 2002 19:58:43 +0200 (CEST)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@alpha.bocc.de
To: linux-kernel@vger.kernel.org
Subject: 2.3.39 LLC on Alpha broken?
In-Reply-To: <Pine.NEB.4.44.0209300934330.7633-100000@www2.scram.de>
Message-ID: <Pine.LNX.4.44.0209301956320.1163-100000@alpha.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> I'll try to reboot the remaining mess and report how far it gets...

It looks like LLC is the culprit for me:

Unable to handle kernel paging request at virtual address 0000000000000000
swapper(1): Oops 0
pc = [<fffffc00009d094c>]  ra = [<fffffc00009c8c8c>]  ps = 0000    Not
tainted
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 = 0000000000000000  t0 = fffffc0000b73190  t1 = 0000000000000001
t2 = 5a5a5a5a5a5a5a5a  t3 = 0000000000000000  t4 = fffffc00001bef08
t5 = fffffc00001bef0d  t6 = fffffc000000afe8  t7 = fffffc00002a0000
s0 = 0000000000000000  s1 = 00000000000000aa  s2 = fffffc000095fa40
s3 = fffffc000106fcf8  s4 = fffffc0000802000  s5 = fffffc0000e1fa80
s6 = fffffc0000810000
a0 = 00000000000000aa  a1 = fffffc000095fa40  a2 = 00000000000041ed
a3 = 0000000000000000  a4 = 0000000000000000  a5 = fffffc0000a7f790
t8 = 0000000000000004  t9 = fffffc0001049368  t10= 0000000000004000
t11= 0000000000008000  pv = fffffc00009d0920  at = 0000000000000000
gp = fffffc0000af72f8  sp = fffffc00002a3e60
Trace:fffffc00009c8c8c fffffc0000810148 fffffc0000810828 fffffc00008322f8
fffffc
00008100a4 fffffc0000810120 fffffc0000810810
Code: 47ff0409  a0280068  20210100  b0280068  a43d5c78  a4810040
<a4440000> a3e2
0000


>>RA;  fffffc00009c8c8c <llc_sap_open+2c/c0>

>>PC;  fffffc00009d094c <llc_sap_find+2c/100>   <=====

Trace; fffffc00009c8c8c <llc_sap_open+2c/c0>
Trace; fffffc0000810148 <init+28/240>
Trace; fffffc0000810828 <kernel_thread+28/90>
Trace; fffffc00008322f8 <printk+218/280>
Trace; fffffc00008100a4 <rest_init+24/60>
Trace; fffffc0000810120 <init+0/240>
Trace; fffffc0000810810 <kernel_thread+10/90>

Code;  fffffc00009d0934 <llc_sap_find+14/100>
0000000000000000 <_PC>:
Code;  fffffc00009d0934 <llc_sap_find+14/100>
   0:   09 04 ff 47       clr  s0
Code;  fffffc00009d0938 <llc_sap_find+18/100>
   4:   68 00 28 a0       ldl  t0,104(t7)
Code;  fffffc00009d093c <llc_sap_find+1c/100>
   8:   00 01 21 20       lda  t0,256(t0)
Code;  fffffc00009d0940 <llc_sap_find+20/100>
   c:   68 00 28 b0       stl  t0,104(t7)
Code;  fffffc00009d0944 <llc_sap_find+24/100>
  10:   78 5c 3d a4       ldq  t0,23672(gp)
Code;  fffffc00009d0948 <llc_sap_find+28/100>
  14:   40 00 81 a4       ldq  t3,64(t0)
Code;  fffffc00009d094c <llc_sap_find+2c/100>   <=====
  18:   00 00 44 a4       ldq  t1,0(t3)   <=====
Code;  fffffc00009d0950 <llc_sap_find+30/100>
  1c:   00 00 e2 a3       ldl  zero,0(t1)

Kernel panic: Aiee, killing interrupt handler!

I'll rebuild without LLC and test again...

--jochen

