Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWAIIGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWAIIGg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 03:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWAIIGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 03:06:34 -0500
Received: from fmr16.intel.com ([192.55.52.70]:34755 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750785AbWAIIGd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 03:06:33 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: git pull on Linux/ACPI release tree
Date: Mon, 9 Jan 2006 03:05:42 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005A13706@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git pull on Linux/ACPI release tree
Thread-Index: AcYUlU8U4++Y/gi9TgibeXWowVevfwAVRR9Q
From: "Brown, Len" <len.brown@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>, "Linus Torvalds" <torvalds@osdl.org>
Cc: "Junio C Hamano" <junkio@cox.net>,
       "Martin Langhoff" <martin.langhoff@gmail.com>,
       "David S. Miller" <davem@davemloft.net>, <linux-acpi@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <akpm@osdl.org>, <git@vger.kernel.org>
X-OriginalArrivalTime: 09 Jan 2006 08:05:45.0674 (UTC) FILETIME=[7E642AA0:01C614F3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,
I think Tony has articulated the work-flow problem that
originally started this thread, as well as the fix.

>I'll try to update the using-topic-branches document to capture this.
>Some of the problem is that it doesn't quite capture what I'm doing
>with my test/release branches.
>
>My release branch really is just used as a transfer point to Linus.
>I usually[1] don't leave patches sitting in "release" for long enough
>that I'll be tempted to merge in from Linus ... once I decide that
>some patches are ready to go to Linus I'll update "release" from Linus
>(which will be a fast-forward, so no history) merge in the topic
>branches, do one final sanity build, push to kernel.org and send
>the "please pull" e-mail.
>
>The huge majority of my "automatic update from upstream" merges
>go into my test branch ... which never becomes part of the real
>history as I never ask Linus to pull from it.
>
>-Tony
>
>[1] Sometimes I goof on this because I forget that I've applied
>a trivial patch directly to the release branch without going through
>a topic branch.  I think I'll fix my update script to check 
>for this case.

I figured that checking some trivial patches directly into "release"
would be a convenient way to make sure I didn't forget to push them --
as they didn't depend on anything else in my tree.  Okay.

To make sure that my test branch (where I generate my consolidated
plain patch, and what Andrew pulls) includes everything, I then pull
"release" into "test".  Still good.

But then I decide I need to update my test tree from upstream.
I did this by pulling "linus" into "release", and then pulling
"release" into "test".  This creates the book-keeping merge
in "release" that irritates gitk users.

This "flow", BTW, is a habit I picked up from the
"two-phase release strategy" that we used in bk days.
There I'd pull from upstream down into my to-linus tree and then pull
from the to-linus tree into the to-andrew tree.
I expect BK also created a merge cset, but apparently
nobody was looking at the history like they do with gitk today.

So if I simply don't pull from "linus" into a modified
"release" branch then the cluttered history issue goes away.
I should fetch "linus" into "release" right before I merge
the topic branches into "release" and push upstream.
The fetch is a clean fast-forward, and the merges all have
real content.

This will work as long as "release" doesn't get too old
to be pulled upstream without conflicts.  Based on past
experience with low latency pulls upstream, I think this will be rare.

Andrew will still get cluttered history in the test tree,
but as he's focused on the content and not the (throw-away) history,
this is surely a non-issue.

So problem #1 is solved, yes?

Going forward...
I'm hopeful that gitk users will not be irritated also
by the liberal use of topic branches.  I'm starting to like using
them quite a bit.  Yes, it is true that I could cherry-pick
the topics out of their original context to re-manufacture linear
history.  But that is extra work.  Also, as you poined out,
there is real value in the real history because the context is accurate.
Further, I find that sometimes I need to augment a topic branch
with a follow-up patch.  I can checkout the topic branch an plop
the follow-up right on the tip where it logically should live,
and (Tony's) scripts will remind me when the branch is not fully
pulled into test or release -- so it will never get misplaced.

In the case where a topic branch is a single commit, gitk users
will see both the original commit, as well as the merge commit
back into "release".

-Len
