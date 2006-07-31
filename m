Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbWGaEQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWGaEQb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 00:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWGaEQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 00:16:31 -0400
Received: from ns1.openconsultancy.com ([207.166.203.131]:27082 "EHLO
	mail.mx.davidcoulson.net") by vger.kernel.org with ESMTP
	id S1751437AbWGaEQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 00:16:30 -0400
X-Spam-Report: SA TESTS
 -2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
Message-ID: <44CD8415.2020403@davidcoulson.net>
Date: Mon, 31 Jul 2006 00:16:21 -0400
From: David Coulson <david@davidcoulson.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060308)
MIME-Version: 1.0
To: netdev@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: BUG: warning at net/core/dev.c:1171/skb_checksum_help() 2.6.18-rc3
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This machine has four NICs running the e1000 kernel module. Other than
the BUG() messages, it seems to be running fine. I was running 2.6.15.4
without any issues on the same hardware, although I noticed the e1000
has been updated (and I went for rc3 since I was hitting the panic in -rc2)

Now, I'm not sure if it also has anything to do with this message:

NAT: no longer support implicit source local NAT
NAT: packet src 10.1.1.1 -> dst 207.166.203.131

Any suggestions as to how to go about debugging this?

BUG: warning at net/core/dev.c:1171/skb_checksum_help()
 [<c02e0412>] skb_checksum_help+0x4d/0xf0
 [<c034e4d3>] ip_nat_fn+0x4e/0x19e
 [<c034e78e>] ip_nat_local_fn+0x3d/0xb9
 [<c0314011>] dst_output+0x0/0x7
 [<c03059ee>] nf_iterate+0x40/0x6e
BUG: warning at net/core/dev.c:1171/skb_checksum_help()
 [<c02e0412>] skb_checksum_help+0x4d/0xf0
 [<c034e4d3>] ip_nat_fn+0x4e/0x19e
 [<c034e78e>] ip_nat_local_fn+0x3d/0xb9
 [<c0314011>] dst_output+0x0/0x7
 [<c03059ee>] nf_iterate+0x40/0x6e
 [<c0314011>] dst_output+0x0/0x7
 [<c0305a5e>] nf_hook_slow+0x42/0x98
 [<c0314011>] dst_output+0x0/0x7
 [<c03123c4>] ip_queue_xmit+0x3a3/0x3fc
 [<c0314011>] dst_output+0x0/0x7
 [<c037f544>] xprt_timer+0x0/0x65
 [<c01e7964>] __next_cpu+0x12/0x1f
 [<c0112a8c>] find_busiest_group+0x17e/0x473
 [<c0320d17>] tcp_transmit_skb+0x39f/0x3bc
 [<c0321f7a>] tcp_write_xmit+0x1a8/0x210
 [<c0322000>] __tcp_push_pending_frames+0x1e/0x6f
 [<c0317d5d>] do_tcp_sendpages+0x4fa/0x521
 [<c0317dcf>] tcp_sendpage+0x4b/0x5e
 [<c02d7fa7>] sock_sendpage+0x31/0x37
 [<c013242e>] file_send_actor+0x30/0x4a
 [<c0131e0b>] do_generic_mapping_read+0x167/0x3d5
 [<c013248a>] generic_file_sendfile+0x42/0x55
 [<c01323fe>] file_send_actor+0x0/0x4a
 [<c019a141>] nfs_file_sendfile+0x59/0x60
 [<c01323fe>] file_send_actor+0x0/0x4a
 [<c014ad07>] do_sendfile+0x1b8/0x252
 [<c01323fe>] file_send_actor+0x0/0x4a
 [<c014adec>] sys_sendfile+0x4b/0x86
 [<c010272f>] syscall_call+0x7/0xb
BUG: warning at net/core/dev.c:1225/skb_gso_segment()
 [<c02e053d>] skb_gso_segment+0x88/0x179
 [<c02e06db>] dev_gso_segment+0x5c/0x82
 [<c02e074a>] dev_hard_start_xmit+0x49/0xb1
 [<c02e0957>] dev_queue_xmit+0x1a5/0x21f
 [<c0311fea>] ip_output+0x1ce/0x205
 [<c03123d6>] ip_queue_xmit+0x3b5/0x3fc
 [<c037f544>] xprt_timer+0x0/0x65
 [<c01e7964>] __next_cpu+0x12/0x1f
 [<c0112a8c>] find_busiest_group+0x17e/0x473
 [<c0320d17>] tcp_transmit_skb+0x39f/0x3bc
 [<c0321f7a>] tcp_write_xmit+0x1a8/0x210
 [<c0322000>] __tcp_push_pending_frames+0x1e/0x6f
 [<c0317d5d>] do_tcp_sendpages+0x4fa/0x521
 [<c0317dcf>] tcp_sendpprintk: 19 messages suppressed.
age+0x4b/0x5e
 eth2.300: received packet with  own address as source address
[<c02d7fa7>] sock_sendpage+0x31/0x37
 [<c013242e>] file_send_actor+0x30/0x4a
 [<c0131e0b>] do_generic_mapping_read+0x167/0x3d5
 [<c013248a>] generic_file_sendfile+0x42/0x55
 [<c01323fe>] file_send_actor+0x0/0x4a
 [<c019a141>] nfs_file_sendfile+0x59/0x60
 [<c01323fe>] file_send_actor+0x0/0x4a
 [<c014ad07>] do_sendfile+0x1b8/0x252
 [<c01323fe>] file_send_actor+0x0/0x4a
 [<c014adec>] sys_sendfile+0x4b/0x86
 [<c010272f>] syscall_call+0x7/0xb
 [<c0314011>] dst_output+0x0/0x7
 [<c0305a5e>] nf_hook_slow+0x42/0x98
 [<c0314011>] dst_output+0x0/0x7
 [<c03123c4>] ip_queue_xmit+0x3a3/0x3fc
 [<c0314011>] dst_output+0x0/0x7
 [<c037f544>] xprt_timer+0x0/0x65
 [<c01e7964>] __next_cpu+0x12/0x1f
 [<c0112a8c>] find_busiest_group+0x17e/0x473
 [<c0320d17>] tcp_transmit_skb+0x39f/0x3bc
 [<c0321f7a>] tcp_write_xmit+0x1a8/0x210
 [<c0322000>] __tcp_push_pending_frames+0x1e/0x6f
 [<c0317d5d>] do_tcp_sendpages+0x4fa/0x521
 [<c0317dcf>] tcp_sendpage+0x4b/0x5e
 [<c02d7fa7>] sock_sendpage+0x31/0x37
 [<c013242e>] file_send_actor+0x30/0x4a
 [<c0131e0b>] do_generic_mapping_read+0x167/0x3d5
 [<c013248a>] generic_file_sendfile+0x42/0x55
 [<c01323fe>] file_send_actor+0x0/0x4a
 [<c019a141>] nfs_file_sendfile+0x59/0x60
 [<c01323fe>] file_send_actor+0x0/0x4a
 [<c014ad07>] do_sendfile+0x1b8/0x252
 [<c01323fe>] file_send_actor+0x0/0x4a
 [<c014adec>] sys_sendfile+0x4b/0x86
 [<c010272f>] syscall_call+0x7/0xb

David

- --
David J. Coulson
email: david@davidcoulson.net
web: http://www.davidcoulson.net/

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEzYQUTIgPQWnLowkRAqHuAKDhAovcE8dIhAofI2KTUXXZOQlXagCcC99R
YGveQogGHtJV8yWbeezn45w=
=upA0
-----END PGP SIGNATURE-----
