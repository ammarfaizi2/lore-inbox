Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132882AbQL2AGy>; Thu, 28 Dec 2000 19:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132883AbQL2AGp>; Thu, 28 Dec 2000 19:06:45 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:18437 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132882AbQL2AGe>; Thu, 28 Dec 2000 19:06:34 -0500
Date: Thu, 28 Dec 2000 15:36:00 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@suse.de>
cc: "David S. Miller" <davem@redhat.com>, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: test13-pre5
In-Reply-To: <20001229001721.B25388@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.10.10012281533060.1123-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Dec 2000, Andi Kleen wrote:

> On Thu, Dec 28, 2000 at 02:54:52PM -0800, David S. Miller wrote:
> >    Date: Thu, 28 Dec 2000 23:58:36 +0100
> >    From: Andi Kleen <ak@suse.de>
> > 
> >    Why exactly a power of two ? To get rid of ->index ? 
> > 
> > To make things like "page - mem_map" et al. use shifts instead of
> > expensive multiplies...
> 
> I thought that is what ->index is for ? 

No. "index" only gives the virtual index.

"page - mem_map" is how you get the _physical_ index in the zone in
question, which is common for physical tranlations (ie "pte_page()",
"page_to_virt()" or "page_to_phys()")

> Also gcc seems to be already quite clever at dividing through small
> integers, e.g. using mul and shift and sub, so it may not be even worth to reach
> for a real power-of-two. 

Look at the code - it's a big multiply to do a divide by 68 or similar.
Quite expensive.

Doing "page->address - TASK_SIZE" on x86 for the non-highmem case would
probably be faster.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
