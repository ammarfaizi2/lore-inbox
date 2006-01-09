Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbWAIDab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWAIDab (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 22:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWAIDab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 22:30:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42113 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751199AbWAIDaa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 22:30:30 -0500
Date: Sun, 8 Jan 2006 19:26:50 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: "Brown, Len" <len.brown@intel.com>,
       "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, git@vger.kernel.org
Subject: Re: git pull on Linux/ACPI release tree
In-Reply-To: <20060108230611.GP3774@stusta.de>
Message-ID: <Pine.LNX.4.64.0601081909250.3169@g5.osdl.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com>
 <Pine.LNX.4.64.0601081111190.3169@g5.osdl.org> <20060108230611.GP3774@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 9 Jan 2006, Adrian Bunk wrote:
> 
> Consider I want to do the following:
> 1. update my tree daily from your tree
> 2. include 10 patches per week into my tree
> 3. ask you once a month to pull from my tree
> 
> How should step 1 be done?

I'd do

	git fetch linus

to fetch my tree as a branch (obviously, this assumes you've set up a 
'.git/remotes/linus' file for the shorthand).

Then, keep your checked-out working-tree that you also do you development 
in your 'devel' branch (or whatever).

And then do

	git-rebase linus

to rebase your development branch to mine.

THIS is what "rebase" is for. It sounds like what you really want to do is 
not have a development branch at all, but you just want to track my tree 
and then keep track of a few branches of your own. In other words, you 
don't really have a "real" branch - you've got an odd collection of 
patches that you really want to carry around on top of _my_ branch. No?

Now, in this model, you're not really using git as a distributed system. 
In this model, you're using git to track somebody elses tree, and track a 
few patches on top of it, and then "git rebase" is a way to move the base 
that you're tracking your patches against forwards..

It's also entirely possible that you may want to look at "stacked git" 
(stg), which is really more about a "quilt on top of git" approach. Which 
again, may or may not suit your needs better.

Now, the other alternative is to use git as a "real" distributed system, 
and then you might keep my "linus" branch around perhaps as a reference 
point, but you don't care too much about it. What you care a lot more 
about is your "real development" branch, and you simply don't rebase that, 
or try to track my branch all that closely. You work in your real 
development branch, and that's your bread and butter. You _don't_ merge my 
tree every day, because you simply don't care - that's a separate issue.

You might have a totally different directory that you use _just_ to track 
my tree, and that is my virgin tree checked out and ready to go to test 
what _I_ am doing - totally independently of your tree.

See? Two totally different usage schenarios. In one, you keep a couple of 
"odd-ball" patches around (hey, it could be many, but I say a couple just 
because the patches aren't a huge deal - they are kind of a small side 
project to you, and not the main focus). And you use "git rebase" to move 
those patches forward to match the "real" tree, aka mine.

In the other schenario, your development tree is a full-fledged real 
branch, with a life of its own, and _not_ slaved to what happens to be 
going on in my tree. You may care about my tree for _other_ reasons, but 
the two aren't really joined at the hip.

The third schenario is somewhere in between: you do pull from my tree, but 
you do it occasionally enough that the merges don't get annoying.

Most people I work with are actually in that gray area. EVERYBODY pulls 
some. Nobody tends to do black-and-white either-or schenario. The question 
is just how much. 

My gut rule: if you have almost as many merges as you have "real work" 
commits, you're doing something bad, and you should pull less often 
(perhaps by using "rebase", perhaps by just realizing that you don't need 
to be tailgating _quite_ that closely).

But 30 "real" commits and 5 merges because the 30 real commits happened 
over four weeks time? Sounds fine to me. 

		Linus
