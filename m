Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424404AbWKJU31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424404AbWKJU31 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 15:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966110AbWKJU31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 15:29:27 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:15977 "EHLO
	mo-p07-ob.rzone.de") by vger.kernel.org with ESMTP id S966108AbWKJU30
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 15:29:26 -0500
Date: Fri, 10 Nov 2006 21:29:18 +0100 (MET)
From: Olaf Hering <olaf@aepfle.de>
To: andersen@codepoet.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Repeatable Oops, mv643xx_eth in 2.6.18.x
Message-ID: <20061110202919.GA4686@aepfle.de>
References: <20061110191745.GA13783@codepoet.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20061110191745.GA13783@codepoet.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, Erik Andersen wrote:

> I have a Pegasos2 powerpc system acting as my home server.  With
> 2.6.16.x it was 100% stable and I had months of uptime, rebooting
> only to periodically apply security updates to the kernel.
> 
> With 2.6.17 and 2.6.18, after an uptime of no more than 2 days,
> and usually much less, I get a kernel panic, with nothing in the
> log.  I finally caught it in the act, and took a picture.
> http://codepoet.org/oops.jpg

I got a similar crash while doing Xorg pci domain testing (I guess):

Welcome to openSUSE 10.2 (PPC) Beta1plus - Kernel 2.6.18.1-20061102142452-default (console).


e89 login: Oops: Exception in kernel mode, sig: 5 [#1]

Modules linked in: autofs4 ipv6 nfs lockd nfs_acl sunrpc loop pcspkr ide_cd cdrom ohci1394 via_ircc irda crc_ccitt parport_pc ieee1394 uhci_hcd parport via_rhine mv643xx_eth mii via82cxxx
NIP: D1035504 LR: D1037AE0 CTR: D10379E4
REGS: c3919b10 TRAP: 0700   Tainted: G     U  (2.6.18.1-20061102142452-default)
MSR: 00021032 <ME,IR,DR>  CR: 28000488  XER: 00000000
TASK = cc0d9340[3789] 'sshd' THREAD: c3918000
GPR00: 00000000 C3919BC0 CC0D9340 CFF1D280 CFF1D000 00000000 CE4109D2 00000000
GPR08: 00000176 00000001 00001000 00000177 00000000 08080AA0 00000000 00000001
GPR16: 00000005 C3919E34 CD8904E0 00000050 000005A8 00000000 00009032 CFF1D2FC
GPR24: 00000010 00000000 00000000 00000000 D10379E4 CFF1D000 CFF1D280 CB0A62A8
NIP [D1035504] eth_alloc_tx_desc_index+0x44/0x50 [mv643xx_eth]
LR [D1037AE0] mv643xx_eth_start_xmit+0xfc/0x374 [mv643xx_eth]
Call Trace:
[C3919BC0] [CE4109D0] 0xce4109d0 (unreliable)
[C3919C00] [C0262254] dev_hard_start_xmit+0x244/0x2dc
[C3919C20] [C026478C] dev_queue_xmit+0x21c/0x2dc
[C3919C40] [C02884CC] ip_output+0x240/0x294
[C3919C60] [C0288B10] ip_queue_xmit+0x3b4/0x41c
[C3919CE0] [C0298374] tcp_transmit_skb+0x6d4/0x718
[C3919D10] [C029A178] __tcp_push_pending_frames+0x76c/0x858
[C3919D50] [C028F19C] tcp_sendmsg+0xa90/0xbd0
[C3919DB0] [C02AA498] inet_sendmsg+0x60/0x74
[C3919DD0] [C02552A4] do_sock_write+0xd8/0xec
[C3919DF0] [C0255B48] sock_aio_write+0x58/0x74
[C3919E50] [C0083278] do_sync_write+0xbc/0x104
[C3919EF0] [C0083F40] vfs_write+0x104/0x1c8
[C3919F10] [C00845DC] sys_write+0x4c/0x8c
[C3919F40] [C00125DC] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0x7a439b8
    LR = 0x8041020
Instruction dump:
5400fffe 0f000000 81030020 81230024 39680001 7c0b53d6 7c0051d6 7d605850
7d694a78 91630020 7d290034 5529d97e <0f090000> 7d034378 4e800020 2f840001
 <0>Kernel panic - not syncing: Fatal exception in interrupt
 <0>Rebooting in 180 seconds..PegasosII Boot Strap (c) 2002-2005 bplan GmbH (BUILD 20051216202806)
Running on CPU PVR:80020101


It happend only once.
