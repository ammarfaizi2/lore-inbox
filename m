Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264331AbTH2EAY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 00:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264388AbTH2EAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 00:00:23 -0400
Received: from oak.cats.ohiou.edu ([132.235.8.44]:31502 "EHLO
	oak1a.cats.ohiou.edu") by vger.kernel.org with ESMTP
	id S264331AbTH2EAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 00:00:15 -0400
Date: Thu, 28 Aug 2003 23:48:22 -0400 (EDT)
From: "Kevin C. Weissman" <kw264301@oak.cats.ohiou.edu>
X-X-Sender: kw264301@oak2a.cats.ohiou.edu
To: linux-kernel@vger.kernel.org
Subject: Qlogic SCSI Oops on 2.6.0-test4
Message-ID: <Pine.OSF.4.50.0308282331470.1348648-100000@oak2a.cats.ohiou.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I originally tried to report this to the authors listed in
drivers/scsi/qlogicisp.c, however they appear to be MIA. (:

Anyways, the main problem is that under heavy periods of disk access the
kernel oops's and panics consistantly. This has been a problem ever since
I first installed linux on this machine over 2 years ago. Until now; the
problem was not very evident, only happening every couple months or so.
However recently I decided I'd try a software RAID5 array, and am not able
to get through the initial construction of the array due to the oops.

Here's this vital info:
CPU: Alphaserver 800 5/500 (EV56)
SCSI: Qlogic ISP 1020
Kernel: 2.6.0-test4 (and lower)
RAM: 64MB ECC
Disks: (1) 36GB IBM, (3) 50GB Seagates
gcc: 2.96

Unfortunatly; I could not get a ksymoops report; as it consistantly
segfaulted (2.4.9). (Example below)

However; using "nm vmlinux" and the "pc" register from the kernel panic;
I'm pretty sure the problem is happening within the "isp1020_intr_handler"
function:

fffffc00004de9e0 isp1020_intr_handler

Also, upon boot, the kernel reports this before the Qlogic ISP driver
loads:

ERROR: SCSI host `isp1020' has no error handling
ERROR: This is not a safe way to run your SCSI host
ERROR: The error handling must be added to this driver
(hex deleted)

I'm sure this couldn't be good for business either. (:

Here's the oops:

Unable to handle kernel paging request at virtual address 00000000000001b8
swapper(0): Oops 1
pc = [<fffffc00004ded84>]  ra = [<fffffc00004ded84>]  ps = 0007 Not tainted
v0 = 0000000000000000  t0 = 0000000000000000  t1 = ffffffffffdab3a8
t2 = 0000000000000000  t3 = 0000000000000003  t4 = 0000000000000011
t5 = fffffc000073bea0  t6 = 0000000000000000  t7 = fffffc00006b4000
s0 = 0000000000000000  s1 = fffffc0003ef32a8  s2 = 0000000000000004
s3 = fffffc0003ef3000  s4 = fffffc00006bc428  s5 = 0000000000000004
s6 = 0000008740000000
a0 = fffffc0003ec20c0  a1 = 0000000000000000  a2 = fffffc00006b7df0
a3 = fffffc00006b7df0  a4 = 0000000000000000  a5 = 0000000000000000
t8 = 000000000000001f  t9 = 0000000046e466ad  t10= 0000000000000000
t11= c9c9c9c9c9c9c9c9  pv = fffffc0000321cb0  at = 0000000000000001
gp = fffffc0000733be8  sp = fffffc00006b7d10
Trace:fffffc00004de9bc fffffc0000318684 fffffc00003190d0 fffffc00003286f4
fffffc00003196f4 fffffc0000313350 fffffc00003151d8 fffffc00003151a0
fffffc00003151d4 fffffc0000310098 fffffc000031001c
Code: b269015c  a0300000  443ff001  402075a1  e4200004  d3400049
<b00901b8> c3e00003
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing


Here's the failed ksymoops attempt:

Warning (read_ksyms): no kernel symbols in ksyms, is /proc/kallsyms a
valid ksyms file?
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address 00000000000001b8
swapper(0): Oops 1
pc = [<fffffc00004ded84>]  ra = [<fffffc00004ded84>]  ps = 0007 Not
tainted
Using defaults from ksymoopsSegmentation fault (core dumped)

Let me know if there's any more information that would be useful. Or if
anyone knows what I'm doing wrong with ksymoops. (; Thanks!

P.S. A CC of the reply to my email would be much appreciated.

Kevin C. Weissman -- weissman@ohiou.edu
Ohio University EECS undergraduate
