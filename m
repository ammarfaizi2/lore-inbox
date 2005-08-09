Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbVHIOi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbVHIOi6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 10:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbVHIOi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 10:38:57 -0400
Received: from dvhart.com ([64.146.134.43]:41089 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S964789AbVHIOi5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 10:38:57 -0400
Date: Tue, 09 Aug 2005 07:38:52 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Cc: ncunningham@cyclades.com, Daniel Phillips <phillips@arcor.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
Message-ID: <523240000.1123598289@[10.10.2.4]>
In-Reply-To: <20050809080853.A25492@flint.arm.linux.org.uk>
References: <42F57FCA.9040805@yahoo.com.au> <200508090710.00637.phillips@arcor.de> <1123562392.4370.112.camel@localhost> <42F83849.9090107@yahoo.com.au> <20050809080853.A25492@flint.arm.linux.org.uk>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Russell King <rmk+lkml@arm.linux.org.uk> wrote (on Tuesday, August 09, 2005 08:08:53 +0100):

> On Tue, Aug 09, 2005 at 02:59:53PM +1000, Nick Piggin wrote:
>> That would work for swsusp, but there are other users that want to
>> know if a struct page is valid ram (eg. ioremap), so in that case
>> swsusp would not be able to mess with the flag.
> 
> The usage of "valid ram" here is confusing - that's not what PageReserved
> is all about.  It's about valid RAM which is managed by method other
> than the usual page counting.  Non-reserved RAM is also valid RAM, but
> is managed by the kernel in the usual way.
> 
> The former is available for remap_pfn_range and ioremap, the latter is
> not.
> 
> On the other hand, the validity of an apparant RAM address can only be
> tested using its pfn with pfn_valid().
> 
> Can we straighten out the terminology so it's less confusing please?

pfn_valid() doesn't tell you it's RAM or not - it tells you whether you
have a backing struct page for that address. Could be an IO mapped device,
a small memory hole, whatever.

M.

