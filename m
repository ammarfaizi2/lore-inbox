Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbVBONPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbVBONPn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 08:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbVBONPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 08:15:42 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:39539 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261713AbVBONPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 08:15:37 -0500
Date: Tue, 15 Feb 2005 13:14:53 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: fix iounmap and a pageattr memleak (x86 and x86-64)
In-Reply-To: <20050215111123.GZ13712@opteron.random>
Message-ID: <Pine.LNX.4.61.0502151307480.12506@goblin.wat.veritas.com>
References: <20041028192104.GA3454@dualathlon.random> 
    <20041105080716.GL8229@dualathlon.random> 
    <20041105083102.GD16992@wotan.suse.de> 
    <20041105084900.GN8229@dualathlon.random> 
    <20050214231554.GQ13712@opteron.random> 
    <20050215103915.GB2623@wotan.suse.de> 
    <20050215104827.GY13712@opteron.random> 
    <20050215105151.GC2623@wotan.suse.de> 
    <20050215111123.GZ13712@opteron.random>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2005, Andrea Arcangeli wrote:
> On Tue, Feb 15, 2005 at 11:51:52AM +0100, Andi Kleen wrote:
> 
> It's not just for cosmetic reasons that I suggest to change this. My
> point is that the _real_ reason why we had the bug in the first place is
> that people forgets that p->size includes the guard page (because it
> shouldn't include the guard page). The fundamental problem of vmalloc
> exposing the guard page to the callers (which makes it prone for
> mistakes, and prone for breakage if somebody needs all virtual space and
> removes the guard page), isn't solved yet.

Strongly agree with you.  I remember this nuisance from large-page-patch
days: the guard page (if any) really should be an implementation detail
private to mm/vmalloc.c, never exposed outside.

> > No problem with changing it, but hopefully after 2.6.11.
> 
> Ok fine with me, take your time it's clearly not urgent because in
> practice no bug can be triggered anymore ;). thanks!

Yes, not urgent.  The instance of exposure I remember is one of the
PAGE_SIZEs in fs/proc/kcore.c.

Hugh
