Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266299AbUFPV13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266299AbUFPV13 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 17:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266286AbUFPV13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 17:27:29 -0400
Received: from catv-5062fad2.catv.broadband.hu ([80.98.250.210]:29713 "EHLO
	balabit.hu") by vger.kernel.org with ESMTP id S266299AbUFPVXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 17:23:13 -0400
Subject: kernel oops on ia64 (2.6.6 + 0521 ia64 patch)
From: Balazs Scheidler <bazsi@balabit.hu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1087420973.4345.19.camel@bzorp.balabit>
Mime-Version: 1.0
Date: Wed, 16 Jun 2004 23:22:54 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm encountering more-or-less reproducible oopses on a 2.6.6 kernel with
0521 ia64 patch, compiled with gcc 3.3.3 on Debian sarge.

The box is a HP rx2600 with a single processor, kernel is compiled in UP
mode. Here is the backtrace (saved off froma  terminal session on the
network console, thus the formatting, but the info should be correct).

I could oops the machine by running a configure script two times so far.
(two oopses for two configure runs) Nothing else is running on the box,
though a remote server mounts some NFS shares, but they were not loaded
at the time of the oops.

The box has 2G RAM and 3 disks. These modules are loaded:

nfsd                  210780  8
exportfs                9784  1 nfsd
lockd                 125768  2 nfsd
sunrpc                280328  2 nfsd,lockd
nls_iso8859_2           6368  1
nls_cp437               7488  1
vfat                   24758  1
fat                    79040  1 vfat
nls_base               11008  4 nls_iso8859_2,nls_cp437,vfat,fat
tg3                   159560  0
e100                   66236  0

Let me know if you need more information. Now the dump (there is a more
complete oops down there, the first might not be complete):

   MP MAIN MENU:

         CO: Console
        VFP: Virtual Front Panel
         CM: Command Menu
         CL: Console Log
         SL: Show Event Logs
         HE: Main Help Menu
          X: Exit Connection

[hp-ia64console] MP> cl

e282188
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e286110 bsp=e00000003e282188
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e2862e0 bsp=e00000003e282138
 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e2862e0 bsp=e00000003e2820b8
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e2862e0 bsp=e00000003e282080
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e2862e0 bsp=e00000003e282018
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e286370 bsp=e00000003e282018
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e286540 bsp=e00000003e281fc0
 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e286540 bsp=e00000003e281f40
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e286540 bsp=e00000003e281f08
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 1 of 53} >























                                sp=e00000003e286540 bsp=e00000003e281ea0
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e2865d0 bsp=e00000003e281ea0
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e2867a0 bsp=e00000003e281e50
 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e2867a0 bsp=e00000003e281dc8
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e2867a0 bsp=e00000003e281d90
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e2867a0 bsp=e00000003e281d28
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e286830 bsp=e00000003e281d28
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e286a00 bsp=e00000003e281cd8
 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e286a00 bsp=e00000003e281c58
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e286a00 bsp=e00000003e281c20
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 2 of 53} >























                                sp=e00000003e286a00 bsp=e00000003e281bb0
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e286a90 bsp=e00000003e281bb0
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e286c60 bsp=e00000003e281b60
 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e286c60 bsp=e00000003e281ae0
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e286c60 bsp=e00000003e281aa8
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e286c60 bsp=e00000003e281a40
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e286cf0 bsp=e00000003e281a40
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e286ec0 bsp=e00000003e2819e8
 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e286ec0 bsp=e00000003e281968
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e286ec0 bsp=e00000003e281930
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 3 of 53} >























                                sp=e00000003e286ec0 bsp=e00000003e2818c8
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e286f50 bsp=e00000003e2818c8
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e287120 bsp=e00000003e281878
 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e287120 bsp=e00000003e2817f0
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e287120 bsp=e00000003e2817b8
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e287120 bsp=e00000003e281750
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e2871b0 bsp=e00000003e281750
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e287380 bsp=e00000003e281700
 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e287380 bsp=e00000003e281680
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e287380 bsp=e00000003e281648
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 4 of 53} >























                                sp=e00000003e287380 bsp=e00000003e2815d8
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e287410 bsp=e00000003e2815d8
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e2875e0 bsp=e00000003e281588
 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e2875e0 bsp=e00000003e281508
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e2875e0 bsp=e00000003e2814d0
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e2875e0 bsp=e00000003e281468
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e287670 bsp=e00000003e281468
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e287840 bsp=e00000003e281418
 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e287840 bsp=e00000003e281390
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e287840 bsp=e00000003e281358
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 5 of 53} >























                                sp=e00000003e287840 bsp=e00000003e2812f0
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e2878d0 bsp=e00000003e2812f0
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e287aa0 bsp=e00000003e2812a0
 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e287aa0 bsp=e00000003e281220
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e287aa0 bsp=e00000003e2811e0
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e287aa0 bsp=e00000003e281178
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e287b30 bsp=e00000003e281178
 [<a0000001000d0a10>] clear_page_tables+0x250/0x300
                                sp=e00000003e287d00 bsp=e00000003e281078
 [<a0000001000db440>] exit_mmap+0x180/0x6a0
                                sp=e00000003e287d90 bsp=e00000003e280fd0
 [<a000000100078f60>] mmput+0xe0/0x140
                                sp=e00000003e287e30 bsp=e00000003e280fa8
 [<a0000001000829f0>] do_exit+0x3f0/0x8e0


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 6 of 53} >























                                sp=e00000003e287e30 bsp=e00000003e280f28
 [<a0000001000830d0>] do_group_exit+0x130/0x160
                                sp=e00000003e287e30 bsp=e00000003e280f08
 [<a00000010000dc60>] ia64_ret_from_syscall+0x0/0x20
                                sp=e00000003e287e30 bsp=e00000003e280ef8
 <1>Unable to handle kernel NULL pointer dereference (address 0000000000000028)
configure[8846]: Oops 8813272891392 [26]

Pid: 8846, CPU 0, comm:            configure
psr : 0000101008026018 ifs : 800000000000028a ip  : [<a000000100079090>]    Not tainted
ip is at mm_release+0x70/0x120
unat: 0000000000000000 pfs : 0000000000000814 rsc : 0000000000000003
rnat: a0000001005691bc bsps: e00000003e284090 pr  : 00000000656656a5
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70033f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a0000001000827a0 b6  : a000000100013da0 b7  : a000000100075c40
f6  : 0fffafffffffff0000000 f7  : 0ffdc8000000000000000
f8  : 100008000000000000000 f9  : 100038000000000000000
f10 : 0fffbfffffffff0000000 f11 : 1003e0000000000000000
r1  : a000000100820000 r2  : 0000000000000000 r3  : a0000001006569f0


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 7 of 53} >























