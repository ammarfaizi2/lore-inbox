Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292806AbSCEXEy>; Tue, 5 Mar 2002 18:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292805AbSCEXEq>; Tue, 5 Mar 2002 18:04:46 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:44338 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S292806AbSCEXE2>; Tue, 5 Mar 2002 18:04:28 -0500
Date: Wed, 6 Mar 2002 00:03:14 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Arjan van de Ven <arjan@fenrus.demon.nl>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-ID: <20020306000314.M20606@dualathlon.random>
In-Reply-To: <20020305161032.F20606@dualathlon.random> <Pine.LNX.4.44L.0203051354590.1413-100000@duckman.distro.conectiva> <20020305192604.J20606@dualathlon.random>, <20020305192604.J20606@dualathlon.random>; <20020305183053.A27064@fenrus.demon.nl> <3C8518AE.B44AF2D5@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C8518AE.B44AF2D5@zip.com.au>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 11:12:46AM -0800, Andrew Morton wrote:
> Arjan van de Ven wrote:
> > 
> > On Tue, Mar 05, 2002 at 07:26:04PM +0100, Andrea Arcangeli wrote:
> > 
> > > Another approch would be to add the pages backing the bh into the lru
> > > too, but then we'd need to mess with the slab and new bitflags, new
> > > methods and so I don't think it's the best solution. The only good
> > > reason for putting new kind of entries in the lru would be to age them
> > > too the same way as the other pages, but we don't need that with the bh
> > > (they're just in, and we mostly care only about the page age, not the bh
> > > age).
> > 
> > For 2.5 I kind of like this idea. There is one issue though: to make
> > this work really well we'd probably need a ->prepareforfreepage()
> > or similar page op (which for page cache pages can be equal to writepage()
> > ) which the vm can use to prepare this page for freeing.
> 
> If we stop using buffer_heads for pagecache I/O, we don't have this problem.
> 
> I'm showing a 20% reduction in CPU load for large reads.  Which is a *lot*,
> given that read load is dominated by copy_to_user.
> 
> 2.5 is significantly less efficient than 2.4 at this time.  Some of that 
> seems to be due to worsened I-cache footprint, and a lot of it is due
> to the way buffer_heads now have a BIO wrapper layer.

Indeed, at the moment bio is making the thing more expensive in CPU
terms, even if OTOH it makes rawio fly.

> Take a look at submit_bh().   The writing is on the wall, guys.
> 
> -


Andrea
