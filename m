Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbUFBNRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbUFBNRN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 09:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbUFBNRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 09:17:12 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:41963 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S262585AbUFBNRI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 09:17:08 -0400
Date: Wed, 2 Jun 2004 15:16:23 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] explicitly mark recursion count
Message-ID: <20040602131623.GA23017@wohnheim.fh-wedel.de>
References: <200406011929.i51JTjGO006174@eeyore.valparaiso.cl> <Pine.LNX.4.58.0406011255070.14095@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0406011255070.14095@ppc970.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 June 2004 12:58:12 -0700, Linus Torvalds wrote:
> On Tue, 1 Jun 2004, Horst von Brand wrote:
> > 
> > If the comment gets out of sync, you are toast. Too easy for that to
> > happen, IMVHO.
> 
> Yes.
> 
> Recursion should be detectable automatically, the only thing you can't 
> detect easily is the reason to _break_ recursion. 

Correct.  My tool already detects recursions and prints warning, it
just cannot make out the harmful ones and gives a warning for each.

> So how about just having a simple loop finder, and then the only comment 
> you need is a simple /* max recursion: N */ for any point in the loop.

That's what I basically want, at least for trivial recursions with
only one function involved.

For a->b->c->a type recursions, I also need to identify all involved
functions in the correct order, that's where my ugly format comes
from.

RECURSION:	2
STEP:	a
STEP:	b
STEP:	c

This mean that the recursion from a to b to c and back can happen
twice at most.

Sure, the format is ugly.  If anyone really cares I can change it into
any other.  But it gets the job done, so I don't care.

> That still makes it interesting if one function is part of two loops, and
> is logically the place that breaks the recursion for one (or both - with
> different logic) of them. But does that actually happen?

"Interesting" is the wrong word, really.  Imo it doesn't make any
sense to write such code and therefore I don't want to deal with it
either.  Print a warning and be done with it.  See my output:

WARNING: multiple recursions around check_sig()

Jörn

-- 
A victorious army first wins and then seeks battle.
-- Sun Tzu
