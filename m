Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262312AbSJTFwa>; Sun, 20 Oct 2002 01:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262409AbSJTFw3>; Sun, 20 Oct 2002 01:52:29 -0400
Received: from ns.suse.de ([213.95.15.193]:30724 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262312AbSJTFw2>;
	Sun, 20 Oct 2002 01:52:28 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: acme@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv4: only produce one record in fib_seq_show
References: <20021020010331.GB15254@conectiva.com.br.suse.lists.linux.kernel> <20021019.211307.00017347.davem@redhat.com.suse.lists.linux.kernel> <20021020050849.GD15254@conectiva.com.br.suse.lists.linux.kernel> <20021019.221403.116117803.davem@redhat.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 20 Oct 2002 07:58:26 +0200
In-Reply-To: "David S. Miller"'s message of "20 Oct 2002 07:24:27 +0200"
Message-ID: <p73n0p9odml.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> Note that this would prevent ipv4 from being hacked into being
> modular, but there are no plans at all to make modular ipv4 for 2.6.x
> at all so this is a valid transformation/cleanup.

(if ipv4 was made modular) Just reserve the per-cpu statistics space in the 
main kernel when CONFIG_IPV4_MODULE is set. Then you can use it from the module
as needed.

> kernel/timer.c's main data structures desperately want to be per-cpu
> or allocated at boot time also.  It, as has been noted often on this
> list, is actually more bloat than the ipv4 statistics stuff. :-)

.. and many more data structures that are still cacheline padded too.

(my favourite is in balance_dirty_pages_ratelimit which costs 4K overall
for a single per cpu counter)

-Andi
