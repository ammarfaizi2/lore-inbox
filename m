Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263876AbTKSHYn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 02:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263879AbTKSHYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 02:24:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:18372 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263876AbTKSHYm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 02:24:42 -0500
Date: Tue, 18 Nov 2003 23:24:04 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
cc: Andrew Morton <akpm@osdl.org>, <jon@jon-foster.co.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6-mm] Fix 4G/4G X11/vm86 oops
In-Reply-To: <Pine.LNX.4.53.0311190147060.11537@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.44.0311182310430.23026-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Nov 2003, Zwane Mwaikambo wrote:
> 
> I just tried the RH9 2.96 and it also triple faulted. Oh my.. The only 
> unique thing about this hardware compared ot the other stuff i have here 
> is that it's an AMD K6. Everything else is Intel.

Different TLB sizes (and organizations) etc can _easily_ matter, if the 
Intel one just happens to work because something stays in the TLB while 
the page table mapping is incorrect and keeps the system afloat.

Or - and in this case more likely - since the problem is fixed by running
a (complex) thing that trashes all over the DTLB/ITLB, it's more likely
that there might be a _missing_ TLB invalidate somewhere, and that the
Intel boxes stay up because they have a smaller TLB and the stale entry
gets flushed out early from them.

But you already tried a "flush_tlb_all()" which _should_ have flushed
absolutely everything, including global tables. I dunno. It could be
hitting a CPU bug too, of course. 

It would be interesting to hear if other K6 users see problems..

			Linus