r8  : 0000000000000000 r9  : 00000fffffffbfff r10 : e00000003e284140
r11 : e00000003e2800ec r12 : e00000003e2841a0 r13 : e00000003e280000
r14 : 0000000000000028 r15 : e00000003e280260 r16 : 0000000000000000
r17 : e00000003e280e30 r18 : e00000003e280e70 r19 : e00000003e2802e0
r20 : 0000000000000044 r21 : 0000000000000044 r22 : a0000001006fcb38
r23 : ffffffffffffffff r24 : 0000000000000000 r25 : e00000003e280020
r26 : a0000001006fcb38 r27 : 000000000000003e r28 : 0000001008022018
r29 : 0000000000004000 r30 : e00000003e284140 r31 : a0000001006fcb38

Call Trace:
 [<a000000100013f00>] show_stack+0x80/0xa0
                                sp=e00000003e283d70 bsp=e00000003e2836a0
 [<a0000001000360b0>] die+0x130/0x1a0
                                sp=e00000003e283f40 bsp=e00000003e283668
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e283f40 bsp=e00000003e283600
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e283fd0 bsp=e00000003e283600
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e2841a0 bsp=e00000003e2835a8


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 8 of 53} >























 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e2841a0 bsp=e00000003e283528
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e2841a0 bsp=e00000003e2834f0
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e2841a0 bsp=e00000003e283488
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e284230 bsp=e00000003e283488
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e284400 bsp=e00000003e283438
 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e284400 bsp=e00000003e2833b0
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e284400 bsp=e00000003e283378
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e284400 bsp=e00000003e283310
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e284490 bsp=e00000003e283310
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e284660 bsp=e00000003e2832c0


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 9 of 53} >























 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e284660 bsp=e00000003e283240
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e284660 bsp=e00000003e283208
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e284660 bsp=e00000003e283198
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e2846f0 bsp=e00000003e283198
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e2848c0 bsp=e00000003e283148
 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e2848c0 bsp=e00000003e2830c8
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e2848c0 bsp=e00000003e283090
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e2848c0 bsp=e00000003e283028
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e284950 bsp=e00000003e283028
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e284b20 bsp=e00000003e282fd0


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 10 of 53} >























 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e284b20 bsp=e00000003e282f50
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e284b20 bsp=e00000003e282f18
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e284b20 bsp=e00000003e282eb0
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e284bb0 bsp=e00000003e282eb0
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e284d80 bsp=e00000003e282e60
 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e284d80 bsp=e00000003e282dd8
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e284d80 bsp=e00000003e282da0
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e284d80 bsp=e00000003e282d38
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e284e10 bsp=e00000003e282d38
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e284fe0 bsp=e00000003e282ce8


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 11 of 53} >























 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e284fe0 bsp=e00000003e282c68
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e284fe0 bsp=e00000003e282c30
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e284fe0 bsp=e00000003e282bc0
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e285070 bsp=e00000003e282bc0
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e285240 bsp=e00000003e282b70
 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e285240 bsp=e00000003e282af0
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e285240 bsp=e00000003e282ab8
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e285240 bsp=e00000003e282a50
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e2852d0 bsp=e00000003e282a50
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e2854a0 bsp=e00000003e282a00


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 12 of 53} >























 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e2854a0 bsp=e00000003e282978
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e2854a0 bsp=e00000003e282940
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e2854a0 bsp=e00000003e2828d8
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e285530 bsp=e00000003e2828d8
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e285700 bsp=e00000003e282888
 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e285700 bsp=e00000003e282808
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e285700 bsp=e00000003e2827c8
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e285700 bsp=e00000003e282760
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e285790 bsp=e00000003e282760
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e285960 bsp=e00000003e282710


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 13 of 53} >























 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e285960 bsp=e00000003e282690
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e285960 bsp=e00000003e282658
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e285960 bsp=e00000003e2825e8
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e2859f0 bsp=e00000003e2825e8
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e285bc0 bsp=e00000003e282598
 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e285bc0 bsp=e00000003e282518
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e285bc0 bsp=e00000003e2824e0
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e285bc0 bsp=e00000003e282478
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e285c50 bsp=e00000003e282478
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e285e20 bsp=e00000003e282428


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 14 of 53} >























 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e285e20 bsp=e00000003e2823a0
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e285e20 bsp=e00000003e282368
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e285e20 bsp=e00000003e282300
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e285eb0 bsp=e00000003e282300
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e286080 bsp=e00000003e2822b0
 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e286080 bsp=e00000003e282230
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e286080 bsp=e00000003e2821f0
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e286080 bsp=e00000003e282188
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e286110 bsp=e00000003e282188
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e2862e0 bsp=e00000003e282138


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 15 of 53} >























 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e2862e0 bsp=e00000003e2820b8
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e2862e0 bsp=e00000003e282080
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e2862e0 bsp=e00000003e282018
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e286370 bsp=e00000003e282018
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e286540 bsp=e00000003e281fc0
 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e286540 bsp=e00000003e281f40
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e286540 bsp=e00000003e281f08
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e286540 bsp=e00000003e281ea0
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e2865d0 bsp=e00000003e281ea0
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e2867a0 bsp=e00000003e281e50


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 16 of 53} >























 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e2867a0 bsp=e00000003e281dc8
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e2867a0 bsp=e00000003e281d90
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e2867a0 bsp=e00000003e281d28
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e286830 bsp=e00000003e281d28
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e286a00 bsp=e00000003e281cd8
 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e286a00 bsp=e00000003e281c58
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e286a00 bsp=e00000003e281c20
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e286a00 bsp=e00000003e281bb0
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e286a90 bsp=e00000003e281bb0
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e286c60 bsp=e00000003e281b60


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 17 of 53} >























 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e286c60 bsp=e00000003e281ae0
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e286c60 bsp=e00000003e281aa8
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e286c60 bsp=e00000003e281a40
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e286cf0 bsp=e00000003e281a40
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e286ec0 bsp=e00000003e2819e8
 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e286ec0 bsp=e00000003e281968
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e286ec0 bsp=e00000003e281930
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e286ec0 bsp=e00000003e2818c8
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e286f50 bsp=e00000003e2818c8
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e287120 bsp=e00000003e281878


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 18 of 53} >























 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e287120 bsp=e00000003e2817f0
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e287120 bsp=e00000003e2817b8
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e287120 bsp=e00000003e281750
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e2871b0 bsp=e00000003e281750
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e287380 bsp=e00000003e281700
 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e287380 bsp=e00000003e281680
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e287380 bsp=e00000003e281648
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e287380 bsp=e00000003e2815d8
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e287410 bsp=e00000003e2815d8
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e2875e0 bsp=e00000003e281588


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 19 of 53} >























 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e2875e0 bsp=e00000003e281508
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e2875e0 bsp=e00000003e2814d0
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e2875e0 bsp=e00000003e281468
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e287670 bsp=e00000003e281468
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e287840 bsp=e00000003e281418
 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e287840 bsp=e00000003e281390
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e287840 bsp=e00000003e281358
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e287840 bsp=e00000003e2812f0
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e2878d0 bsp=e00000003e2812f0
 [<a000000100079090>] mm_release+0x70/0x120
                                sp=e00000003e287aa0 bsp=e00000003e2812a0


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 20 of 53} >























 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e287aa0 bsp=e00000003e281220
 [<a0000001000360f0>] die+0x170/0x1a0
                                sp=e00000003e287aa0 bsp=e00000003e2811e0
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e287aa0 bsp=e00000003e281178
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e287b30 bsp=e00000003e281178
 [<a0000001000d0a10>] clear_page_tables+0x250/0x300
                                sp=e00000003e287d00 bsp=e00000003e281078
 [<a0000001000db440>] exit_mmap+0x180/0x6a0
                                sp=e00000003e287d90 bsp=e00000003e280fd0
 [<a000000100078f60>] mmput+0xe0/0x140
                                sp=e00000003e287e30 bsp=e00000003e280fa8
 [<a0000001000829f0>] do_exit+0x3f0/0x8e0
                                sp=e00000003e287e30 bsp=e00000003e280f28
 [<a0000001000830d0>] do_group_exit+0x130/0x160
                                sp=e00000003e287e30 bsp=e00000003e280f08
 [<a00000010000dc60>] ia64_ret_from_syscall+0x0/0x20
                                sp=e00000003e287e30 bsp=e00000003e280ef8


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 21 of 53} >























 <1>Unable to handle kernel NULL pointer dereference (address 0000000000000028)
