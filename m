Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbTIUWGG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 18:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbTIUWGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 18:06:06 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:10222 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262580AbTIUWGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 18:06:02 -0400
Date: Mon, 22 Sep 2003 00:06:00 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: linux-kernel@vger.kernel.org
Subject: linux-2.6.0-test 5 crashes reproducable with a tun / ipv6 setup
Message-ID: <20030921220600.GB15025@stud.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello together,
I am using linux-2.6.0-test5 together with a tun / openvpn[1] setup.
openvpn is a userland application which connects two tun devices on
different machines using udp or tcp packets. We use it at FAU[2] to
provide IPv6 tunnels to our computer science students.

linux-2.6.0-test5 crashes if I try to ping an IPv6 client via a tun
device, when the IPv6 address on the clients (peers) side is
misconfigured. If correctly configured everything works as expected.

skput:under: c039b9db:206 put:14 dev:lo------------[ cut here ]------------
kernel BUG at net/core/skbuff.c:103!
invalid operand: 0000 [#1]
CPU:    3
EIP:    0060:[<c0341ae3>]    Not tainted
EFLAGS: 00010246
EIP is at skb_under_panic+0x2b/0x38
eax: 0000002a   ebx: c039b9db   ecx: c379d0c0   edx: c0483944
esi: d46f6ba8   edi: d3e49800   ebp: d4a1be80   esp: f6b19d64
ds: 007b   es: 007b   ss: 0068
Process openvpn (pid: 648, threadinfo=f6b18000 task=f6a1ece0)
Stack: c045be80 c039b9db 000000ce 0000000e c04cd9e0 d46f6b80 c039b9e3 d4a1be80
       0000000e c039b9db c04de90c f72d6d80 f6b19e24 f6b19e34 f6b18000 c039ba8a
       d4a1be80 c03acfdc d4a1be80 f554be1a d4a1b180 f6d10980 d3e49858 d4a1be80
Call Trace:
 [<c039b9db>] ip6_output2+0x1af/0x228
 [<c039b9e3>] ip6_output2+0x1b7/0x228
 [<c039b9db>] ip6_output2+0x1af/0x228
 [<c039ba8a>] ip6_output+0x36/0x3c
 [<c03acfdc>] ndisc_send_redirect+0x39c/0x480
 [<c039d043>] ip6_forward+0x157/0x310
 [<c039ea49>] ipv6_rcv+0x199/0x230
 [<c03461db>] netif_receive_skb+0x20b/0x260
 [<c03462b9>] process_backlog+0x89/0x118
 [<c03463ce>] net_rx_action+0x86/0x140
 [<c01249eb>] do_softirq+0x6b/0xd8
 [<c02baa56>] tun_chr_writev+0x18e/0x1a0
 [<c015415b>] do_readv_writev+0x1ab/0x254
 [<c02baa68>] tun_chr_write+0x0/0x30
 [<c016502e>] select_bits_free+0xa/0x10
 [<c0165495>] sys_select+0x461/0x470
 [<c0154297>] vfs_writev+0x4b/0x50
 [<c0154319>] sys_writev+0x31/0x4c
 [<c01090cf>] syscall_call+0x7/0xb
Code: 0f 0b 67 00 63 be 45 c0 83 c4 14 5b c3 55 57 56 53 8b 5c 24
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

ping6 <clients ipv6address here> from the 'server' machine triggers the
bug. This is reproducable if something is unclear feel free to ask. :-)

Greetings,
	Thomas

[1] OpenVPN
	http://openvpn.sf.net/

[2] FAU - Friedrich Alexander University
	http://www.uni-erlangen.de/
--
Thomas Glanzmann  ++49 (0) 9131 85-27574   Department of Computer Science III
Martensstrasse 3  D-91058 Erlangen Germany   University of Erlangen-Nuremberg
      http://www3.informatik.uni-erlangen.de/Research/FAUmachine/
