Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319212AbSIDQce>; Wed, 4 Sep 2002 12:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319215AbSIDQce>; Wed, 4 Sep 2002 12:32:34 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45323 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319212AbSIDQc2>; Wed, 4 Sep 2002 12:32:28 -0400
Date: Wed, 4 Sep 2002 09:36:42 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Suparna Bhattacharya <suparna@in.ibm.com>
cc: Jens Axboe <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: One more bio for for floppy users in 2.5.33..
In-Reply-To: <200209040725.g847PrUv089710@northrelay01.pok.ibm.com>
Message-ID: <Pine.LNX.4.44.0209040930110.1779-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 4 Sep 2002, Suparna Bhattacharya wrote:
> 
> Oh yes, even I had this fixed this in the bio traversal patches 
> I had posted (had this in the core patch, and mentioned it 
> in the description in the note :) ), guess it went unnoticed.

Well, I've never seen a "this should go in" about it.

Also, it was apparently mixed up with the "bio splitup" stuff, which was 
discussed at least with Jens, and I feel strongly that we shouldn't split, 
we should build up. Jens was working on exactly that.

In other words, I absolutely hate the fact that a major bug-fix was 
 (a) not marked as such and sent to me
and
 (b) mixed up with experimental work for other drivers

Even now (assuming I hadn't fixed it on my own), I would have preferred to
get that fix separately, as it would have impacted the floppy driver, for
example (the fix broke the floppy driver even more than it was before,
because the floppy driver was stupidly trying to work around the original
bug by hand).

Imagine what a horror it is to figure out why a large experimental patch 
breaks an existing driver? My first reaction would have been to just throw 
the large new patch away, since it obviously broke the floppy even more. 
Instead, if I had been passed the bug-fix only, and the floppy had broken 
worse that it was originally, it would have been absolutely _obvious_ 
where the problem was.

In short: please please PLEASE keep fixes to existing code separate from 
new stuff. It makes everything easier, and I have absolutely no problems 
with applying "obvious fixes" even if they might break something else.

In contrast, the new stuff I really don't know if it should go in at all, 
considering that it's trivial (and CPU-efficient) to build up legal bio 
request on the fly and _not_ depend on splitting them later (or at least 
making splitting a special thing only used by things like MD and other 
such indirection layers).

			Linus

