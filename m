Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271293AbRHOQ6H>; Wed, 15 Aug 2001 12:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271298AbRHOQ55>; Wed, 15 Aug 2001 12:57:57 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:24074 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271293AbRHOQ5m>; Wed, 15 Aug 2001 12:57:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Michael Heinz <mheinz@infiniconsys.com>, linux-kernel@vger.kernel.org
Subject: Re: Implications of PG_locked and reference count in page structures....
Date: Wed, 15 Aug 2001 19:04:16 +0200
X-Mailer: KMail [version 1.3]
In-Reply-To: <3B7A97C5.9090207@infiniconsys.com>
In-Reply-To: <3B7A97C5.9090207@infiniconsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010815165752Z16225-1232+354@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 15, 2001 05:39 pm, Michael Heinz wrote:
> I'm in the process of porting a driver to Linux. The author of the 
> driver conveniently broke it into os-dependent and independent sections.
> 
> One of the things in the "OS" dependent section is a routine to lock a 
> section of memory presumably to be used for DMA.
> 
> So, what I want to do is this: given a pointer to a previously 
> kmalloc'ed block, and the length of that block, I want to (a) identify 
> each page associated with the block and (b) lock each page. It appears 
> that I can lock the page either by incrementing it's reference count, or 
> by setting the PG_locked flag for the page.
> 
> Which method is preferred? Is there another method I should be using 
> instead?

See the other replies - you do not need to memlock your pages because you
will be allocating non-pageable kernel memory.

But for future reference, PG_locked is for serializing IO/cache
operations.  You use the page reference count to prevent a page from
being freed, i.e., to memlock it.  You'll see such object ref-counting
schemes showing up all through the kernel in slight variations.

--
Daniel
