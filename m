Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263260AbTKYWvy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 17:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbTKYWvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 17:51:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:12441 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263260AbTKYWvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 17:51:53 -0500
Date: Tue, 25 Nov 2003 14:51:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: pinotj@club-internet.fr
cc: manfred@colorfullife.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
In-Reply-To: <mnet1.1069781435.24380.pinotj@club-internet.fr>
Message-ID: <Pine.LNX.4.58.0311251443280.1524@home.osdl.org>
References: <mnet1.1069781435.24380.pinotj@club-internet.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 Nov 2003 pinotj@club-internet.fr wrote:
>
> 3. 2.6.0-test10 vanilla + PREEMPT_CONFIG=y + patch printk + patch magic numbers
> The patch solves the problem, I can compile 4 times a kernel and do heavy work in parallele (load average around 1.2 during 2 hours) without any problems.

Those magic numbers don't make any sense. In particular, SLAB_LIMIT is
clearly bogus both in the original version and in the "magic number
patch". The only place that uses SLAB_LIMIT is the code that decides how
many entries fit in one slab, and quite frankly, it makes no _sense_ to
have a SLAB_LIMIT that is big enough to be unsigned.

"SLAB_LIMIT" should be something in the few hundreds, maybe.

Manfred?  What is the logic behind those nonsensical numbers?

		Linus
