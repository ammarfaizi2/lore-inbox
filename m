Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262042AbVCNWUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbVCNWUF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 17:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbVCNWT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 17:19:28 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:57021 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262035AbVCNWSy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 17:18:54 -0500
Subject: Re: [PATCH 0/4] sparsemem intro patches
From: Dave Hansen <haveblue@us.ibm.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <20050314135021.639d1533.davem@davemloft.net>
References: <1110834883.19340.47.camel@localhost>
	 <20050314135021.639d1533.davem@davemloft.net>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 14:18:31 -0800
Message-Id: <1110838711.19340.58.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-14 at 13:50 -0800, David S. Miller wrote:
> On Mon, 14 Mar 2005 13:14:43 -0800
> Dave Hansen <haveblue@us.ibm.com> wrote:
> 
> > Three of these are i386-only, but one of them reorganizes the macros
> > used to manage the space in page->flags, and will affect all platforms.
> > There are analogous patches to the i386 ones for ppc64, ia64, and
> > x86_64, but those will be submitted by the normal arch maintainers.
> 
> Sparc64 uses some of the upper page->flags bits to store D-cache
> flushing state.
> 
> Specifically, PG_arch_1 is used to set whether the page is scheduled
> for delayed D-cache flushing, and bits 24 and up say which CPU the
> CPU stores occurred on (and thus which CPU will get the cross-CPU
> message to flush it's D-cache should the deferred flush actually
> occur).
> 
> I imagine that since we don't support the domain stuff (yet) on sparc64,
> your patches won't break things, but it is something to be aware of.

Those bits are used today for page_zone() and page_to_nid().  I assume
that you don't support NUMA, but how do you get around the page_zone()
definition?  (a quick grep in asm-sparc64 didn't show anything obvious)

        static inline struct zone *page_zone(struct page *page)
        {
                return zone_table[page->flags >> NODEZONE_SHIFT];
        }
        
BTW, in theory, the new patch should allow page->flags to be better
managed by a variety of users, including special arch users.  An
architecture should be able to relatively easily add the necessary
pieces to reserve them.  We could even have a ARCH_RESERVED_BITS macro
or something.  

-- Dave

