Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993138AbWJUSFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993138AbWJUSFt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 14:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993139AbWJUSFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 14:05:49 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:49041 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S2993138AbWJUSFt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 14:05:49 -0400
Message-ID: <453A6179.1060500@drzeus.cx>
Date: Sat, 21 Oct 2006 20:05:45 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Git training wheels for the pimple faced maintainer
References: <4537EB67.8030208@drzeus.cx> <Pine.LNX.4.64.0610191629250.3962@g5.osdl.org> <45386E0E.7030404@drzeus.cx> <Pine.LNX.4.64.0610200810390.3962@g5.osdl.org> <4539EBF3.8050607@drzeus.cx> <Pine.LNX.4.64.0610210844560.3962@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610210844560.3962@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Sat, 21 Oct 2006, Pierre Ossman wrote:
>   
>>> HOWEVER! The above obviously only really works correctly if "master" is a 
>>> strict subset of "for-linus".
>>>       
>> Ah, that's a bit of a gotcha. Any nice tricks to keep track of where you
>> where in sync with upstream last? Create a dummy branch/tag perhaps?
>>     
>
> You don't need to. Git keeps track of the fork-point, and you can always 
> get it with
>
> 	git merge-base a b
>
> where "a" and "b" are the two branches.
>
> HOWEVER. If you have _merged_ since (ie your branch contains merges _from_ 
> the branch that you are tracking), this will give you the last 
> merge-point (since that's the last common base), and as such a "diff" from 
> that point will _ignore_ your changes from before the merge. See?
>   

This sounds sufficent. My idea was to freeze my outgoing branches (and
possible topic branches that are "done"). I would like to keep my
development branches up to date though.

In other words, I have a branch "linus" which keeps your current tree.
>From this I'll fork off branches for things going upstream. Until these
have been merged, I won't do any more syncs with "linus". But my
development branch will keep moving with the "linus" branch.

If I read your response above and the man page for git-merge-base, it
will do the right thing even if "linus" now is further in the future
than the point I forked it.

>
>  (a) work on a "individual commit" level:
>
> 	git log -p linus..for-linus
>
>      will show each commit that is in your "for-linus" branch but is _not_ 
>      in your "linus" tracker branch. This does the right thing even in the 
>      presense of merges: it will show the merge commit you did (since that 
>      individual commit is _yours_), but it will not show the commits 
>      merged (since those came from _my_ line of development)
>
>   

Ah, so "git log" will not show the commits that have popped up on
"linus" after "for-linus" branched off? Neat. :)

One concern I had was how to find stuff to cherry-pick when doing a
stable review.

> Anyway, I hope this clarified the issue. I don't think we've actually had 
> a lot of problems with these things in practice. None of this is really 
> "hard", and a lot of it is just getting used to the model. Once you are 
> comfortable with how git works (and using "gitk" to show history tends to 
> be a very visual way to see what is going on in the presense of merges), 
> and get used to working with me, you'll do all of this without even 
> thinking about it.
>
> It really just _sounds_ more complicated than it really is. 
>
>   

git has a lot of these hidden features and ways of doing
less-than-obvious things, so I'm just trying to broaden my repertoire by
consulting those who have been using it on a more daily basis.

I am just thankful git has a reset command ;)

Thanks

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

