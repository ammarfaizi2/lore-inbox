Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbUFBQ0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbUFBQ0W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 12:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbUFBQ0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 12:26:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:45788 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262020AbUFBQ0U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 12:26:20 -0400
Date: Wed, 2 Jun 2004 09:25:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] explicitly mark recursion count
In-Reply-To: <20040602161721.GA29296@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.58.0406020921220.3403@ppc970.osdl.org>
References: <200406011929.i51JTjGO006174@eeyore.valparaiso.cl>
 <Pine.LNX.4.58.0406011255070.14095@ppc970.osdl.org>
 <20040602131623.GA23017@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020712180.3403@ppc970.osdl.org>
 <20040602142748.GA25939@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020743260.3403@ppc970.osdl.org>
 <20040602150440.GA26474@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020807270.3403@ppc970.osdl.org>
 <20040602152741.GC26474@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020839230.3403@ppc970.osdl.org>
 <20040602161721.GA29296@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 2 Jun 2004, Jörn Engel wrote:
> 
> Works for me for trivial recursions (just one function involved.  With
> a little more pain, it should work for basically everything.  Only
> exception are multiple recursions around the same function.  So unless
> you like to keep those suckers, I'm fine with it.

Well, multiple recursion around the same function seems to be solvable two 
different ways:
 - "don't do that then". It really seems broken, but maybe there are 
   really really good reasons _why_ it's not broken and why it happens.
 - make sure that the separate loops are broken in some _other_ place than 
   in the function they share.

A combination of the two may work well.

I say "may", because maybe I'm wrong, and the condition is common and hard
to avoid limiting in the shared function. I don't have your data (and I'm
lazy, so quite frankly I'd much rather you do the analysis anyway ;).

That said, I just don't see any sane alternatives to my "break in one
place" thing. I believe that anything more complex that tries to explain
the whole loop is just going to be a nightmare to maintain, and fragile as
hell except for totally static legacy code that nobody touches any more.

			Linus