configure[8846]: Oops 8813272891392 [27]

Pid: 8846, CPU 0, comm:            configure
psr : 0000101008026018 ifs : 800000000000028a ip  : [<a000000100079090>]    Not tainted
ip is at mm_release+0x70/0x120
unat: 0000000000000000 pfs : 0000000000000814 rsc : 0000000000000003
rnat: a0000001005691bc bsps: e00000003e283e30 pr  : 00000000656656a5
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70033f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a0000001000827a0 b6  : a000000100013da0 b7  : a000000100075c40
f6  : 0fffafffffffff0000000 f7  : 0ffdc8000000000000000
f8  : 100008000000000000000 f9  : 100038000000000000000
f10 : 0fffbfffffffff0000000 f11 : 1003e0000000000000000
r1  : a000000100820000 r2  : 0000000000000000 r3  : a0000001006569f0
r8  : 0000000000000000 r9  : 00000fffffffbfff r10 : e00000003e283ee0
r11 : e00000003e2800ec r12 : e00000003e283f40 r13 : e00000003e280000
r14 : 0000000000000028 r15 : e00000003e280260 r16 : 0000000000000000
r17 : e00000003e280e30 r18 : e00000003e280e70 r19 : e00000003e2802e0
r20 : 0000000000000044 r21 : 0000000000000044 r22 : a0000001006fcb38


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 22 of 53} >























r23 : ffffffffffffffff r24 : 0000000000000000 r25 : e00000003e280020
r26 : a0000001006fcb38 r27 : 000000000000003e r28 : 0000001008022018
r29 : 0000000000004000 r30 : e00000003e283ee0 r31 : a0000001006fcb38

Call Trace:
 [<a000000100013f00>] show_stack+0x80/0xa0
                                sp=e00000003e283b10 bsp=e00000003e283818
Unable to handle kernel NULL pointer dereference (address 0000000000000000)
configure[8846]: Oops 4294967296 [28]

Pid: 8846, CPU 0, comm:            configure
psr : 0000101008022018 ifs : 8000000000000000 ip  : [<0000000000000000>]    Not tainted
ip is at 0x0
unat: 0000000000000000 pfs : 0000000000000000 rsc : 0000000000000003
rnat: a0000001005691bc bsps: e00000003e283bd0 pr  : 0000000065665aa5
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70033f
csd : 0000000000000000 ssd : 0000000000000000
b0  : 0000000000000000 b6  : a000000100013da0 b7  : a000000100291760
f6  : 0fffafffffffff0000000 f7  : 0ffdea000000000000000
f8  : 10002a000000000000000 f9  : 100038000000000000000


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 23 of 53} >























f10 : 0fffe9ffffffff6000000 f11 : 1003e0000000000000000
r1  : a000000100820000 r2  : e00000003e2837d0 r3  : 0000000000000000
r8  : ffffffffffffffff r9  : 0000000000000000 r10 : a0000001006fa558
r11 : e00000003e283790 r12 : e00000003e283ce0 r13 : e00000003e280000
r14 : e00000003e283b20 r15 : e00000003e283760 r16 : 0000000000000000
r17 : 0000000000004000 r18 : 0000000000000000 r19 : e00000003e2837c0
r20 : e00000003e283768 r21 : e00000003e283780 r22 : e00000003e283b10
r23 : e00000003e283770 r24 : a000000100013f00 r25 : e00000003e283818
r26 : e00000003e283798 r27 : 000000000000003e r28 : 0000000000ffffff
r29 : 000000000000000a r30 : 000000000000000a r31 : a0000001006fcb38

Call Trace:
 [<a000000100013f00>] show_stack+0x80/0xa0
                                sp=e00000003e2838d8 bsp=e00000003e2838b8
 [<a0000001000360b0>] die+0x130/0x1a0
                                sp=e00000003e283aa8 bsp=e00000003e283880
 <1>Unable to handle kernel NULL pointer dereference (address 0000000000000000)
Recursive die() failure, output suppressed
 <1>Unable to handle kernel NULL pointer dereference (address 0000000000000028)
configure[8846]: Oops 8813272891392 [29]


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 24 of 53} >
























Pid: 8846, CPU 0, comm:            configure
psr : 0000101008026018 ifs : 800000000000028a ip  : [<a000000100079090>]    Not tainted
ip is at mm_release+0x70/0x120
unat: 0000000000000000 pfs : 0000000000000814 rsc : 0000000000000003
rnat: 0000000000000000 bsps: 0000000000000000 pr  : 00000000656656a5
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c0270033f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a0000001000827a0 b6  : a000000100001b50 b7  : a000000100075c40
f6  : 0fffafffffffff0000000 f7  : 0ffdb8000000000000000
f8  : 0ffff8000000000000000 f9  : 100038000000000000000
f10 : 0fffafffffffff0000000 f11 : 1003e0000000000000000
r1  : a000000100820000 r2  : 0000000000000000 r3  : a0000001006569f0
r8  : 0000000000000000 r9  : 00000fffffffbfff r10 : e00000003e2837c0
r11 : e00000003e2800ec r12 : e00000003e283820 r13 : e00000003e280000
r14 : 0000000000000028 r15 : e00000003e280260 r16 : 0000000000000000
r17 : e00000003e280e30 r18 : e00000003e280e70 r19 : e00000003e2802e0
r20 : 0000000000000044 r21 : 0000000000000044 r22 : a0000001006fcb38
r23 : ffffffffffffffff r24 : 0000000000000000 r25 : e00000003e280020
r26 : a0000001006fcb38 r27 : 000000000000003e r28 : 0000001008022018


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 25 of 53} >























r29 : 0000000000004000 r30 : e00000003e2837c0 r31 : a0000001006fcb38

Call Trace:
 [<a000000100013f00>] show_stack+0x80/0xa0
                                sp=e00000003e283b20 bsp=e00000003e283b00
 [<a0000001000360b0>] die+0x130/0x1a0
                                sp=e00000003e283cf0 bsp=e00000003e283ac8
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e283cf0 bsp=e00000003e283a60
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e283d80 bsp=e00000003e283a60
 <1>Unable to handle kernel NULL pointer dereference (address 0000000000000028)
