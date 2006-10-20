Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992555AbWJTHap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992555AbWJTHap (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 03:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992556AbWJTHap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 03:30:45 -0400
Received: from smtpout.mac.com ([17.250.248.175]:41707 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S2992555AbWJTHao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 03:30:44 -0400
In-Reply-To: <45386E0E.7030404@drzeus.cx>
References: <4537EB67.8030208@drzeus.cx> <Pine.LNX.4.64.0610191629250.3962@g5.osdl.org> <45386E0E.7030404@drzeus.cx>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5D90D82F-662F-4DF4-891A-90A4FA69A84E@mac.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Git training wheels for the pimple faced maintainer
Date: Fri, 20 Oct 2006 03:30:23 -0400
To: Pierre Ossman <drzeus-list@drzeus.cx>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 20, 2006, at 02:34:54, Pierre Ossman wrote:
> Linus Torvalds wrote:
>> That all sounds fine. Please just check the format for the "[GIT  
>> PULL]"  message: Andrew pulls peoples trees on his own and largely  
>> automatically, so he doesn't much care _what_ is in the tree, but  
>> I care deeply. So I want the diffstat and shortlog listings, and  
>> preferably a few sentences at the top of the email describing  
>> what's going on and why things are happening.
>
> I'm still learning the more fancy parts of git, but I think that  
> would be:
>
> git diff master..for-linus | diffstat
> git log master..for-list | git shortlog

Not quite.  diffstat doesn't understand renames and such, you want to  
use something more like this:

git diff -M --stat --summary master..for-linus
git log --pretty=short master..for-linus | git shortlog

As an example, if you rename foo/bar/baz.c to foo/bar/quux.c and  
change a few lines, you'll get something like this:

foo/bar/{baz.c => quux.c}  | 8 +--

It similarly makes renames between directories look nice.

>> So there's simply no point in merging from me, unless you know  
>> that there are clashes due to other development, and you actually  
>> want to fix them up. You will just cause unnecessary criss-cross  
>> merges if you pull from my tree after you've started development,  
>> and the history gets really really messy.
>
> And in order to test for conflicts, I assume I should have a "test  
> tree" that I merge all my local stuff in, together with your  
> current HEAD?

Yes

>> If you actually want your development tree to "track" my tree, I'd  
>> suggest you have your "for-linus" branch that you put the work you  
>> want to track into, and then a plain "linus" branch which tracks  
>> _my_ tree. Then you can just fetch my tree (to keep your "linus"  
>> branch up-to-date), and if you want your development branch to  
>> track those changes, you can just do a "git rebase linus" in your  
>> "for-linus" branch.
>
> If I've understood git correctly, a rebase is a big no-no once I've  
> published those changes as it reverts some history. Right?

Well, sorta.  If it's a pseudo-published development and you actually  
_don't_ _care_ what the old history was (because it was broken or  
incorrect or one of the patches got corrupted during import) then go  
ahead and wipe it out.  On the other hand if you have random people  
pulling from your published tree then you can't safely git-rebase or  
cg-admin-rewrite-hist or similar.  Luckily GIT will just complain  
about a discontinuous history as opposed to losing data.

Cheers,
Kyle Moffett


