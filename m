Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289754AbSAWJol>; Wed, 23 Jan 2002 04:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289756AbSAWJoc>; Wed, 23 Jan 2002 04:44:32 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:28171 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289752AbSAWJoN>;
	Wed, 23 Jan 2002 04:44:13 -0500
Date: Wed, 23 Jan 2002 07:44:06 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Duraid Madina <duraid@fl.net.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: VM: Where do we stand?
In-Reply-To: <000901c1a3f0$d2e44ba0$022a17ac@simplex>
Message-ID: <Pine.LNX.4.33L.0201230740230.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002, Duraid Madina wrote:

> I'm sure at least some of you will immediately recognize these words:
>
> >Swap allocation is terrible.  Linux uses a linear array which it scans
> >looking for a free swap block.  It does a relatively simple swap
> >cluster cache, but eats the full linear scan if that fails which can be
> >terribly nasty.  The swap clustering algorithm is a piece of crap,
> >too -- once swap becomes fragmented, the linux swapper falls on its
> >face.

Agreed, scanning for a swap block can take too much CPU
on large machines. We've seen this happen ...

> >It does read-ahead based on the swapblk which wouldn't be bad if it
> >clustered writes by object or didn't have a fragmentation problem.
> >As it stands, their read clustering is useless.  Swap deallocation is
> >fast since they are using a simple reference count array.

Swap readahead improvements very much welcome.

> >File read-ahead is half-hazard at best.

How so?  File read-ahead seems to work pretty well.

> >The paging queues ( determing the age of the page and whether to
> >free or clean it) need to be written... the algorithms being used
> >are terrible.

Fixed in -rmap, http://surriel.com/patches/

> >Linux does not appear to do any page coloring whatsoever, but it would
> >not be hard to add it in.

Not sure how page colouring would interact with the buddy
allocator, though ;)

> 	Where does Linux stand, three years on? An O(1) scheduler is
> nice, but I tell you what'd be even nicer...

I'm working on some of the above issues for the -rmap VM;
if there's something else which really bugs you, I accept
patches ;)

cheers,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

