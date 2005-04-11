Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbVDKGNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVDKGNg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 02:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVDKGNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 02:13:35 -0400
Received: from fire.osdl.org ([65.172.181.4]:37303 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261701AbVDKGNd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 02:13:33 -0400
Date: Sun, 10 Apr 2005 23:15:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: New SCM and commit list
In-Reply-To: <425A10EA.7030607@pobox.com>
Message-ID: <Pine.LNX.4.58.0504102304050.1267@ppc970.osdl.org>
References: <1113174621.9517.509.camel@gaston> <Pine.LNX.4.58.0504101621200.1267@ppc970.osdl.org>
 <425A10EA.7030607@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Apr 2005, Jeff Garzik wrote:
> 
> > But I hope that I can get non-conflicting merges done fairly soon, and 
> > maybe I can con James or Jeff or somebody to try out GIT then...
> 
> I don't mind being a guinea pig as long as someone else does the hard 
> work of finding a new way to merge :)

So I can tell you what merges are going to be like, just to prepare you.

First, the good news: I think we can make the workflow look like bk, ie
pretty much like "git pull" and "git push".  And for well-behaved stuff
(ie minimal changes to the same files on both sides) it will even be fast.  
I think.

Then the bad news: the merge algorithm is going to suck. It's going to be
just plain 3-way merge, the same RCS/CVS thing you've seen before. With no
understanding of renames etc. I'll try to find the best parent to base the
merge off of, although early testers may have to tell the piece of crud
what the most recent common parent was.

So anything that got modified in just one tree obviously merges to that 
version. Any file that got modified in two trees will end up just being 
passed to the "merge" program. See "man merge" and "man diff3". The merger 
gets to fix up any conflicts by hand.

Quite frankly, that means that we really want to avoid any "exciting" 
merges with GIT. Maybe somebody can come up with something smarter. 
Eventually. Don't count on it, at least not in the near future.

The good news is that it's not like a three-way file merge is any worse
than many people are used to. The bad news is that BK is just a hell of a
lot better. So anybody who has been depending heavily on BK merges (and
hey, the beauty of them is that you often don't even _know_ that you are
depending on them) will be a bit bummed by the "Welcome back to the
1980's" message from a three-way merge.

		Linus
