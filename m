Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129329AbRCEP0a>; Mon, 5 Mar 2001 10:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129339AbRCEP0L>; Mon, 5 Mar 2001 10:26:11 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:7925 "EHLO
	imladris.rielhome.conectiva") by vger.kernel.org with ESMTP
	id <S129344AbRCEP0B>; Mon, 5 Mar 2001 10:26:01 -0500
Date: Mon, 5 Mar 2001 11:20:18 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
cc: Ulrich Kunitz <gefm21@uumail.de>, linux-kernel@vger.kernel.org,
        linux-mm@vger.kernel.org
Subject: Re: [PATCH] tiny MM performance and typo patches for 2.4.2
In-Reply-To: <Pine.LNX.4.33.0103050823320.1034-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0103051115560.5591-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Mar 2001, Mike Galbraith wrote:
> On Sun, 4 Mar 2001, Ulrich Kunitz wrote:
> 
> > patch-uk2 	makes use of the pgd, pmd and pte quicklists for x86 too;
> > 		risky: there might be a reason that 2.4.x doesn't use the
> > 		quicklists.
> 
> I remember these being taken out (long ago), but not why.  Anyone?

They probably wasted too much memory ...

Having _2_ quicklists per CPU (on SMP) is probably the way
to go: one with zeroed pages and one with non-zeroed pages.

This should avoid cache contention in __alloc_pages() and
also avoid unneeded zeroing of pages (when we put away a
zeroed page, eg. an freed pagetable page).

On UP we probably want a (smaller) freelist with zeroed
pages only, since that means we can keep more pages on the
inactive_clean list.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

