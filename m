Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132694AbQL1X4u>; Thu, 28 Dec 2000 18:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131578AbQL1X4k>; Thu, 28 Dec 2000 18:56:40 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:13041 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S132694AbQL1X4W>; Thu, 28 Dec 2000 18:56:22 -0500
Date: Thu, 28 Dec 2000 21:25:36 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Andi Kleen <ak@suse.de>
cc: "David S. Miller" <davem@redhat.com>, torvalds@transmeta.com,
        marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: test13-pre5
In-Reply-To: <20001229001721.B25388@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.21.0012282123450.1403-100000@duckman.distro.conectiva>
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

Nope, ->index is there to identify which offset the page
has in ->mapping, read mm/filemap.c::__find_page_nolock()
for more info.

> Also gcc seems to be already quite clever at dividing through
> small integers, e.g. using mul and shift and sub, so it may not
> be even worth to reach for a real power-of-two.
> 
> I suspect doing the arithmetics is at least faster than eating the 
> cache misses because of ->index. 

I'm pretty confident that arithmetic is faster than cache
misses ... but an unlucky size of the page struct will cause
extra cache misses due to misalignment.

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
