Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751495AbWJTP0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbWJTP0X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 11:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751674AbWJTP0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 11:26:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5097 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751495AbWJTP0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 11:26:22 -0400
Date: Fri, 20 Oct 2006 08:26:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Git training wheels for the pimple faced maintainer
In-Reply-To: <45386E0E.7030404@drzeus.cx>
Message-ID: <Pine.LNX.4.64.0610200810390.3962@g5.osdl.org>
References: <4537EB67.8030208@drzeus.cx> <Pine.LNX.4.64.0610191629250.3962@g5.osdl.org>
 <45386E0E.7030404@drzeus.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Oct 2006, Pierre Ossman wrote:
> 
> I'm still learning the more fancy parts of git, but I think that would be:
> 
> git diff master..for-linus | diffstat

Use "git diff -M --stat master..for-linus" instead.

The "-M" enables rename detection, and the "--stat" does the diffstat for 
you (and better than plain diffstat, since it knows about renames, copies 
and deletes).

HOWEVER! The above obviously only really works correctly if "master" is a 
strict subset of "for-linus".

> git log master..for-linus | git shortlog

Yes.

> And in order to test for conflicts, I assume I should have a "test tree"
> that I merge all my local stuff in, together with your current HEAD?

Exactly. It can be either just a random temporary branch (it's cheap), or 
it can just be your "work tree" that you can keep as messy as you want, 
and then the "for-linus" branch is the cleaned-up version. 

And quite frankly, most of the time you don't even really need one. It 
depends on what you work on, but a _lot_ of the kernel is so independent 
of anything else, that you know that the only thing that will ever really 
conflict is trivial things, and hey, one of the things I do is to fix up 
those conflicts.

In fact, quite often the _right_ thing to do for most developers is to 
just entirely ignore what everybody else is doing, because if there are 
trivial conflicts, I'll take care of them, and if there are more serious 
conflicts, I'll just let you know myself - and you may not even be in a 
position to _know_ about it, because the conflicts could come from 
somebody elses git tree that I just happened to pull before.

So don't worry too much about it. As already mentioned, the _worst_ thing 
you can do is probably to continually pull from my tree to "stay on the 
edge". The way we keep the kernel maintainable is not by having everybody 
try to keep up with everybody else, but by trying to keep things so 
independent that people don't _need_ to keep up with everybody else.

A lot of people seem to just synchronize up at major releases, and then 
rebase their work (which they may even have kept in quilt or something 
else: you don't even have to use "git" for this) on that, and ask me to 
merge the result.

So don't worry too much. 

Also - different people work in different ways, and it's _ok_. 

> If I've understood git correctly, a rebase is a big no-no once I've
> published those changes as it reverts some history. Right?

That is mostly correct. It's a big no-no if somebody has already pulled 
from you, and you want them to pull again. Because at that point, you're 
essentially asking them to pull two totally different versions of the same 
thing - git will do the right thing (since all the duplicates will usually 
merge perfectly), but it will look like two different histories, and 
you'll see every commit twice. That's just ugly.

On the other hand, things like the -mm tree are "throw-away" anyway: 
Andrew re-creates the tree every time he pulls. So you can rebase the 
branch you send to Andrew as much as you want. So it's not _entirely_ 
about whether something is "published" or not, it's literally more about 
how something is actively _used_.

But yes - in general, the rule of thumb should be: rebase as much as you 
want in your own _private_ sandbox to make things look nice, but once 
you've exposed it to anybody else, it's set in stone.

> Big thanks for all the pointers. I have my account at kernel.org, so it
> won't be long until my first [GIT PULL]. Be gentle.

Now, I may not be "gentle", because if there is something wrong with the 
end result I'll tell you so and I'm not exactly known for always being 
excessively polite ;)

But don't worry, it can be fixed up. At worst, you'll just get an email 
back saying "I'm not going to pull this one, because you've been a 
complete clutz, and did something really stupid wrt XYZ", and I'll ask you 
to fix it up. Or I might say "I'll pull it this time, but I don't want to 
see XYZ again in the future".

Or I might not say anythign at all, and you'll just notice that I've 
pulled from you.

			Linus
