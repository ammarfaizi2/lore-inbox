Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312353AbSDCTTo>; Wed, 3 Apr 2002 14:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312350AbSDCTTe>; Wed, 3 Apr 2002 14:19:34 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:61588 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S312348AbSDCTTR>;
	Wed, 3 Apr 2002 14:19:17 -0500
Date: Wed, 3 Apr 2002 14:19:11 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrea Arcangeli <andrea@suse.de>, Arjan van de Ven <arjanv@redhat.com>,
        Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@redhat.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
In-Reply-To: <E16soms-0004Au-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0204031403220.18513-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Apr 2002, Alan Cox wrote:

> >  EXPORT_SYMBOL(vfree);
> >  EXPORT_SYMBOL(__vmalloc);
> > -EXPORT_SYMBOL_GPL(vmalloc_to_page);
> > +EXPORT_SYMBOL(vmalloc_to_page);
> 
> The authors of that code made it GPL. You have no right to change that. Its
> exactly the same as someone taking all your code and making it binary only.
> 
> You are
> 	-	subverting a digital rights management system
> 			[5 years jail in the USA]
> 	-	breaking a license
> 
> but worse than that you are ignoring the basic moral rights of the authors
> of that code.

Alan, that's crap.  The function in question can be trivially turned into
extern inline and removed from export list completely.  _If_ such change
can be made illegal by exporting uninligned version with EXPORT_SYMBOL_GPL
- I'm going to fork the tree *now* and start replacing the stuff exported
that way with untainted clean reimplementations.  As much as I despise
binary-only modules, any mechanism that allows games of that kind needs
to be killed.  One shouldn't be able to prohibit equivalent transformations
of core code (and inlining a function _is_ such transformation) by pulling
the licensing crap.

