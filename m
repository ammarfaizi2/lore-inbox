Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161081AbWAHTKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161081AbWAHTKZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 14:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161086AbWAHTKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 14:10:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21656 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161081AbWAHTKX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 14:10:23 -0500
Date: Sun, 8 Jan 2006 11:10:20 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Brown, Len" <len.brown@intel.com>
cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       git@vger.kernel.org
Subject: RE: git pull on Linux/ACPI release tree
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005A13489@hdsmsx401.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.64.0601081100220.3169@g5.osdl.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13489@hdsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 8 Jan 2006, Brown, Len wrote:
> 
> Is it possible for it git, like bk, to simply ignore merge commits in its summary output?

That's not the point. It does: "git log --no-merges" does exactly that.

But fire up "gitk" to watch the history, and see the difference.

> Note that "Auto-update from upstream" is just the place-holder comment
> embedded in the wrapper script in git/Documentation/howto/using-topic-branches.txt

That has absolutely nothing to do with anything. It's not the comment 
(which admittedly gives absolutely no information - but why should it, 
since the _commit_ itself has no information in it?)

It's like you have empty commits that don't do anything at all, except 
that they are worse, because they have two parents.

> I think that Tony's howto above captures two key requirements
> from all kernel maintainers -- which the exception of you --

No. Your commits make it harder for _everybody_ to track the history. 

A merge by definition "couples" the history of two branches. That's what a 
merge very fundamentally is. It ties two things together. But two things 
that don't have any connection to each other _shouldn't_ be tied together.

Just as an example: because of the extra merges, you've made all your 
commits dependent on what happened in my tree, with no real reason. So 
let's say that somebody reports that something broke in ACPI. Now you 
can't just go to the top of the ACPI history and work backwards - you'll 
have tied up the two histories so that they are intertwined.

And yes, you can always work around it, but there's just no point. And 
none of the other developers seem to need to do it. They do their 
development, and then they say "please pull". At that point the two 
histories are tied together, but now they are tied together for a 
_reason_. It was an intentional synchronization point.

An "automated pull" by definition has no reason. If it works automated, 
then the merge has zero semantic meaning. 

			Linus
