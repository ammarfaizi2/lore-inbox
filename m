Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268985AbUIQUpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268985AbUIQUpm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 16:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268987AbUIQUpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 16:45:34 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:44881 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268985AbUIQUll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 16:41:41 -0400
Message-ID: <414B4C03.6010704@myrealbox.com>
Date: Fri, 17 Sep 2004 13:41:39 -0700
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a4) Gecko/20040916
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [2.6.9-rc2-bk] Network-related panic on boot
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The panic is caused by ifconfig while configuring the loopback
interface.  The backtrace (copied by hand) follows:

EIP is at fib_hash_move+0x88/0x150
<snippage>
fib_create_info+0x84/0x450
fn_hash_insert+0xaf/0x490
fib_magic+0x111/0x120
rt_run_flush+0x62/0x90
fib_add_ifaddr+0x6d/0x170
fib_netdev_event+0x48/0xc0
notifier_call_chain+0x2d/0x50
dev_open+0x6f/0x90
dev_change_flags+0x51/0x120
dev_load+0x25/0x70
devinet_ioctl+0x25a/0x690
inet_ioctl+0x5e/0xa0
sock_ioctl+0xe9/0x290
sys_ioctl+0xef/0x260
do_page_fault+0x0/0x599
syscall_call+0x7/0xb
<more snippage>
ifconfig exited with preempt_count 1

If I snipped anything important I will be happy to supply it.

 From updating a second machine just now I can say for certain
that it was one or more of the following updates in the last
24 hours which is the culprit:
Applying   1 revisions to crypto/api.c
Applying   1 revisions to include/linux/pfkeyv2.h
Applying   1 revisions to include/linux/xfrm.h
Applying   1 revisions to net/key/af_key.c
Applying   3 revisions to drivers/net/tg3.c
Applying   1 revisions to drivers/net/tg3.h
Applying   1 revisions to include/net/sctp/sctp.h
Applying   1 revisions to net/sctp/protocol.c
Applying   1 revisions to net/sctp/socket.c
Applying   3 revisions to drivers/net/sungem.c
Applying   1 revisions to drivers/net/sungem.h
Applying   1 revisions to fs/compat.c
Applying   1 revisions to include/linux/rtnetlink.h
Applying   2 revisions to include/net/inet_ecn.h
Applying   2 revisions to include/net/ip_fib.h
Applying   1 revisions to include/net/sock.h
Applying   2 revisions to include/net/tcp.h
Applying   1 revisions to net/core/sock.c
Applying   1 revisions to net/ipv4/af_inet.c
Applying   2 revisions to net/ipv4/fib_hash.c
Applying   3 revisions to net/ipv4/fib_semantics.c
Applying   1 revisions to net/ipv4/ip_gre.c
Applying   2 revisions to net/ipv4/netfilter/ip_tables.c
Applying   1 revisions to net/ipv4/raw.c
Applying   2 revisions to net/ipv4/tcp_ipv4.c
Applying   1 revisions to net/ipv4/tcp_minisocks.c
Applying   1 revisions to net/ipv4/udp.c
Applying   1 revisions to net/sched/sch_cbq.c
Applying   1 revisions to net/sched/sch_red.c
Applying   1 revisions to net/ipv4/xfrm4_input.c

Hm.  fib_hash, maybe?

