Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVDZES2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVDZES2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 00:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbVDZES2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 00:18:28 -0400
Received: from fire.osdl.org ([65.172.181.4]:20158 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261304AbVDZESQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 00:18:16 -0400
Date: Mon, 25 Apr 2005 21:20:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Matt Mackall <mpm@selenic.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: Mercurial 0.3 vs git benchmarks
In-Reply-To: <20050426040127.GK21897@waste.org>
Message-ID: <Pine.LNX.4.58.0504252113210.18901@ppc970.osdl.org>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org>
 <20050426040127.GK21897@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Apr 2005, Matt Mackall wrote:
> 
> And the number of files checked in grows from ~1000 to ~6000. Note
> that git is growing from 4 to 19 seconds as well.

Heh,. I didn't much look at the git numbers, since I knew those were 
supposed to be linear in the size of the patch...

> I'm not versant enough with git enough to know how but I'll give it a
> shot. Do you have the patches in an mbox, perchance? This is Andrew's
> x/198 patch bomb?

Yes. I have my "tools" scripts for git in

	kernel.org:/pub/linux/kernel/people/torvalds/git-tools.git

and I sent out the script I used to test the 2.6.12-rc2 + patches stuff in 
the previous email, so you would just have to edit my mbox-applicator 
tools to work with hg and get comparable numbers.

> It might be simpler for me to just apply everything
> in -mm to git and hg and compare times.

That should work.

> > You're doing something wrong with git here. Why would you need to update 
> > your cache?
> 
> Quite possibly. Without it, I was getting a dump of a bunch of SHAs.
> I'm pretty git-ignorant, I've been focusing on something else for the
> past couple weeks.

Getting a bunch of SHA's means that the file contents match, but that your 
index file wasn't up-to-date, so git had to actually uncompress the object 
backing store and _compare_ the file contents to notice.

And I suspect that you may have done _all_ your numbers without ever
having initialized the git index, in which case git will really suck raw
eggs, because git will basically always re-read every file (it will never
realize that they are up-to-date already).

Basically, the theory of git operation is that the index file should
_always_ be up-to-date.  Normally you don't have to do anything about it,
since the git helper tools will always just keep it that way, but if you
didn't, then..

		Linus
