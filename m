Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265763AbUGTJHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265763AbUGTJHJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 05:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265770AbUGTJHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 05:07:09 -0400
Received: from hosting-24.75.rev.fr.colt.net ([213.41.75.24]:57773 "EHLO
	lastinfos.com") by vger.kernel.org with ESMTP id S265763AbUGTJG5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 05:06:57 -0400
Subject: Re: kernel 2.6.7 -> page allocation failure. order:1, mode:0x20
	(netfilter?)
From: Sebastien ESTIENNE <sebest@ovibes.net>
Reply-To: sebest@ovibes.net
To: Harald Welte <laforge@netfilter.org>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org,
       netdev@oss.sgi.com
In-Reply-To: <20040720024741.GF27487@obroa-skai.de.gnumonks.org>
References: <40FB93FE.90308@ovibes.net>
	 <20040720024741.GF27487@obroa-skai.de.gnumonks.org>
Content-Type: text/plain; charset=utf-8
Organization: ethium
Message-Id: <1090314411.13005.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 20 Jul 2004 11:06:51 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar 20/07/2004 à 04:47, Harald Welte a écrit :
> On Mon, Jul 19, 2004 at 11:27:26AM +0200, Sebastien ESTIENNE wrote:
> > Hello,
> > i have some "swapper: page allocation failure. order:1, mode:0x20"
> > followed by kernel message,
> > 
> > the hardware is a dell poweredge 1750
> > the kernel is a 2.6.7 vanilla
> > 
> > here for a dmesg
> > http://213.41.75.25/kernel/dmesg.txt
> the chunk below seems like a standard code path for a locally-generated
> outgoing packet:
> 
> > [<c028ac94>] skb_checksum_help+0x52/0x136
> > [<e094fb79>] ip_nat_fn+0x269/0x27a [iptable_nat]
> > [<e094fcb3>] ip_nat_local_fn+0x7b/0xaa [iptable_nat]
> > [<c028708e>] tcp_sendmsg+0x509/0x10f7
> > [<c0121872>] tasklet_action+0x65/0xae
> > [<c01065da>] apic_timer_interrupt+0x1a/0x20
> > [<c02ad977>] dst_output+0x0/0x29
> > [<c028708e>] inet_sendmsg+0x4d/0x59
> > [<c026498f>] dst_output+0x0/0x29
> > [<c0276a40>] sock_aio_write+0xbd/0xdd
> > [<c015902c>] do_sync_write+0x8b/0xb7
> > [<c01da1ac>] nf_iterate+0x71/0xa2
> > [<c028708e>] copy_from_user+0x42/0x6e
> > [<c0159140>] vfs_write+0xe8/0x119
> > [<c0159216>] sys_write+0x42/0x63
> > [<c0105beb>] syscall_call+0x7/0xb
> 
>  
> what's worrying me is the part above... how would skb_checksum_help
> directly end up in copy_from_user()?
> 
> > swapper: page allocation failure. order:1, mode:0x20
> > [<c013d770>] __alloc_pages+0x2da/0x34a
> > [<c013d805>] __get_free_pages+0x25/0x3f
> > [<c0140e28>] kmem_getpages+0x2b/0xdc
> > [<c0141bfc>] kfree_skbmem+0x24/0x2c
> > [<c0141c5d>] cache_grow+0xe5/0x2a4
> > [<c0141f8a>] cache_grow+0x146/0x2a4
> > [<c0295917>] cache_alloc_refill+0x1cf/0x29f
> > [<c014262a>] __kmalloc+0x85/0x8c
> > [<c02681f1>] tcp_transmit_skb+0x411/0x68a
> > [<c0296621>] alloc_skb+0x47/0xe0
> > [<c026875e>] tcp_write_xmit+0x16d/0x2d6
> > [<c01da1ac>] skb_copy+0x33/0xde
> > [<c026ca5b>] copy_from_user+0x42/0x6e
> 
> Does anybody have a clue what's going on?
I was running apache bench v2 on localhost
And Shorewall firewall script is installed on it (version 2.0.4)
iptables version 2.0.4
hope it can help

