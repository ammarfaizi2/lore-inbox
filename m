Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWCURSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWCURSl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 12:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWCURSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 12:18:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17336 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932321AbWCURSj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 12:18:39 -0500
Date: Tue, 21 Mar 2006 09:18:10 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: mchehab@infradead.org
cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com, akpm@osdl.org
Subject: Re: [PATCH 00/49] V4L/DVB updates part 2
In-Reply-To: <20060320192044.PS58609000000@infradead.org>
Message-ID: <Pine.LNX.4.64.0603210905480.3622@g5.osdl.org>
References: <20060320192044.PS58609000000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 20 Mar 2006, mchehab@infradead.org wrote:
>
> This patch series is available under v4l-dvb.git tree at:
>         kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git.

Mauro,
 because this tree contained a really ugly failed merge that was 
incorrectly done as a commit that was just a diff, I re-wrote the tree by 
re-doing the merge properly (as far as I can tell) and then cherry-picking 
the commits that followed it.

This means that what I just pushed out has the same _contents_ as your 
tree had, but because it has a fixed-up history, it's really a different 
tree.

I'm hoping that you can just discard your broken tree, and replace it with 
mine. So _instead_ of doing a "git pull" on my tree (which will succeed 
fine, but which will leave you with your old broken history _and_ the new 
fixed up one), you should just reset your state to mine.

If you have some additional commits on top of your broken history, you can 
cherry-pick them onto the fixed one. Ok?

I'd suggest you double-check that my result is sensible, but I was pretty 
careful. It should be all good (the end result matches your end result 
exactly), but also, the history should be identical apart from the merge 
mess being cleaned up.

(If it's not clear how to reset to my state, just do something like

    git fetch origin		# get my new updated tree
    git branch oldbranch	# save your old state in "oldbranch"
    git reset --hard origin	# switch your master branch over to "origin"

which will reset your state to mine, and leave your old state in the 
"oldbranch" branch - after that, you can look at both "oldbranch" and the 
current state, and perhaps move any commits on "oldbranch" over to the new 
state with "git cherry-pick <cmit-id>").

Holler if you have any issues..

(Oh: when next you push to master.kernel.org, you'll need to use the "-f" 
flag to _force_ the push, since your new tree will no longer be a superset 
of your old broken tree with the broken merge).

		Linus
