Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262972AbUFBO22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbUFBO22 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 10:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbUFBO22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 10:28:28 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:10632 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S262972AbUFBO2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 10:28:25 -0400
Date: Wed, 2 Jun 2004 16:27:48 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] explicitly mark recursion count
Message-ID: <20040602142748.GA25939@wohnheim.fh-wedel.de>
References: <200406011929.i51JTjGO006174@eeyore.valparaiso.cl> <Pine.LNX.4.58.0406011255070.14095@ppc970.osdl.org> <20040602131623.GA23017@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020712180.3403@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0406020712180.3403@ppc970.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 June 2004 07:15:07 -0700, Linus Torvalds wrote:
> On Wed, 2 Jun 2004, Jörn Engel wrote:
> > 
> > For a->b->c->a type recursions, I also need to identify all involved
> > functions in the correct order, that's where my ugly format comes
> > from.
> 
> Why?
> 
> You really only need to know that _one_ of the entries break the 
> recursion, and you need to know what the break depth is for that one 
> entry.
> 
> So for example, if "c" is annotated with "max recursion: 5", then you know 
> that the above loop will recurse at most 5 times.
> 
> I don't see why you need any other information.

Then you see something I don't see.  For example there are quite a few
recursions with some function like

void foo(int depth)
{
	if (!depth) {
		bar(1);
	}
	...
}

bar will, maybe through several more functions call foo(1).

How can you say that foo will beak this recursion after two rounds
max?  What if a changed bar decrements the depth value?  The recursion
will run for infinity now, won't it?  And whoever changed bar doesn't
have a clue that he now fucked up your comment to foo.

I claim:
There is no way to tell the depth of any recursion without looking at
all involved functions.

Prove me wrong, please.

Jörn

-- 
When in doubt, use brute force.
-- Ken Thompson
