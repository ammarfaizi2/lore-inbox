Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbTIDXka (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 19:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbTIDXka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 19:40:30 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:18061 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261421AbTIDXk2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 19:40:28 -0400
Date: Fri, 5 Sep 2003 00:40:18 +0100
From: Jamie Lokier <jamie@shareable.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix remap of shared read only mappings
Message-ID: <20030904234018.GA778@mail.jlokier.co.uk>
References: <1062686960.1829.11.camel@mulgrave> <20030904214810.GG31590@mail.jlokier.co.uk> <1062714829.2161.384.camel@mulgrave> <20030904225636.GN31590@mail.jlokier.co.uk> <1062717828.2161.449.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062717828.2161.449.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> I think you may misunderstand what I mean by coherence:  Our problem is
> the VIVT processor caches.  Once one mapper does an msync, that data
> must be visible to all the other mappers, so at that point we have to
> flush the cache lines of all the other mappers.  On PA, we only need to
> flush one correctly aligned address to get the VIVT cache to flush all
> the others.  However, the kernel page cache usually holds an unaligned
> reference so we need to do the extra aligned flush when this data
> changes.  If we didn't do the alignment, we'd need to flush every
> virtual address in the current CPU translation for that page.

Ok, I understand why you want matching alignments now. :)
(So that MS_INVALIDATE doesn't have to do anything).

> If you mean PROT_SEM requires immediate coherence without an msync, then
> those semantics would be very tricky to achieve on parisc since we'd
> need the kernel virtual address of the page in the page cache correctly
> aligned as well.

Linux hasn't ever done anything useful with PROT_SEM.  As far as I
know, on some other systems PROT_SEM has meant that you mark pages
uncacheable or similar, but only on systems where that is needed to
implement IPC through the shared memory.  For some definition IPC.

-- JAmie
