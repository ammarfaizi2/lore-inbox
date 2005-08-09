Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbVHIHJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbVHIHJL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 03:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbVHIHJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 03:09:11 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36620 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932412AbVHIHJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 03:09:10 -0400
Date: Tue, 9 Aug 2005 08:08:53 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: ncunningham@cyclades.com, Daniel Phillips <phillips@arcor.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
Message-ID: <20050809080853.A25492@flint.arm.linux.org.uk>
Mail-Followup-To: Nick Piggin <nickpiggin@yahoo.com.au>,
	ncunningham@cyclades.com, Daniel Phillips <phillips@arcor.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Memory Management <linux-mm@kvack.org>,
	Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <42F57FCA.9040805@yahoo.com.au> <200508090710.00637.phillips@arcor.de> <1123562392.4370.112.camel@localhost> <42F83849.9090107@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42F83849.9090107@yahoo.com.au>; from nickpiggin@yahoo.com.au on Tue, Aug 09, 2005 at 02:59:53PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 02:59:53PM +1000, Nick Piggin wrote:
> That would work for swsusp, but there are other users that want to
> know if a struct page is valid ram (eg. ioremap), so in that case
> swsusp would not be able to mess with the flag.

The usage of "valid ram" here is confusing - that's not what PageReserved
is all about.  It's about valid RAM which is managed by method other
than the usual page counting.  Non-reserved RAM is also valid RAM, but
is managed by the kernel in the usual way.

The former is available for remap_pfn_range and ioremap, the latter is
not.

On the other hand, the validity of an apparant RAM address can only be
tested using its pfn with pfn_valid().

Can we straighten out the terminology so it's less confusing please?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
