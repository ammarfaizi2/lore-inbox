Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755681AbWKVMvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755681AbWKVMvU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 07:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755693AbWKVMvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 07:51:19 -0500
Received: from toxygen.net ([213.146.59.4]:40204 "EHLO toxygen.net")
	by vger.kernel.org with ESMTP id S1755681AbWKVMvT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 07:51:19 -0500
Date: Wed, 22 Nov 2006 13:50:20 +0100 (CET)
From: Wojtek Kaniewski <wojtekka@toxygen.net>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH take 2] Atmel MACB ethernet driver
In-Reply-To: <20061117172258.51bec4a3@cad-250-152.norway.atmel.com>
Message-ID: <Pine.LNX.4.58L.0611220918170.4718@toxygen.net>
References: <20061109145117.577e3c61@cad-250-152.norway.atmel.com>
 <455C8FB4.8000200@toxygen.net> <20061117172258.51bec4a3@cad-250-152.norway.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2006, Haavard Skinnemoen wrote:
> Hmm...underruns as in "eth0: TX underrun, resetting buffers"?

Yes, that's the message.

> (...)
> 
> If it's a problem with the descriptor, it would probably help to dump
> out some information about the ring state, i.e. the value of
> bp->tx_head and bp->tx_tail, and maybe dump all outstanding descriptors
> in the ring to see if any of them look suspicious.

I've added some printk()s in underrun handler. There's still some data
in the ring (tail=29, head=32), so the driver seems okay. The list of
descriptors:

  tx_ring[28].ctrl=0x8000850e (used=1 wrap=0 und=0 last=1)
  tx_ring[29].ctrl=0x900085ea (used=1 wrap=0 und=1 last=1) TAIL
  tx_ring[30].ctrl=0x000085ea (used=0 wrap=0 und=0 last=1)
  tx_ring[31].ctrl=0x0000850e (used=0 wrap=0 und=0 last=1)
  tx_ring[32].ctrl=0x800085ea (used=1 wrap=0 und=0 last=1) HEAD
  tx_ring[33].ctrl=0x8000850e (used=1 wrap=0 und=0 last=1)

Buffer addresses look fine, tx_ring[29..32].addr don't differ much from
the rest. 

> If it's a bus latency issue, things start to get a bit
> platform-specific, so we should probably involve some more experienced
> ARM people.

Looks like I'll have to wait for upstream support of 9260, because I'm
new to ARM and I won't handle it by myself. Anyway thanks for your help.

Regards,
Wojtek