configure[8846]: Oops 8813272891392 [30]

Pid: 8846, CPU 0, comm:            configure
psr : 0000101008026018 ifs : 800000000000028a ip  : [<a000000100079090>]    Not tainted
ip is at mm_release+0x70/0x120
unat: 0000000000000000 pfs : 0000000000000814 rsc : 0000000000000003
rnat: a0000001005691bc bsps: e00000003e2834b0 pr  : 00000000656656a5
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70033f


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 26 of 53} >























csd : 0000000000000000 ssd : 0000000000000000
b0  : a0000001000827a0 b6  : a000000100013da0 b7  : a000000100075c40
f6  : 0fffafffffffff0000000 f7  : 0ffdc8000000000000000
f8  : 100008000000000000000 f9  : 100038000000000000000
f10 : 0fffbfffffffff0000000 f11 : 1003e0000000000000000
r1  : a000000100820000 r2  : 0000000000000000 r3  : a0000001006569f0
r8  : 0000000000000000 r9  : 00000fffffffbfff r10 : e00000003e283560
r11 : e00000003e2800ec r12 : e00000003e2835c0 r13 : e00000003e280000
r14 : 0000000000000028 r15 : e00000003e280260 r16 : 0000000000000000
r17 : e00000003e280e30 r18 : e00000003e280e70 r19 : e00000003e2802e0
r20 : 0000000000000044 r21 : 0000000000000044 r22 : a0000001006fcb38
r23 : ffffffffffffffff r24 : 0000000000000000 r25 : e00000003e280020
r26 : a0000001006fcb38 r27 : 000000000000003e r28 : 0000001008022018
r29 : 0000000000004000 r30 : e00000003e283560 r31 : a0000001006fcb38

Call Trace:
 [<a000000100013f00>] show_stack+0x80/0xa0
                                sp=e00000003e283c98 bsp=e00000003e283c78
 [<a0000001000360b0>] die+0x130/0x1a0
                                sp=e00000003e283e68 bsp=e00000003e283c40


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 27 of 53} >























 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e283e68 bsp=e00000003e283bd0
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e283ef8 bsp=e00000003e283bd0
 <1>Unable to handle kernel NULL pointer dereference (address 0000000000000028)
configure[8846]: Oops 8813272891392 [31]

Pid: 8846, CPU 0, comm:            configure
psr : 0000101008026018 ifs : 800000000000028a ip  : [<a000000100079090>]    Not tainted
ip is at mm_release+0x70/0x120
unat: 0000000000000000 pfs : 0000000000000814 rsc : 0000000000000003
rnat: a0000001005691bc bsps: e00000003e283250 pr  : 00000000656656a5
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70033f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a0000001000827a0 b6  : a000000100013da0 b7  : a000000100075c40
f6  : 0fffafffffffff0000000 f7  : 0ffdc8000000000000000
f8  : 100008000000000000000 f9  : 100038000000000000000
f10 : 0fffbfffffffff0000000 f11 : 1003e0000000000000000
r1  : a000000100820000 r2  : 0000000000000000 r3  : a0000001006569f0
r8  : 0000000000000000 r9  : 00000fffffffbfff r10 : e00000003e283300


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 28 of 53} >























r11 : e00000003e2800ec r12 : e00000003e283360 r13 : e00000003e280000
r14 : 0000000000000028 r15 : e00000003e280260 r16 : 0000000000000000
r17 : e00000003e280e30 r18 : e00000003e280e70 r19 : e00000003e2802e0
r20 : 0000000000000044 r21 : 0000000000000044 r22 : a0000001006fcb38
r23 : ffffffffffffffff r24 : 0000000000000000 r25 : e00000003e280020
r26 : a0000001006fcb38 r27 : 000000000000003e r28 : 0000001008022018
r29 : 0000000000004000 r30 : e00000003e283300 r31 : a0000001006fcb38

Call Trace:
 [<a000000100013f00>] show_stack+0x80/0xa0
                                sp=e00000003e283e10 bsp=e00000003e283de8
 [<a0000001000360b0>] die+0x130/0x1a0
                                sp=e00000003e283fe0 bsp=e00000003e283db0
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e283fe0 bsp=e00000003e283d48
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e284070 bsp=e00000003e283d48
 [<e00000003e280e70>] 0xe00000003e280e70
                                sp=e00000003e284240 bsp=e00000003e283a40
 <1>Unable to handle kernel NULL pointer dereference (address 0000000000000028)


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 29 of 53} >























configure[8846]: Oops 8813272891392 [32]

Pid: 8846, CPU 0, comm:            configure
psr : 0000101008026018 ifs : 800000000000028a ip  : [<a000000100079090>]    Not tainted
ip is at mm_release+0x70/0x120
unat: 0000000000000000 pfs : 0000000000000814 rsc : 0000000000000003
rnat: a0000001005691bc bsps: e00000003e282ff0 pr  : 00000000656656a5
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70033f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a0000001000827a0 b6  : a000000100013da0 b7  : a000000100075c40
f6  : 1003e8208208208208209 f7  : 0ffdee000000000000000
f8  : 1003efffffffffffffffc f9  : 1003e0000000000000008
f10 : 0fffedffffffff2000000 f11 : 1003e0000000000000000
r1  : a000000100820000 r2  : 0000000000000000 r3  : a0000001006569f0
r8  : 0000000000000000 r9  : 00000fffffffbfff r10 : e00000003e2830a0
r11 : e00000003e2800ec r12 : e00000003e283100 r13 : e00000003e280000
r14 : 0000000000000028 r15 : e00000003e280260 r16 : 0000000000000000
r17 : e00000003e280e30 r18 : e00000003e280e70 r19 : e00000003e2802e0
r20 : 0000000000000044 r21 : 0000000000000044 r22 : a0000001006fcb38
r23 : ffffffffffffffff r24 : 0000000000000000 r25 : e00000003e280020


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 30 of 53} >























r26 : a0000001006fcb38 r27 : 000000000000003e r28 : 0000001008022018
r29 : 0000000000004000 r30 : e00000003e2830a0 r31 : a0000001006fcb38

Call Trace:
 [<a000000100013f00>] show_stack+0x80/0xa0
                                sp=e00000003e283f80 bsp=e00000003e283f60
 [<a0000001000360b0>] die+0x130/0x1a0
                                sp=e00000003e284150 bsp=e00000003e283f28
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e284150 bsp=e00000003e283ec0
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e2841e0 bsp=e00000003e283ec0
 [<e00000003e284230>] 0xe00000003e284230
                                sp=e00000003e2843b0 bsp=e00000003e283db8
 <1>Unable to handle kernel NULL pointer dereference (address 0000000000000028)
configure[8846]: Oops 8813272891392 [33]

Pid: 8846, CPU 0, comm:            configure
psr : 0000101008026018 ifs : 800000000000028a ip  : [<a000000100079090>]    Not tainted
ip is at mm_release+0x70/0x120


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 31 of 53} >























