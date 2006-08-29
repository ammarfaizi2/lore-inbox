Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964989AbWH2OZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbWH2OZQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 10:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWH2OZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 10:25:16 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:14557 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S964989AbWH2OZO (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 10:25:14 -0400
Message-Id: <200608291425.k7TEP7XR004029@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc4-mm3: BUG: warning at include/net/dst.h:154/dst_release()
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1156861507_3126P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 29 Aug 2006 10:25:07 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1156861507_3126P
Content-Type: text/plain; charset=us-ascii

Seeing this a lot on 2.6.18-rc4-mm3 with 2 different stack tracebacks
(one for received packets, other for sending).  I already picked up the
fix for the ^ / confusion in fib_rules.c and that didn't help matters.

[  731.252000] BUG: warning at include/net/dst.h:154/dst_release()
[  731.252000]  [<c01036d4>] dump_trace+0x64/0x1b2
[  731.252000]  [<c0103834>] show_trace_log_lvl+0x12/0x25
[  731.252000]  [<c0103d62>] show_trace+0xd/0x10
[  731.252000]  [<c0103dff>] dump_stack+0x19/0x1b
[  731.252000]  [<c0347fe8>] fib6_rule_action+0x79/0xad
[  731.253000]  [<c02dfe62>] fib_rules_lookup+0x4e/0x93
[  731.255000]  [<c0348065>] fib6_rule_lookup+0x2d/0x7d
[  731.256000]  [<c032fe6d>] rt6_lookup+0x45/0x83
[  731.257000]  [<c032d9cd>] addrconf_prefix_rcv+0xf4/0x743
[  731.258000]  [<c0335410>] ndisc_rcv+0x7d5/0xaf3
[  731.259000]  [<c033ad0e>] icmpv6_rcv+0x767/0x7e9
[  731.260000]  [<c03286d4>] ip6_input+0x1e0/0x2a2
[  731.262000]  [<c03287c8>] ip6_mc_input+0x32/0x40
[  731.263000]  [<c0328bf6>] ipv6_rcv+0x19f/0x1cd
[  731.264000]  [<c02d480b>] netif_receive_skb+0x143/0x1b6
[  731.265000]  [<c02d5bb0>] process_backlog+0x71/0xf3
[  731.266000]  [<c02d5a92>] net_rx_action+0x56/0xcf
[  731.267000]  [<c0116d3c>] __do_softirq+0x38/0x7a
[  731.267000]  [<c010460c>] do_softirq+0x3e/0x87
[  731.267000]  [<c0116cf8>] irq_exit+0x28/0x34
[  731.267000]  [<c01045c1>] do_IRQ+0xab/0xb8
[  731.267000]  [<c010323a>] common_interrupt+0x1a/0x20

[ 1498.555000] BUG: warning at include/net/dst.h:154/dst_release()
[ 1498.555000]  [<c01036d4>] dump_trace+0x64/0x1b2
[ 1498.555000]  [<c0103834>] show_trace_log_lvl+0x12/0x25
[ 1498.555000]  [<c0103d62>] show_trace+0xd/0x10
[ 1498.555000]  [<c0103dff>] dump_stack+0x19/0x1b
[ 1498.555000]  [<c0347db8>] fib6_rule_action+0x79/0xad
[ 1498.557000]  [<c02dfc32>] fib_rules_lookup+0x4e/0x93
[ 1498.558000]  [<c0347e35>] fib6_rule_lookup+0x2d/0x7d
[ 1498.560000]  [<c032fc9c>] ip6_route_output+0x21/0x24
[ 1498.561000]  [<c032647c>] ip6_dst_lookup_tail+0x19/0x92
[ 1498.562000]  [<c0326503>] ip6_dst_lookup+0xe/0x10
[ 1498.563000]  [<c0344727>] ip6_datagram_connect+0x322/0x50a
[ 1498.565000]  [<c0309850>] inet_dgram_connect+0x4b/0x55
[ 1498.566000]  [<c02cc970>] sys_connect+0x67/0x84
[ 1498.567000]  [<c02ccfeb>] sys_socketcall+0x8c/0x186
[ 1498.568000]  [<c01028cf>] syscall_call+0x7/0xb
[ 1498.568000] DWARF2 unwinder stuck at syscall_call+0x7/0xb


--==_Exmh_1156861507_3126P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFE9E5DcC3lWbTT17ARAvFdAJ4tnmu7PwFQxBp6D//1bUVsRJ9HtQCdHQH/
6xRSQHopxPJB4f/3cVqJIjA=
=s/hp
-----END PGP SIGNATURE-----

--==_Exmh_1156861507_3126P--
