Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbVBHXcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbVBHXcW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 18:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbVBHXcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 18:32:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1967 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261689AbVBHXan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 18:30:43 -0500
Date: Tue, 8 Feb 2005 18:30:23 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Fruhwirth Clemens <clemens@endorphin.org>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <michal@logix.cz>, "David S. Miller" <davem@davemloft.net>,
       "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: [PATCH 01/04] Adding cipher mode context information to crypto_tfm
In-Reply-To: <1107880759.15942.109.camel@ghanima>
Message-ID: <Xine.LNX.4.44.0502081821180.1670-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Feb 2005, Fruhwirth Clemens wrote:

> I shot out the last patch too quickly. Having reviewed the mapping one
> more time I noticed, that there as the possibility of "off-by-one"
> unmapping, and instead of doing doubtful guesses, if that's the case, I
> added a base pointer to scatter_walk, which is the pointer returned by
> kmap. Exactly this pointer will be unmapped again, so the vaddr
> comparison in crypto_kunmap doesn't have to do any masking.

You can't call kmap() in softirq context (why was it even trying?):

Debug: sleeping function called from invalid context at arch/i386/mm/highmem.c:5
in_atomic():1, irqs_disabled():0
 [<c0103385>] dump_stack+0x17/0x19
 [<c01165b5>] __might_sleep+0xc4/0xd7
 [<c0112665>] kmap+0x15/0x2e
 [<c0223027>] scatterwalk_map+0x5a/0x68
 [<c0223063>] scatterwalk_walk+0x2e/0x45b
 [<c02239ba>] cbc_decrypt_iv+0x11a/0x15f
 [<c0223a18>] cbc_decrypt+0x19/0x1f
 [<f88ad587>] esp_input+0x17d/0x409 [esp4]
 [<c031b7c4>] xfrm4_rcv_encap+0x102/0x512
 [<c02e5b6f>] ip_local_deliver+0x9d/0x28c
 [<c02e61bf>] ip_rcv+0x251/0x508
 [<c02d177b>] netif_receive_skb+0x1f6/0x223
 [<c02d1824>] process_backlog+0x7c/0x10f
 [<c02d1930>] net_rx_action+0x79/0xfb
 [<c011dfc2>] __do_softirq+0x62/0xcc
 [<c01047b6>] do_softirq+0x57/0x5b



- James
-- 
James Morris
<jmorris@redhat.com>


