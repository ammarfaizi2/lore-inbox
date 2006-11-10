Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161950AbWKJTRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161950AbWKJTRr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 14:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161951AbWKJTRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 14:17:47 -0500
Received: from codepoet.org ([166.70.99.138]:51095 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S1161950AbWKJTRq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 14:17:46 -0500
Date: Fri, 10 Nov 2006 12:17:45 -0700
From: Erik Andersen <andersen@codepoet.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Repeatable Oops, mv643xx_eth in 2.6.18.x
Message-ID: <20061110191745.GA13783@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Pegasos2 powerpc system acting as my home server.  With
2.6.16.x it was 100% stable and I had months of uptime, rebooting
only to periodically apply security updates to the kernel.

With 2.6.17 and 2.6.18, after an uptime of no more than 2 days,
and usually much less, I get a kernel panic, with nothing in the
log.  I finally caught it in the act, and took a picture.
http://codepoet.org/oops.jpg

A quick transcription of the Oops in the screenshot follows:
--------------------------------------------

kernel BUG in eth_alloc_tx_desc_index at drivers/net/mv643xx_eth.c:1070
Oops: Exception in kernel mode, sig: 5 [#1]

Modules linked in: usb_storage uhci_hcd sd_mod scsi_mod tun ide_cd cdrom eepro100 via_rhine
NIP: C0160894 LR: C01609B8 CTR: C0160AF4
REGS: ca2b79b0 TRAP: 0700   Not tainted (2.6.18.1-erik)
MSR: 00021032 <ME,IR,DR>  CR: 82202488 XER: 0000000
TASK = de0ec7b0[9823] 'dansguardian' THREAD: ca2b6000
GPR00: <see screenshot>
GPR08: <see screenshot>
GPR16: <see screenshot>
GPR24: <see screenshot>
NIP [C0160894] eth_alloc_tx_desc_index+0x48/0x50
LR [C01609B8] eth_tx_submit_descs_for_skb+0x28/0x164
Call Trace:
	(unreliable)
	mv643xx_eth_start_xmit+0xa8/0x170
	dev_hard_start_xmit+0x8c/0x14c
	dev_queue_xmit+0x11c/0x2e0
	ip_output+0x198/0x288
	ip_queue_xmit+0x3c0/0x470
	tcp_transmit_skb+x308/0x4c8
	tcp_push_one+0xfc/0x14c
	tcp_sendmsg+0x3d0/0xca4
	inet_sendmsg+0x60/0x7c
	sock_sendmsg+0xb0/0xe4
	sys_sendto+0xd4/0x10c
	sys_socketcall+0x120/0x1d8
	ret_drom_syscall+0x0/0x38
--- Exception: x01 at 0xfdb0e5c
    LR = 0x100120a8
Instruction dump:
<see screenshot>
<see screenshot>
 <0>Kernel panic - not syncing: Fatal exception in interrupt
 <0>Rebooting in 180 seconds.._

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
