Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291878AbSBTOxd>; Wed, 20 Feb 2002 09:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291885AbSBTOxY>; Wed, 20 Feb 2002 09:53:24 -0500
Received: from dsl-213-023-038-089.arcor-ip.net ([213.23.38.89]:34977 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S291878AbSBTOxK>;
	Wed, 20 Feb 2002 09:53:10 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [RFC] Page table sharing
Date: Wed, 20 Feb 2002 15:57:37 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>, dmccr@us.ibm.com,
        Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Robert Love <rml@tech9.net>, mingo@redhat.com,
        Andrew Morton <akpm@zip.com.au>, manfred@colorfullife.com,
        wli@holomorphy.com
In-Reply-To: <Pine.LNX.4.21.0202201435230.1136-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.21.0202201435230.1136-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16dYBd-0001M9-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 20, 2002 03:38 pm, Hugh Dickins wrote:
> On Wed, 20 Feb 2002, Daniel Phillips wrote:
> > 
> > Looking at the current try_to_swap_out code I see only a local invalidate, 
> > flush_tlb_page(vma, address), why is that?  How do we know that this mm could 
> > not be in context on another cpu?
> 
> I made the same mistake a few months ago: not noticing #ifndef CONFIG_SMP
> in the header.  arch/i386/kernel/smp.c has the real i386 flush_tlb_page().

OK, well if I'm making the same mistakes then I'm likely on the right track ;)

So it seems that what we need for tlb invalidate of shared page tables is
not worse than what we already have, though there's some extra bookkeeping 
to handle.

Why would we run into your page dirty propagation problem with shared page
tables and not with the current code?

-- 
Daniel