unat: 0000000000000000 pfs : 0000000000000814 rsc : 0000000000000003
rnat: a0000001005691bc bsps: e00000003e282d90 pr  : 00000000656656a5
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70033f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a0000001000827a0 b6  : a000000100013da0 b7  : a000000100075c40
f6  : 1003e8208208208208209 f7  : 0ffdee000000000000000
f8  : 1003effffffffffffffe4 f9  : 1003e0000000000000037
f10 : 0fffedffffffff2000000 f11 : 1003e0000000000000000
r1  : a000000100820000 r2  : 0000000000000000 r3  : a0000001006569f0
r8  : 0000000000000000 r9  : 00000fffffffbfff r10 : e00000003e282e40
r11 : e00000003e2800ec r12 : e00000003e282ea0 r13 : e00000003e280000
r14 : 0000000000000028 r15 : e00000003e280260 r16 : 0000000000000000
r17 : e00000003e280e30 r18 : e00000003e280e70 r19 : e00000003e2802e0
r20 : 0000000000000044 r21 : 0000000000000044 r22 : a0000001006fcb38
r23 : ffffffffffffffff r24 : 0000000000000000 r25 : e00000003e280020
r26 : a0000001006fcb38 r27 : 000000000000003e r28 : 0000001008022018
r29 : 0000000000004000 r30 : e00000003e282e40 r31 : a0000001006fcb38

Call Trace:
 [<a000000100013f00>] show_stack+0x80/0xa0


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 32 of 53} >























                                sp=e00000003e2840f8 bsp=e00000003e2840d8
 [<a0000001000360b0>] die+0x130/0x1a0
                                sp=e00000003e2842c8 bsp=e00000003e2840a0
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e2842c8 bsp=e00000003e284038
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e284358 bsp=e00000003e284038
 <1>Unable to handle kernel NULL pointer dereference (address 0000000000000028)
configure[8846]: Oops 8813272891392 [34]

Pid: 8846, CPU 0, comm:            configure
psr : 0000101008026018 ifs : 800000000000028a ip  : [<a000000100079090>]    Not tainted
ip is at mm_release+0x70/0x120
unat: 0000000000000000 pfs : 0000000000000814 rsc : 0000000000000003
rnat: a0000001005691bc bsps: e00000003e282b30 pr  : 00000000656656a5
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70033f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a0000001000827a0 b6  : a000000100013da0 b7  : a000000100075c40
f6  : 0fffafffffffff0000000 f7  : 0ffdc8000000000000000
f8  : 100008000000000000000 f9  : 100038000000000000000


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 33 of 53} >























f10 : 0fffbfffffffff0000000 f11 : 1003e0000000000000000
r1  : a000000100820000 r2  : 0000000000000000 r3  : a0000001006569f0
r8  : 0000000000000000 r9  : 00000fffffffbfff r10 : e00000003e282be0
r11 : e00000003e2800ec r12 : e00000003e282c40 r13 : e00000003e280000
r14 : 0000000000000028 r15 : e00000003e280260 r16 : 0000000000000000
r17 : e00000003e280e30 r18 : e00000003e280e70 r19 : e00000003e2802e0
r20 : 0000000000000044 r21 : 0000000000000044 r22 : a0000001006fcb38
r23 : ffffffffffffffff r24 : 0000000000000000 r25 : e00000003e280020
r26 : a0000001006fcb38 r27 : 000000000000003e r28 : 0000001008022018
r29 : 0000000000004000 r30 : e00000003e282be0 r31 : a0000001006fcb38

Call Trace:
 [<a000000100013f00>] show_stack+0x80/0xa0
                                sp=e00000003e284270 bsp=e00000003e284250
 [<a0000001000360b0>] die+0x130/0x1a0
                                sp=e00000003e284440 bsp=e00000003e284218
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e284440 bsp=e00000003e2841a8
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e2844d0 bsp=e00000003e2841a8


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 34 of 53} >























 [<a0000001000827a0>] do_exit+0x1a0/0x8e0
                                sp=e00000003e2846a0 bsp=e00000003e2841a8
 [<a0000001005676b0>] 0xa0000001005676b0
                                sp=e00000003e2846a0 bsp=e00000003e283ef8
 <1>Unable to handle kernel NULL pointer dereference (address 0000000000000028)
configure[8846]: Oops 8813272891392 [35]

Pid: 8846, CPU 0, comm:            configure
psr : 0000101008026018 ifs : 800000000000028a ip  : [<a000000100079090>]    Not tainted
ip is at mm_release+0x70/0x120
unat: 0000000000000000 pfs : 0000000000000814 rsc : 0000000000000003
rnat: a0000001005691bc bsps: e00000003e2828d0 pr  : 00000000656656a5
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70033f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a0000001000827a0 b6  : a000000100013da0 b7  : a000000100075c40
f6  : 0fffafffffffff0000000 f7  : 0ffdea000000000000000
f8  : 10002a000000000000000 f9  : 100038000000000000000
f10 : 0fffe9ffffffff6000000 f11 : 1003e0000000000000000
r1  : a000000100820000 r2  : 0000000000000000 r3  : a0000001006569f0
r8  : 0000000000000000 r9  : 00000fffffffbfff r10 : e00000003e282980


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 35 of 53} >























r11 : e00000003e2800ec r12 : e00000003e2829e0 r13 : e00000003e280000
r14 : 0000000000000028 r15 : e00000003e280260 r16 : 0000000000000000
r17 : e00000003e280e30 r18 : e00000003e280e70 r19 : e00000003e2802e0
r20 : 0000000000000044 r21 : 0000000000000044 r22 : a0000001006fcb38
r23 : ffffffffffffffff r24 : 0000000000000000 r25 : e00000003e280020
r26 : a0000001006fcb38 r27 : 000000000000003e r28 : 0000001008022018
r29 : 0000000000004000 r30 : e00000003e282980 r31 : a0000001006fcb38

Call Trace:
 [<a000000100013f00>] show_stack+0x80/0xa0
                                sp=e00000003e2843e0 bsp=e00000003e2843c0
 [<a0000001000360b0>] die+0x130/0x1a0
                                sp=e00000003e2845b0 bsp=e00000003e284388
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e2845b0 bsp=e00000003e284320
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e284640 bsp=e00000003e284320
 <1>Unable to handle kernel NULL pointer dereference (address 0000000000000028)
configure[8846]: Oops 8813272891392 [36]



MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 36 of 53} >























