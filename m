Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262094AbVAYUJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbVAYUJd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 15:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbVAYUJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 15:09:33 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:55683 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262094AbVAYUDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 15:03:02 -0500
Message-ID: <41F6A5F8.5030100@comcast.net>
Date: Tue, 25 Jan 2005 15:03:04 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Bill Davidsen <davidsen@tmr.com>, Valdis.Kletnieks@vt.edu,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
References: <1106157152.6310.171.camel@laptopd505.fenrus.org> <200501191947.j0JJlf3j024206@turing-police.cc.vt.edu> <41F6604B.4090905@tmr.com> <Pine.LNX.4.58.0501250741210.2342@ppc970.osdl.org> <41F6816D.1020306@tmr.com> <41F68975.8010405@comcast.net> <Pine.LNX.4.58.0501251025510.2342@ppc970.osdl.org> <41F691D6.8040803@comcast.net> <Pine.LNX.4.58.0501251054400.2342@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501251054400.2342@ppc970.osdl.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Linus Torvalds wrote:
> 
> On Tue, 25 Jan 2005, John Richard Moser wrote:
> 
>>>Sure there is. There's the gain that if you lock the front door but not 
>>>the back door, somebody who goes door-to-door, opportunistically knocking 
>>>on them and testing them, _will_ be discouraged by locking the front door.
[...]

> 
>>>Never mind that he still could have gotten in. After all, if you locked 
>>>the back door too, he might still have a crow-bar.
>>
>>Crowbars don't work in computer security.
> 
> 
> Sure they do. They're the brute-force password-cracking. They're the 
> physical security of the machine. They are any number of things.
> 
> The point being that you will always have holes. Arguing for "there's 
> another hole" is _never_ an argument against a small patch fixing one 
> problem.
> 

Not what I meant.

http://www.ubuntulinux.org/wiki/USNAnalysis

I'm more focused on this sort of security.  Finding and fixing bugs is
important, but protecting against the exploitation of certain classes of
bugs is also a major step forward.

> Take it from me - I've been reviewing patches for _way_ too long. And it's
> a damn lot easier to review 100 small patches that do simple things and
> that have been split up and explained individually byt he submitter than
> it is to review 10 big ones.
> 

Yeah I noticed.  I'm trying to grep through the grsecurity megapatch and
write an LSM clone (stackable already) based on those hooks to
reimplement GrSecurity, as an academic learning experience.  I try to
make something functional at each step (I did linking restrictions
first), but it's hard to find everything in that gargantuant thing
related to a specific feature :)

That being said, you should also consider (unless somebody forgot to
tell me something) that it takes two source trees to make a split-out
patch.  The author also has to chew down everything but the feature he
wants to split out.  I could probably log 10,000 man-hours splitting up
GrSecurity.  :)

> It's also a lot easier to find the (inevitable) bugs. Either you already 
> have a clue ("try reverting that one patch") or you can do things like 
> binary searching. The bugs introduced a patch often have very little to do 
> with the thing a patch fixes - exactly because the patch _fixes_ 
> something, it's been tested with that particular problem, and the new 
> problem it introduces is usually orthogonal.

true. Very very true.

With things like Gr, there's like a million features.  Normally the
first step I take is "Disable it all".  If it still breaks, THEN THERE'S
A PROBLEM.  If it works, then the binary searching begins.

> 
> Which is why lots of small patches usually have _different_ bug behaviour
> than the patch they fix. To go back to the A+B fix: the bug they fix may
> be fixed only by the _combination_ of the patch, but the bug they cause is
> often an artifact of _one_ of the patches.
> 

Wasn't talking about bugfixes, see above.

> IOW, splitting the patches up makes them
>  - easier to merge
>  - easier to verify
>  - easier to debug
> 
> and combining them has _zero_ advantages (whatever bug the combined patch
> fix _will_ be fixed by the series of individual patches too - even if the
> splitting was buggy in some respect, you are pretty much guaranteed of
> this, since the bug you were trying to fix is the _one_ thing you are
> really testing for). 

Lots of work to split up a patch though.

> 
> See? 
> 
> 			Linus
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB9qX3hDd4aOud5P8RAlMGAJ0cXEbY1QALk6EyfCNJDE26FdRYLQCdGOQB
799/tZxwWQkpv+a/eavf4EY=
=GQR6
-----END PGP SIGNATURE-----
