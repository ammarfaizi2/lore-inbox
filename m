Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbVBOLLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVBOLLb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 06:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbVBOLLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 06:11:31 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:28267
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261684AbVBOLLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 06:11:24 -0500
Date: Tue, 15 Feb 2005 12:11:23 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: fix iounmap and a pageattr memleak (x86 and x86-64)
Message-ID: <20050215111123.GZ13712@opteron.random>
References: <20041028192104.GA3454@dualathlon.random> <20041105080716.GL8229@dualathlon.random> <20041105083102.GD16992@wotan.suse.de> <20041105084900.GN8229@dualathlon.random> <20050214231554.GQ13712@opteron.random> <20050215103915.GB2623@wotan.suse.de> <20050215104827.GY13712@opteron.random> <20050215105151.GC2623@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050215105151.GC2623@wotan.suse.de>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 11:51:52AM +0100, Andi Kleen wrote:
> Ok, so it is merely a cosmetic issue.

In practice it's solved, I didn't mean we had a bug still, I'm just
suggesting to fix it in a diffeerent way.

It's not just for cosmetic reasons that I suggest to change this. My
point is that the _real_ reason why we had the bug in the first place is
that people forgets that p->size includes the guard page (because it
shouldn't include the guard page). The fundamental problem of vmalloc
exposing the guard page to the callers (which makes it prone for
mistakes, and prone for breakage if somebody needs all virtual space and
removes the guard page), isn't solved yet.

> I was worried about an actual bug :)

No bugs anymore in practice, the -PAGE_SIZE in arch/x86* is clearly
equivalent to -PAGE_SIZE in mm/vmalloc.c, in practice it's the same
either ways.

> No problem with changing it, but hopefully after 2.6.11.

Ok fine with me, take your time it's clearly not urgent because in
practice no bug can be triggered anymore ;). thanks!