Pid: 8846, CPU 0, comm:            configure
psr : 0000101008026018 ifs : 800000000000028a ip  : [<a000000100079090>]    Not tainted
ip is at mm_release+0x70/0x120
unat: 0000000000000000 pfs : 0000000000000814 rsc : 0000000000000003
rnat: a0000001005691bc bsps: e00000003e282670 pr  : 00000000656656a5
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70033f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a0000001000827a0 b6  : a000000100013da0 b7  : a000000100075c40
f6  : 0fffafffffffff0000000 f7  : 0ffdc8000000000000000
f8  : 100008000000000000000 f9  : 100038000000000000000
f10 : 0fffbfffffffff0000000 f11 : 1003e0000000000000000
r1  : a000000100820000 r2  : 0000000000000000 r3  : a0000001006569f0
r8  : 0000000000000000 r9  : 00000fffffffbfff r10 : e00000003e282720
r11 : e00000003e2800ec r12 : e00000003e282780 r13 : e00000003e280000
r14 : 0000000000000028 r15 : e00000003e280260 r16 : 0000000000000000
r17 : e00000003e280e30 r18 : e00000003e280e70 r19 : e00000003e2802e0
r20 : 0000000000000044 r21 : 0000000000000044 r22 : a0000001006fcb38
r23 : ffffffffffffffff r24 : 0000000000000000 r25 : e00000003e280020
r26 : a0000001006fcb38 r27 : 000000000000003e r28 : 0000001008022018
r29 : 0000000000004000 r30 : e00000003e282720 r31 : a0000001006fcb38


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 37 of 53} >
























Call Trace:
 [<a000000100013f00>] show_stack+0x80/0xa0
                                sp=e00000003e284558 bsp=e00000003e284538
 [<a0000001000360b0>] die+0x130/0x1a0
                                sp=e00000003e284728 bsp=e00000003e284500
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e284728 bsp=e00000003e284498
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e2847b8 bsp=e00000003e284498
 <1>Unable to handle kernel NULL pointer dereference (address 0000000000000028)
configure[8846]: Oops 8813272891392 [37]

Pid: 8846, CPU 0, comm:            configure
psr : 0000101008026018 ifs : 800000000000028a ip  : [<a000000100079090>]    Not tainted
ip is at mm_release+0x70/0x120
unat: 0000000000000000 pfs : 0000000000000814 rsc : 0000000000000003
rnat: a0000001005691bc bsps: e00000003e282410 pr  : 00000000656656a5
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70033f
csd : 0000000000000000 ssd : 0000000000000000


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 38 of 53} >























b0  : a0000001000827a0 b6  : a000000100013da0 b7  : a000000100075c40
f6  : 1003e8208208208208209 f7  : 0ffdc8000000000000000
f8  : 1003efffffffffffffff6 f9  : 1003e0000000000000013
f10 : 0fffbfffffffff0000000 f11 : 1003e0000000000000000
r1  : a000000100820000 r2  : 0000000000000000 r3  : a0000001006569f0
r8  : 0000000000000000 r9  : 00000fffffffbfff r10 : e00000003e2824c0
r11 : e00000003e2800ec r12 : e00000003e282520 r13 : e00000003e280000
r14 : 0000000000000028 r15 : e00000003e280260 r16 : 0000000000000000
r17 : e00000003e280e30 r18 : e00000003e280e70 r19 : e00000003e2802e0
r20 : 0000000000000044 r21 : 0000000000000044 r22 : a0000001006fcb38
r23 : ffffffffffffffff r24 : 0000000000000000 r25 : e00000003e280020
r26 : a0000001006fcb38 r27 : 000000000000003e r28 : 0000001008022018
r29 : 0000000000004000 r30 : e00000003e2824c0 r31 : a0000001006fcb38

Call Trace:
 [<a000000100013f00>] show_stack+0x80/0xa0
                                sp=e00000003e2846d0 bsp=e00000003e2846b0
 [<a0000001000360b0>] die+0x130/0x1a0
                                sp=e00000003e2848a0 bsp=e00000003e284678
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 39 of 53} >























                                sp=e00000003e2848a0 bsp=e00000003e284610
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e284930 bsp=e00000003e284610
 <1>Unable to handle kernel NULL pointer dereference (address 0000000000000028)
configure[8846]: Oops 8813272891392 [38]

Pid: 8846, CPU 0, comm:            configure
psr : 0000101008026018 ifs : 800000000000028a ip  : [<a000000100079090>]    Not tainted
ip is at mm_release+0x70/0x120
unat: 0000000000000000 pfs : 0000000000000814 rsc : 0000000000000003
rnat: a0000001005691bc bsps: e00000003e2821b0 pr  : 00000000656656a5
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70033f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a0000001000827a0 b6  : a000000100013da0 b7  : a000000100075c40
f6  : 0fffafffffffff0000000 f7  : 0ffdc8000000000000000
f8  : 100008000000000000000 f9  : 100038000000000000000
f10 : 0fffbfffffffff0000000 f11 : 1003e0000000000000000
r1  : a000000100820000 r2  : 0000000000000000 r3  : a0000001006569f0
r8  : 0000000000000000 r9  : 00000fffffffbfff r10 : e00000003e282260
r11 : e00000003e2800ec r12 : e00000003e2822c0 r13 : e00000003e280000


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 40 of 53} >























r14 : 0000000000000028 r15 : e00000003e280260 r16 : 0000000000000000
r17 : e00000003e280e30 r18 : e00000003e280e70 r19 : e00000003e2802e0
r20 : 0000000000000044 r21 : 0000000000000044 r22 : a0000001006fcb38
r23 : ffffffffffffffff r24 : 0000000000000000 r25 : e00000003e280020
r26 : a0000001006fcb38 r27 : 000000000000003e r28 : 0000001008022018
r29 : 0000000000004000 r30 : e00000003e282260 r31 : a0000001006fcb38

Call Trace:
 [<a000000100013f00>] show_stack+0x80/0xa0
                                sp=e00000003e284848 bsp=e00000003e284828
 [<a0000001000360b0>] die+0x130/0x1a0
                                sp=e00000003e284a18 bsp=e00000003e2847e8
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e284a18 bsp=e00000003e284780
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e284aa8 bsp=e00000003e284780
 [<fffffffff0000000>] 0xfffffffff0000000
                                sp=e00000003e284c78 bsp=e00000003e284398
 <1>Unable to handle kernel NULL pointer dereference (address 0000000000000028)
configure[8846]: Oops 8813272891392 [39]


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 41 of 53} >
























Pid: 8846, CPU 0, comm:            configure
psr : 0000101008026018 ifs : 800000000000028a ip  : [<a000000100079090>]    Not tainted
ip is at mm_release+0x70/0x120
unat: 0000000000000000 pfs : 0000000000000814 rsc : 0000000000000003
rnat: a0000001005691bc bsps: e00000003e281f50 pr  : 00000000656656a5
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70033f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a0000001000827a0 b6  : a000000100013da0 b7  : a000000100075c40
f6  : 0fffafffffffff0000000 f7  : 0ffdef000000000000000
f8  : 10002f000000000000000 f9  : 100038000000000000000
f10 : 0fffeeffffffff1000000 f11 : 1003e0000000000000000
r1  : a000000100820000 r2  : 0000000000000000 r3  : a0000001006569f0
r8  : 0000000000000000 r9  : 00000fffffffbfff r10 : e00000003e282000
r11 : e00000003e2800ec r12 : e00000003e282060 r13 : e00000003e280000
r14 : 0000000000000028 r15 : e00000003e280260 r16 : 0000000000000000
r17 : e00000003e280e30 r18 : e00000003e280e70 r19 : e00000003e2802e0
r20 : 0000000000000044 r21 : 0000000000000044 r22 : a0000001006fcb38
r23 : ffffffffffffffff r24 : 0000000000000000 r25 : e00000003e280020
r26 : a0000001006fcb38 r27 : 000000000000003e r28 : 0000001008022018


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 42 of 53} >























