Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbUEFIIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUEFIIj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 04:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbUEFIIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 04:08:39 -0400
Received: from skynet06.in-ulm.de ([217.10.0.16]:61861 "EHLO
	skynet06.in-ulm.de") by vger.kernel.org with ESMTP id S261500AbUEFIIe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 04:08:34 -0400
Message-ID: <1083830912.4099f280db57d@skynet06.in-ulm.de>
Date: Thu,  6 May 2004 10:08:32 +0200
From: Simon Natterer <simon@natterer-legau.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ISDN/Capi Driver or PPP problem
References: <409964EE.4090805@natterer-legau.de>
In-Reply-To: <409964EE.4090805@natterer-legau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 53.122.197.194
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Natterer wrote:
> I've got a problem with Kernel 2.6.6-rc2 and my AVM-B1 PCI card
> together with a PPP connection.
> When using Asterisk PBX I've got strange problems like dropped
> connections (ppp) or hangups.
> I captured this oops:

Sorry for the disrupted OOps file, here it is again:

 Unable to handle kernel NULL pointer dereference at virtual address 00000004
  printing eip:
 d0a6dff3
 *pde = 00000000
 Oops: 0002 [#1]
 PREEMPT
 CPU:    0
 Stack: 00000004 00000000 00000001 41210a28 00000000 c4465180 c44651a0 00
 EFLAGS: 00010046   (2.6.6-rc2)
 EIP is at capi_read+0x53/0x220 [capi]
 eax: 00000000   ebx: cb3e9c80   ecx: 00000004   edx: 00000206
 esi: ca70c000   edi: c6315530   ebp: c63154a0   esp: ca70df54
 ds: 007b   es: 007b   ss: 0068
 Process asterisk (pid: 8087, threadinfo=ca70c000 task=cd3e2e90)
 Stack: 00000004 00000000 00000001 41210a28 00000000 c4465180 c44651a0 00000880
        c015201d c4465180 080f2168 00000880 c44651a0 c31758e0 00000009 c4465180
        fffffff7 00000003 ca70c000 c01522f2 c4465180 080f2168 00000880 c44651a0
 Call Trace:
  [vfs_read+237/352] vfs_read+0xed/0x160
  [sys_read+66/112] sys_read+0x42/0x70
  [syscall_call+7/11] syscall_call+0x7/0xb

 Code: 89 78 04 89 85 90 00 00 00 c7 43 04 00 00 00 00 c7 03 00 00
  <6>note: asterisk[8087] exited with preempt_count 1
 capilib_new_ncci: kcapi: appl 4 ncci 0x20201 up
 Unable to handle kernel paging request at virtual address 7b230b2a
  printing eip:
 c029a2f4
 *pde = 00000000
 Oops: 0000 [#2]
 PREEMPT
 CPU:    0
 EIP:    0060:[skb_release_data+68/176]    Not tainted
 EFLAGS: 00010297   (2.6.6-rc2)
 EIP is at skb_release_data+0x44/0xb0
 eax: c88b7480   ebx: 00000000   ecx: c88b7480   edx: 7b230b2a
 esi: cda066a0   edi: cc183ec8   ebp: 00000057   esp: cc183d6c
 ds: 007b   es: 007b   ss: 0068
 Process pppoe (pid: 20338, threadinfo=cc182000 task=c5150d10)
 Stack: c029c3d4 cda066a0 cda066e8 c029a373 cda066a0 00000000 00000000 c029a433
        cda066a0 000005f0 cc183f34 cda066a0 d0a3183b cda066a0 cda066a0 cc183ea8
        00000057 c02b8bd0 cffcd6a0 00000057 00000000 000005f0 cc183f34 cc183de4
 Call Trace:
  [skb_copy_datagram_iovec+84/576] skb_copy_datagram_iovec+0x54/0x240
  [kfree_skbmem+19/48] kfree_skbmem+0x13/0x30
  [__kfree_skb+163/320] __kfree_skb+0xa3/0x140
  [__crc_copy_strings_kernel+1461661/3318524] packet_recvmsg+0x12b/0x160
[af_packet]
  [ip_rcv_finish+0/640] ip_rcv_finish+0x0/0x280
  [sock_recvmsg+150/192] sock_recvmsg+0x96/0xc0
  [ip_rcv_finish+0/640] ip_rcv_finish+0x0/0x280
  [__crc_copy_strings_kernel+1427723/3318524]
ppp_receive_nonmp_frame+0x1a9/0x620 [ppp_generic]
  [netif_receive_skb+443/544] netif_receive_skb+0x1bb/0x220
  [recalc_task_prio+168/464] recalc_task_prio+0xa8/0x1d0
  [schedule+813/1472] schedule+0x32d/0x5c0
  [sockfd_lookup+28/128] sockfd_lookup+0x1c/0x80
  [sys_recvfrom+178/288] sys_recvfrom+0xb2/0x120
  [poll_freewait+68/80] poll_freewait+0x44/0x50
  [do_select+431/720] do_select+0x1af/0x2d0
  [sys_recv+51/64] sys_recv+0x33/0x40
  [sys_socketcall+356/608] sys_socketcall+0x164/0x260
  [syscall_call+7/11] syscall_call+0x7/0xb

 Code: 8b 02 f6 c4 08 75 17 8b 42 04 85 c0 74 4a ff 4a 04 0f 94 c0
  <6>kcapi: appl 4 ncci 0x20201 down





