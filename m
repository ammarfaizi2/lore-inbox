Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263157AbSJBQiq>; Wed, 2 Oct 2002 12:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263158AbSJBQiq>; Wed, 2 Oct 2002 12:38:46 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:23563 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S263157AbSJBQik>; Wed, 2 Oct 2002 12:38:40 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: 2.5.40: raid0_make_request bug and bad: scheduling while atomic!
Date: Wed, 2 Oct 2002 16:43:38 +0000 (UTC)
Organization: Cistron
Message-ID: <anf7nq$qp2$1@ncc1701.cistron.net>
Content-Type: text/plain; charset=iso-8859-15
X-Trace: ncc1701.cistron.net 1033577018 27426 62.216.29.67 (2 Oct 2002 16:43:38 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to test 2.5.40 on a NNTP peering server that pumps
hundreds of gigs per day over the network. Interested to see
if I can increase that with 2.5 ;)

Unfortunately my history databases etc are on RAID0:

raid0_make_request bug: can't convert block across chunks or bigger than 32k 8682080 24
raid0_make_request bug: can't convert block across chunks or bigger than 32k 8679792 24

This appears to be a known problem, but I couldn't find a pointer
to a solution anywhere. Scared, I ran fsck -f /dev/md0,
saw no errors, and booted back to 2.4.19

BTW, got something else that looks worrying during boot:
bad: scheduling while atomic!

cpu: 0, clocks: 99813, slice: 3024
CPU0<T0:99808,T1:96784,D:0,S:3024,C:99813>
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
cpu: 1, clocks: 99813, slice: 3024
CPU1<T0:99808,T1:93760,D:0,S:3024,C:99813>
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
Debug: sleeping function called from illegal context at sched.c:1166
c1b6bf18 c0116234 c02755c0 c0275442 0000048e c1b6bf78 c011499b c0275442 
       0000048e 00000000 c1b6a000 c034a4a0 c1b6bf64 c1b6bfa4 c1b70000 c1b6bf64 
       c034a4a0 00000001 00000001 00000286 c1b6bf78 c01139ab c1b6f040 00000000 
Call Trace:
 [<c0116234>]__might_sleep+0x54/0x58
 [<c011499b>]wait_for_completion+0x1b/0x114
 [<c01139ab>]wake_up_process+0xb/0x10
 [<c0115e16>]set_cpus_allowed+0x14a/0x16c
 [<c0115e88>]migration_thread+0x50/0x33c
 [<c0115e38>]migration_thread+0x0/0x33c
 [<c0105501>]kernel_thread_helper+0x5/0xc

bad: scheduling while atomic!
c1b6bf00 c01143d1 c0275420 c1b6a000 c1b6bf70 c1b6bf78 c1b6bf18 c0116234 
       c02755c0 c0275442 0000048e c1b6bf78 c1b6a000 c1b6bf78 c0114a35 00000000 
       c1b6a000 c034a4a0 c1b6a000 c1b6bfa4 00000000 c1b6e060 c01147dc 00000000 
Call Trace:
 [<c01143d1>]schedule+0x3d/0x404
 [<c0116234>]__might_sleep+0x54/0x58
 [<c0114a35>]wait_for_completion+0xb5/0x114
 [<c01147dc>]default_wake_function+0x0/0x34
 [<c01147dc>]default_wake_function+0x0/0x34
 [<c0115e16>]set_cpus_allowed+0x14a/0x16c
 [<c0115e88>]migration_thread+0x50/0x33c
 [<c0115e38>]migration_thread+0x0/0x33c
 [<c0105501>]kernel_thread_helper+0x5/0xc

CPUS done 4294967295