r29 : 0000000000004000 r30 : e00000003e282000 r31 : a0000001006fcb38

Call Trace:
 [<a000000100013f00>] show_stack+0x80/0xa0
                                sp=e00000003e2849b8 bsp=e00000003e284998
 [<a0000001000360b0>] die+0x130/0x1a0
                                sp=e00000003e284b88 bsp=e00000003e284960
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e284b88 bsp=e00000003e2848f8
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e284c18 bsp=e00000003e2848f8
 <1>Unable to handle kernel NULL pointer dereference (address 0000000000000028)
configure[8846]: Oops 8813272891392 [40]

Pid: 8846, CPU 0, comm:            configure
psr : 0000101008026018 ifs : 800000000000028a ip  : [<a000000100079090>]    Not tainted
ip is at mm_release+0x70/0x120
unat: 0000000000000000 pfs : 0000000000000814 rsc : 0000000000000003
rnat: a0000001005691bc bsps: e00000003e281cf0 pr  : 00000000656656a5
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70033f


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 43 of 53} >























csd : 0000000000000000 ssd : 0000000000000000
b0  : a0000001000827a0 b6  : a000000100013da0 b7  : a000000100075c40
f6  : 0fffafffffffff0000000 f7  : 0ffdc8000000000000000
f8  : 100008000000000000000 f9  : 100038000000000000000
f10 : 0fffbfffffffff0000000 f11 : 1003e0000000000000000
r1  : a000000100820000 r2  : 0000000000000000 r3  : a0000001006569f0
r8  : 0000000000000000 r9  : 00000fffffffbfff r10 : e00000003e281da0
r11 : e00000003e2800ec r12 : e00000003e281e00 r13 : e00000003e280000
r14 : 0000000000000028 r15 : e00000003e280260 r16 : 0000000000000000
r17 : e00000003e280e30 r18 : e00000003e280e70 r19 : e00000003e2802e0
r20 : 0000000000000044 r21 : 0000000000000044 r22 : a0000001006fcb38
r23 : ffffffffffffffff r24 : 0000000000000000 r25 : e00000003e280020
r26 : a0000001006fcb38 r27 : 000000000000003e r28 : 0000001008022018
r29 : 0000000000004000 r30 : e00000003e281da0 r31 : a0000001006fcb38

Call Trace:
 [<a000000100013f00>] show_stack+0x80/0xa0
                                sp=e00000003e284b30 bsp=e00000003e284b10
 [<a0000001000360b0>] die+0x130/0x1a0
                                sp=e00000003e284d00 bsp=e00000003e284ad8


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 44 of 53} >























 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e284d00 bsp=e00000003e284a70
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e284d90 bsp=e00000003e284a70
 <1>Unable to handle kernel NULL pointer dereference (address 0000000000000028)
configure[8846]: Oops 8813272891392 [41]

Pid: 8846, CPU 0, comm:            configure
psr : 0000101008026018 ifs : 800000000000028a ip  : [<a000000100079090>]    Not tainted
ip is at mm_release+0x70/0x120
unat: 0000000000000000 pfs : 0000000000000814 rsc : 0000000000000003
rnat: a0000001005691bc bsps: e00000003e281a90 pr  : 00000000656656a5
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70033f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a0000001000827a0 b6  : a000000100013da0 b7  : a000000100075c40
f6  : 0fffafffffffff0000000 f7  : 0ffdc8000000000000000
f8  : 100008000000000000000 f9  : 100038000000000000000
f10 : 0fffbfffffffff0000000 f11 : 1003e0000000000000000
r1  : a000000100820000 r2  : 0000000000000000 r3  : a0000001006569f0
r8  : 0000000000000000 r9  : 00000fffffffbfff r10 : e00000003e281b40


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 45 of 53} >























r11 : e00000003e2800ec r12 : e00000003e281ba0 r13 : e00000003e280000
r14 : 0000000000000028 r15 : e00000003e280260 r16 : 0000000000000000
r17 : e00000003e280e30 r18 : e00000003e280e70 r19 : e00000003e2802e0
r20 : 0000000000000044 r21 : 0000000000000044 r22 : a0000001006fcb38
r23 : ffffffffffffffff r24 : 0000000000000000 r25 : e00000003e280020
r26 : a0000001006fcb38 r27 : 000000000000003e r28 : 0000001008022018
r29 : 0000000000004000 r30 : e00000003e281b40 r31 : a0000001006fcb38

Call Trace:
 [<a000000100013f00>] show_stack+0x80/0xa0
                                sp=e00000003e284ca8 bsp=e00000003e284c88
 [<a0000001000360b0>] die+0x130/0x1a0
                                sp=e00000003e284e78 bsp=e00000003e284c50
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e284e78 bsp=e00000003e284be0
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e284f08 bsp=e00000003e284be0
 <1>Unable to handle kernel NULL pointer dereference (address 0000000000000028)
configure[8846]: Oops 8813272891392 [42]



MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 46 of 53} >























Pid: 8846, CPU 0, comm:            configure
psr : 0000101008026018 ifs : 800000000000028a ip  : [<a000000100079090>]    Not tainted
ip is at mm_release+0x70/0x120
unat: 0000000000000000 pfs : 0000000000000814 rsc : 0000000000000003
rnat: a0000001005691bc bsps: e00000003e281830 pr  : 00000000656656a5
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70033f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a0000001000827a0 b6  : a000000100013da0 b7  : a000000100075c40
f6  : 0fffafffffffff0000000 f7  : 0ffdc8000000000000000
f8  : 100008000000000000000 f9  : 100038000000000000000
f10 : 0fffbfffffffff0000000 f11 : 1003e0000000000000000
r1  : a000000100820000 r2  : 0000000000000000 r3  : a0000001006569f0
r8  : 0000000000000000 r9  : 00000fffffffbfff r10 : e00000003e2818e0
r11 : e00000003e2800ec r12 : e00000003e281940 r13 : e00000003e280000
r14 : 0000000000000028 r15 : e00000003e280260 r16 : 0000000000000000
r17 : e00000003e280e30 r18 : e00000003e280e70 r19 : e00000003e2802e0
r20 : 0000000000000044 r21 : 0000000000000044 r22 : a0000001006fcb38
r23 : ffffffffffffffff r24 : 0000000000000000 r25 : e00000003e280020
r26 : a0000001006fcb38 r27 : 000000000000003e r28 : 0000001008022018
r29 : 0000000000004000 r30 : e00000003e2818e0 r31 : a0000001006fcb38


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 47 of 53} >
























