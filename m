Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbUFBDMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbUFBDMB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 23:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264909AbUFBDMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 23:12:01 -0400
Received: from Jupiter.Toms.NET ([64.32.223.162]:33967 "EHLO jupiter.toms.net")
	by vger.kernel.org with ESMTP id S264785AbUFBDL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 23:11:57 -0400
Date: Tue, 1 Jun 2004 23:11:56 -0400 (EDT)
From: Tom Oehser <tom@toms.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.6 bug w/ USB & 1394 HDs at the same time...
Message-ID: <Pine.LNX.4.58.0406012310000.22151@jupiter.toms.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- Running 2.6.6
- External USB HD on /dev/sda
- External Firewire HD on /dev/sdb
- umounted the USB HD
- disconnected the USB HD
Got:

Jun  1 21:56:03 jupiter kernel: usb 1-3: USB disconnect, address 2
Jun  1 22:05:06 jupiter kernel: Warning: kfree_skb passed an skb still on a list (from c036c94a).
Jun  1 22:05:06 jupiter kernel: ------------[ cut here ]------------
Jun  1 22:05:06 jupiter kernel: kernel BUG at net/core/skbuff.c:225!
Jun  1 22:05:06 jupiter kernel: invalid operand: 0000 [#1]
Jun  1 22:05:06 jupiter kernel: SMP
Jun  1 22:05:06 jupiter kernel: CPU:    0
Jun  1 22:05:06 jupiter kernel: EIP:    0060:[__kfree_skb+195/288]    Not tainted
Jun  1 22:05:06 jupiter kernel: EFLAGS: 00010296   (2.6.6)
Jun  1 22:05:06 jupiter kernel: EIP is at __kfree_skb+0xc3/0x120
Jun  1 22:05:06 jupiter kernel: eax: 00000045   ebx: c06dd260   ecx: 000008fc   edx: c0590f80
Jun  1 22:05:06 jupiter kernel: esi: 00000000   edi: 00000000   ebp: c221ffd8   esp: c221ffc8
Jun  1 22:05:06 jupiter kernel: ds: 007b   es: 007b   ss: 0068
Jun  1 22:05:06 jupiter kernel: Process khpsbpkt (pid: 20, threadinfo=c221e000 task=f7cfcc30)
Jun  1 22:05:06 jupiter kernel: Stack: c056f738 c036c94a e5bba868 c05b2270 c221ffec c036c94a f7d9cc30 00000091
Jun  1 22:05:06 jupiter kernel:        c036c8d0 00000000 c01042d5 00000000 00000000 00000000
Jun  1 22:05:06 jupiter kernel: Call Trace:
Jun  1 22:05:06 jupiter kernel:  [hpsbpkt_thread+122/144] hpsbpkt_thread+0x7a/0x90
Jun  1 22:05:06 jupiter kernel:  [hpsbpkt_thread+122/144] hpsbpkt_thread+0x7a/0x90
Jun  1 22:05:06 jupiter kernel:  [hpsbpkt_thread+0/144] hpsbpkt_thread+0x0/0x90
Jun  1 22:05:06 jupiter kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Jun  1 22:05:06 jupiter kernel:
Jun  1 22:05:06 jupiter kernel: Code: 0f 0b e1 00 a9 ce 56 c0 8b 4d 08 e9 42 ff ff ff 8b 45 04 c7
Jun  1 22:05:06 jupiter kernel:  <3>ieee1394: sbp2: sbp2util_node_write_no_wait failed
Jun  1 22:05:06 jupiter kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Jun  1 22:05:06 jupiter last message repeated 7 times
Jun  1 22:05:36 jupiter kernel: ieee1394: sbp2: aborting sbp2 command
Jun  1 22:05:36 jupiter kernel: Write (10) 00 00 20 8c c7 00 00 f8 00
Jun  1 22:05:36 jupiter kernel: ieee1394: sbp2: hpsb_node_write failed.
Jun  1 22:05:36 jupiter kernel:
Jun  1 22:05:36 jupiter kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Jun  1 22:05:46 jupiter kernel: ieee1394: sbp2: aborting sbp2 command
Jun  1 22:05:46 jupiter kernel: Test Unit Ready 00 00 00 00 00
Jun  1 22:05:46 jupiter kernel: ieee1394: sbp2: hpsb_node_write failed.
Jun  1 22:05:46 jupiter kernel:
Jun  1 22:05:46 jupiter kernel: ieee1394: sbp2: aborting sbp2 command
Jun  1 22:05:46 jupiter kernel: Write (10) 00 00 20 8e b7 00 00 18 00
Jun  1 22:05:46 jupiter kernel: ieee1394: sbp2: hpsb_node_write failed.
Jun  1 22:05:46 jupiter kernel:
Jun  1 22:05:46 jupiter kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Jun  1 22:05:56 jupiter kernel: ieee1394: sbp2: aborting sbp2 command
Jun  1 22:05:56 jupiter kernel: Test Unit Ready 00 00 00 00 00
Jun  1 22:05:56 jupiter kernel: ieee1394: sbp2: hpsb_node_write failed.
Jun  1 22:05:56 jupiter kernel:
Jun  1 22:05:56 jupiter kernel: ieee1394: sbp2: aborting sbp2 command
Jun  1 22:05:56 jupiter kernel: Write (10) 00 00 20 8d bf 00 00 f8 00
Jun  1 22:05:56 jupiter kernel: ieee1394: sbp2: hpsb_node_write failed.
Jun  1 22:05:56 jupiter kernel:

Is there more that would be helpful?

-Tom
