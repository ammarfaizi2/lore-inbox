Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWCZK1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWCZK1j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 05:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWCZK1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 05:27:39 -0500
Received: from mx1.slu.se ([130.238.96.70]:8072 "EHLO mx1.slu.se")
	by vger.kernel.org with ESMTP id S1751244AbWCZK1i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 05:27:38 -0500
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17446.27682.102290.341183@robur.slu.se>
Date: Sun, 26 Mar 2006 12:25:38 +0200
To: Jesper Dangaard Brouer <hawk@diku.dk>
Cc: Robert Olsson <Robert.Olsson@data.slu.se>,
       Jens Laas <jens.laas@data.slu.se>, Hans Liss <hans.liss@its.uu.se>,
       "David S. Miller" <davem@davemloft.net>,
       Stephen Hemminger <shemminger@osdl.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Patrick McHardy <kaber@trash.net>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: BUG in FIB trie v.0.404 kernel 2.6.16
In-Reply-To: <Pine.LNX.4.61.0603252254300.25755@ask.diku.dk>
References: <Pine.LNX.4.61.0603252254300.25755@ask.diku.dk>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jesper Dangaard Brouer writes:

 > BUG report for: FIB trie v.0.404
 > Kernel version: 2.6.16
 > 
 > When booting the kernel, the following debug output is printed. I assume 
 > its a bug in the FIB trie code, as it is printed right after the fib tree 
 > code is activated, and some of the functions refer to the trie code.

 > Linux version 2.6.16-orig (hawk@host) (gcc version 3.3.4) #1 SMP PREEMPT Sat Mar 25 22:26:15 CET 2006
 > ...
 > IPv4 FIB: Using LC-trie version 0.404
 > Debug: sleeping function called from invalid context at mm/slab.c:2729
 > in_atomic():1, irqs_disabled():0
 >   [<c0103c4e>] show_trace+0x20/0x24

Hello!

I've have enabled debugging and was expecting to see this as well but I don't.
I'll assume this disapears if you change GFP_KERNEL to GFP_ATOMIC for tnode
and leaf allocations well replace throughout fib_trie.c

Cheers.
					--ro

grep GFP  /usr/src/git/new/net/ipv4/fib_trie.c
                return kcalloc(size, 1, GFP_KERNEL);
        pages = alloc_pages(GFP_KERNEL|__GFP_ZERO, get_order(size));
        struct leaf *l = kmalloc(sizeof(struct leaf),  GFP_KERNEL);
        struct leaf_info *li = kmalloc(sizeof(struct leaf_info),  GFP_KERNEL);
                     GFP_KERNEL);
        stat = kmalloc(sizeof(*stat), GFP_KERNEL);
        struct fib_trie_iter *s = kmalloc(sizeof(*s), GFP_KERNEL);
        struct fib_trie_iter *s = kmalloc(sizeof(*s), GFP_KERNEL);