Call Trace:
 [<a000000100013f00>] show_stack+0x80/0xa0
                                sp=e00000003e284e20 bsp=e00000003e284e00
 [<a0000001000360b0>] die+0x130/0x1a0
                                sp=e00000003e284ff0 bsp=e00000003e284dc0
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920
                                sp=e00000003e284ff0 bsp=e00000003e284d58
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e285080 bsp=e00000003e284d58
 <1>Unable to handle kernel NULL pointer dereference (address 0000000000000028)
configure[8846]: Oops 8813272891392 [43]

Pid: 8846, CPU 0, comm:            configure
psr : 0000101008026018 ifs : 800000000000028a ip  : [<a000000100079090>]    Not tainted
ip is at mm_release+0x70/0x120
unat: 0000000000000000 pfs : 0000000000000814 rsc : 0000000000000003
rnat: a0000001005691bc bsps: e00000003e2815d0 pr  : 00000000656656a5
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70033f
csd : 0000000000000000 ssd : 0000000000000000


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 48 of 53} >























b0  : a0000001000827a0 b6  : a000000100013da0 b7  : a000000100075c40
f6  : 0fffafffffffff0000000 f7  : 0ffdc8000000000000000
f8  : 100008000000000000000 f9  : 100038000000000000000
f10 : 0fffbfffffffff0000000 f11 : 1003e0000000000000000
r1  : a000000100820000 r2  : 0000000000000000 r3  : a0000001006569f0
r8  : 0000000000000000 r9  : 00000fffffffbfff r10 : e00000003e281680
r11 : e00000003e2800ec r12 : e00000003e2816e0 r13 : e00000003e280000
r14 : 0000000000000028 r15 : e00000003e280260 r16 : 0000000000000000
r17 : e00000003e280e30 r18 : e00000003e280e70 r19 : e00000003e2802e0
r20 : 0000000000000044 r21 : 0000000000000044 r22 : a0000001006fcb38
r23 : ffffffffffffffff r24 : 0000000000000000 r25 : e00000003e280020
r26 : a0000001006fcb38 r27 : 000000000000003e r28 : 0000001008022018
r29 : 0000000000004000 r30 : e00000003e281680 r31 : a0000001006fcb38

Call Trace:
 [<a000000100013f00>] show_stack+0x80/0xa0
                                sp=e00000003e284f90 bsp=e00000003e284f70
 [<a0000001000360b0>] die+0x130/0x1a0
                                sp=e00000003e285160 bsp=e00000003e284f38
 [<a00000010004f730>] ia64_do_page_fault+0x350/0x920


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 49 of 53} >























                                sp=e00000003e285160 bsp=e00000003e284ed0
 [<a00000010000dde0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000003e2851f0 bsp=e00000003e284ed0
 [<a000000100820000>] 0xa000000100820000
                                sp=e00000003e2853c0 bsp=e00000003e284ed0
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
 <6>SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem powerOff showPc unRaw Sync showTasks Unmount 
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem powerOff showPc unRaw Sync showTasks Unmount 
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem powerOff showPc unRaw Sync showTasks Unmount 
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem powerOff showPc unRaw Sync showTasks Unmount 
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem powerOff showPc unRaw Sync showTasks Unmount 
SysRq : Changing Loglevel
Loglevel set to 9
SysRq : Changing Loglevel
Loglevel set to 8
SysRq : Changing Loglevel
Loglevel set to 7
SysRq : Changing Loglevel
Loglevel set to 7


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 50 of 53} >























SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem powerOff showPc unRaw Sync showTasks Unmount 
SysRq : Show Regs

Pid: 8846, CPU 0, comm:            configure
psr : 0000101008026018 ifs : 8000000000000691 ip  : [<a00000010007c950>]    Not tainted
ip is at panic+0x2d0/0x300
unat: 0000000000000000 pfs : 0000000000000691 rsc : 0000000000000003
rnat: a00000010073e22b bsps: a00000010073e210 pr  : 0000000065669665
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70033f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a00000010007c7f0 b6  : a000000100013da0 b7  : a000000100075c40
f6  : 0fffafffffffff0000000 f7  : 0ffdea000000000000000
f8  : 10002a000000000000000 f9  : 100038000000000000000
f10 : 0fffe9ffffffff6000000 f11 : 1003e0000000000000000
r1  : a000000100820000 r2  : 0000000000004000 r3  : 0000000000004000
r8  : 0000000000000000 r9  : a0000001006f7b38 r10 : e00000003e2813e0
r11 : 0000001008022018 r12 : e00000003e281440 r13 : e00000003e280000
r14 : 0000000000000001 r15 : a0000001006569b8 r16 : 0000000000004000
r17 : 0000000000004000 r18 : 0000000000000000 r19 : a0000001006fa520
r20 : e00000407f5bfe18 r21 : a0000001006ebaa8 r22 : a0000001006fcb38


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 51 of 53} >























r23 : a00000010073e218 r24 : 00000000510000c0 r25 : 000000000000dfdd
r26 : a0000001006fcb38 r27 : 000000000000003e r28 : 0000001008022018
r29 : 0000000000004000 r30 : e00000003e2813e0 r31 : a0000001006fcb38

Call Trace:
 [<a000000100013f00>] show_stack+0x80/0xa0
                                sp=e00000003e285630 bsp=e00000003e285610
 [<a0000001002823d0>] sysrq_handle_showregs+0x30/0x60
                                sp=e00000003e285800 bsp=e00000003e2855e0
 [<a000000100282950>] __handle_sysrq_nolock+0x110/0x260
                                sp=e00000003e285800 bsp=e00000003e285598
 [<a000000100282810>] handle_sysrq+0x70/0xa0
                                sp=e00000003e285800 bsp=e00000003e285568
 [<a000000100273430>] kbd_keycode+0x810/0x880
                                sp=e00000003e285800 bsp=e00000003e285500
 [<a000000100273510>] kbd_event+0x70/0x120
                                sp=e00000003e285800 bsp=e00000003e2854c8
 [<a0000001003c90c0>] input_event+0x2a0/0xb20
                                sp=e00000003e285800 bsp=e00000003e285488
 [<a0000001003c82c0>] hidinput_hid_event+0x360/0x560


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 52 of 53} >























                                sp=e00000003e285800 bsp=e00000003e285428
 [<a0000001003be8b0>] hid_process_event+0xb0/0xc0
                                sp=e00000003e285800 bsp=e00000003e2853d8
 [<a0000001003bece0>] hid_input_field+0x420/0x7c0
                                sp=e00000003e285800 bsp=e00000003e285340


MP:CL (+, -, <CR>, C, D, F, L, ? for help, or Ctrl-B to Quit){Pg 53 of 53} >

   MP MAIN MENU:

         CO: Console
        VFP: Virtual Front Panel
         CM: Command Menu
         CL: Console Log
         SL: Show Event Logs
         HE: Main Help Menu
          X: Exit Connection

[hp-ia64console] MP> x
Connection closed by foreign host.
sh-2.05b$ 
Script done on Wed Jun 16 18:12:38 2004


-- 
Bazsi
PGP info: KeyID 9AF8D0A9 Fingerprint CD27 CFB0 802C 0944 9CFD 804E C82C 8EB1


