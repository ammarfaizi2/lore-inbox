Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289815AbSCCWdn>; Sun, 3 Mar 2002 17:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289822AbSCCWdX>; Sun, 3 Mar 2002 17:33:23 -0500
Received: from dsl-213-023-040-044.arcor-ip.net ([213.23.40.44]:32909 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289815AbSCCWdN>;
	Sun, 3 Mar 2002 17:33:13 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Maze of include files, all producing errors...
Date: Sun, 3 Mar 2002 23:28:28 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020228204826.C13564@flint.arm.linux.org.uk>
In-Reply-To: <20020228204826.C13564@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16heSy-0000QG-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 28, 2002 09:48 pm, Russell King wrote:
> In 2.5.5 (Changeset 1.359.2.3), the highmem.h and pgalloc.h includes were
> reversed.
> 
> Previous kernels had linux/highmem.h including asm/pgalloc.h.  Placing
> the architecture cache handling functions worked well in asm/pgalloc.h,
> allowing highmem.h to find them; highmem.h uses flush_dcache_page() and
> friends in inline functions.
> 
> In this changeset, highmem.h no longer includes pgalloc.h, but instead
> pgalloc.h includes highmem.h.  This, unfortunately, tends to break things
> in a major way since the cache functions are no longer available to
> highmem.h.
> 
> Looking at x86, the (no-op) cache functions live in pgtable.h.  However,
> trying to put the ARM cache handling into pgtable.h doesn't work because
> we need things like PG_arch_1 and struct page.  pgtable.h is included by
> linux/mm.h before linux/mm.h declares PG_arch_1 and struct page.  So
> obviously this can't work.
> 
> Has anyone encountered this, and has anyone found a magic working
> combination?

I've noticed it's a mess...

I ran into a different problem yesterday.  It seems mmzone.h is included
before struct page is defined and therefore inlines in mmzone.h can't
do arithmetic on the size of struct page.  This forces code in mmzone.h
to be macros instead of inlines.

-- 
Daniel
