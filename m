Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbUCHXT2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 18:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbUCHXT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 18:19:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:8098 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261185AbUCHXT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 18:19:26 -0500
Date: Mon, 8 Mar 2004 15:21:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in
 <=16G machines)
Message-Id: <20040308152126.54f4f681.akpm@osdl.org>
In-Reply-To: <20040308230247.GC12612@dualathlon.random>
References: <20040308202433.GA12612@dualathlon.random>
	<Pine.LNX.4.58.0403081238060.9575@ppc970.osdl.org>
	<20040308132305.3c35e90a.akpm@osdl.org>
	<20040308230247.GC12612@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> > Other issues are how it will play with remap_file_pages(), and how it
> > impacts Ingo's work to permit remap_file_pages() to set page permissions on
> > a per-page basis.  This change provides large performance improvements to
> 
> in the current form it should be using pte_chains still for nonlinear
> vmas, see the function that pretends to convert the page to be like
> anonymous memory (which simply means to use pte_chains for the reverse
> mappings).  I admit I didn't focus much on that part though, I trust
> Dave on that ;), since I want to drop it.
> 
> What I want to do with the nonlinear vmas is to scan all the ptes in
> every nonlinear vma, so I don't have to allocate the pte_chain and the
> swapping procedure will simply be more cpu hungry under nonlinear vmas.
> I'm not interested to provide optimal performance in swapping nonlinear
> vmas, I prefer the fast path to be as fast as possible and without
> memory overhead.

OK.  There was talk some months ago about making the non-linear vma's
effectively mlocked and unswappable.  That would reduce their usefulness
significantly.  It looks like that's off the table now, which is good.

btw, mincore() has always been broken with nonlinear vma's.  If you could
fix that up some time using that pagetable walker it would be nice.  It's
not very important though.
