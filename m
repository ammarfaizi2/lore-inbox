Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285448AbRL2UEd>; Sat, 29 Dec 2001 15:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285398AbRL2UEX>; Sat, 29 Dec 2001 15:04:23 -0500
Received: from ns.suse.de ([213.95.15.193]:51986 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S285424AbRL2UEK>;
	Sat, 29 Dec 2001 15:04:10 -0500
Date: Sat, 29 Dec 2001 21:04:07 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Larry McVoy <lm@bitmover.com>
Cc: Oliver Xymoron <oxymoron@waste.org>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        <linux-kernel@vger.kernel.org>
Subject: Re: The direction linux is taking
In-Reply-To: <20011229113749.D19306@work.bitmover.com>
Message-ID: <Pine.LNX.4.33.0112292051421.1336-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2001, Larry McVoy wrote:

> One way to quantify this is to ask Linus, Alan, Marcelo, et al, how much
> time they spend merging, i.e., how often do they get patch rejects?
> Regardless of the answer, it will be interesting.  If it is a lot,
> then the patchbot idea has marginal usefulness.  If it is none at all,
> then that says development is serialized, which means we may be leaving
> a lot of progress on the floor.

Bringing the 2.4 fixes forward to 2.5 has been brought about a couple
of head-scratching moments when I've had what appear to be parallel
development of the same piece of code in both trees, it's not so much the
rejects, but a case of 'has this already been fixed in a different way'
or 'is this necessary and does it make sense in 2.5?'.

> I wouldn't be surprised if the serialized case is the answer, or close
> to it.

For some things I think it's definitly the right approach.
A single patch with a dozen peoples changes to the same piece of code
would be a royal pita if it then turns out 1 of them is has problems.

Likewise, Alans patches always seemed to isolate anything which could
make diagnosing problems into seperate releases, eg no VFS & IDE updates
in the same patch unless blindingly obviously correct.

> Anyway, I'm interested to see if there are screams of "all I ever do is
> merge and I hate it" or "merging?  what's that?".

I've only been keeping this tree since the beginning of the month,
so I'm still trying to find my feet a little, but so far merging is
pretty straightforward and usually painless.

The procedure when Linus/Marcelo release a new patch usually goes..

 1. edit the patch to remove any bits that don't make sense
    (eg, I have newer/better version in my tree)
 2. cat ../patch-2.5.x | patch -p1 --dry-run
 3. edit the patch to remove already present hunks.
 4. manually fix up rejects in my tree, and remove reject hunk
    from the diff.
 5. back to (1) until no rejects.
 6. cat ../patch-2.5.x | patch -p1
 7. testing..
 8. Create new diff, and give it a quick readthrough.

Out of all this the initial patch review (step #1) and the final
lookover are by far the most time consuming, and I don't think any
automated tool could speed this up and give me the same level of
understanding over what I'm merging.


Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

