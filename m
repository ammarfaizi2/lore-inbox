Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262010AbUK3GOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbUK3GOE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 01:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbUK3GOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 01:14:04 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:40377
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262010AbUK3GNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 01:13:53 -0500
Date: Mon, 29 Nov 2004 22:11:10 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Andrea Arcangeli <andrea@suse.de>
Cc: marcelo.tosatti@cyclades.com, alan@lxorguk.ukuu.org.uk,
       bgagnon@coradiant.com, linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: Memory leak in 2.4.27 kernel, using mmap raw packet sockets
Message-Id: <20041129221110.717d1236.davem@davemloft.net>
In-Reply-To: <20041130041656.GO4365@dualathlon.random>
References: <OFDDC77A23.4D34536B-ON85256F2D.00514F15-85256F2D.00517F52@coradiant.com>
	<20041015182352.GA4937@logos.cnet>
	<1097980764.13226.21.camel@localhost.localdomain>
	<20041125150206.GF16633@logos.cnet>
	<20041125203248.GD5904@dualathlon.random>
	<20041125171242.GL16633@logos.cnet>
	<20041125231313.GG5904@dualathlon.random>
	<20041125194509.GN16633@logos.cnet>
	<20041126010423.GI5904@dualathlon.random>
	<20041129200331.3cbcab70.davem@davemloft.net>
	<20041130041656.GO4365@dualathlon.random>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2004 05:16:56 +0100
Andrea Arcangeli <andrea@suse.de> wrote:

> On Mon, Nov 29, 2004 at 08:03:31PM -0800, David S. Miller wrote:
> > 
> > These changes have made 2.4.29-BK stop booting on sparc64.
> > I'll get more information to find out exactly why.
> 
> hmm strange, I would suggest to put a dump_stack here to see where it
> triggers:
> 
>                                if (!pages[i] || PageReserved(pages[i])) {
>                                        if (pages[i] != ZERO_PAGE(start)) {
> +					       dump_stack()
>                                                savevma = vma;
>                                                goto bad_page;   
>                                        }
> 
>                                } else
> 
> The only thing I see that's probably missing for sparc is a
> flush_dcache_page page_cache_get, but that wouldn't prevent booting,
> it'd only corrupt userland as worse (and it was missing from the
> previous code too ;).

It's happening very early on, when we boot the second processor,
which means that something wrt. forking the first kernel thread
is perhaps being messed up.

I can't see how get_user_pages() could be involved there, so like I
said I'll try to get some more info.
