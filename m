Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbVAYTG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbVAYTG4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 14:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVAYTG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 14:06:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:12167 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262060AbVAYTF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 14:05:29 -0500
Date: Tue, 25 Jan 2005 11:05:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: John Richard Moser <nigelenki@comcast.net>
cc: Bill Davidsen <davidsen@tmr.com>, Valdis.Kletnieks@vt.edu,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
In-Reply-To: <41F691D6.8040803@comcast.net>
Message-ID: <Pine.LNX.4.58.0501251054400.2342@ppc970.osdl.org>
References: <1106157152.6310.171.camel@laptopd505.fenrus.org>
 <200501191947.j0JJlf3j024206@turing-police.cc.vt.edu> <41F6604B.4090905@tmr.com>
 <Pine.LNX.4.58.0501250741210.2342@ppc970.osdl.org> <41F6816D.1020306@tmr.com>
 <41F68975.8010405@comcast.net> <Pine.LNX.4.58.0501251025510.2342@ppc970.osdl.org>
 <41F691D6.8040803@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 Jan 2005, John Richard Moser wrote:
> > 
> > Sure there is. There's the gain that if you lock the front door but not 
> > the back door, somebody who goes door-to-door, opportunistically knocking 
> > on them and testing them, _will_ be discouraged by locking the front door.
> 
> In the real world yes.  On the computer, the front and back doors are
> half-consumed by a short-path wormhole that places them right next to
> eachother, so not really.  :)

No, the same is true even when the doors are right next to each other.

A lot of worms etc depend on automation, and do one or a few very specific 
things. If one of them doesn't work (not because the computer is _secure_ 
mind you, just some random thing), it's already a more secure setup.

And even if two independent security bugs cause _exactly_ the same
symptoms (ie the exact same exploit works even if either of the bugs still 
remain), having two independent patches that fix them is STILL better. 
Just because the explanation of them is simpler, and the verification of 
them is simpler.

> > Never mind that he still could have gotten in. After all, if you locked 
> > the back door too, he might still have a crow-bar.
> 
> Crowbars don't work in computer security.

Sure they do. They're the brute-force password-cracking. They're the 
physical security of the machine. They are any number of things.

The point being that you will always have holes. Arguing for "there's 
another hole" is _never_ an argument against a small patch fixing one 
problem.

Take it from me - I've been reviewing patches for _way_ too long. And it's
a damn lot easier to review 100 small patches that do simple things and
that have been split up and explained individually byt he submitter than
it is to review 10 big ones.

It's also a lot easier to find the (inevitable) bugs. Either you already 
have a clue ("try reverting that one patch") or you can do things like 
binary searching. The bugs introduced a patch often have very little to do 
with the thing a patch fixes - exactly because the patch _fixes_ 
something, it's been tested with that particular problem, and the new 
problem it introduces is usually orthogonal.

Which is why lots of small patches usually have _different_ bug behaviour
than the patch they fix. To go back to the A+B fix: the bug they fix may
be fixed only by the _combination_ of the patch, but the bug they cause is
often an artifact of _one_ of the patches.

IOW, splitting the patches up makes them
 - easier to merge
 - easier to verify
 - easier to debug

and combining them has _zero_ advantages (whatever bug the combined patch
fix _will_ be fixed by the series of individual patches too - even if the
splitting was buggy in some respect, you are pretty much guaranteed of
this, since the bug you were trying to fix is the _one_ thing you are
really testing for). 

See? 

			Linus
