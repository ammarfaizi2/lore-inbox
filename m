Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbWFVVBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbWFVVBT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 17:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbWFVVBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 17:01:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28308 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751088AbWFVVBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 17:01:17 -0400
Date: Thu, 22 Jun 2006 14:01:09 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       git@vger.kernel.org
Subject: Re: [GIT PATCH] USB patches for 2.6.17
In-Reply-To: <20060622200147.GA10712@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.64.0606221354070.6483@g5.osdl.org>
References: <20060621220656.GA10652@kroah.com> <Pine.LNX.4.64.0606211519550.5498@g5.osdl.org>
 <20060621225134.GA13618@kroah.com> <Pine.LNX.4.64.0606211814200.5498@g5.osdl.org>
 <20060622181826.GB22867@kroah.com> <20060622183021.GA5857@kroah.com>
 <Pine.LNX.4.64.0606221239100.5498@g5.osdl.org> <20060622200147.GA10712@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Jun 2006, Sam Ravnborg wrote:
> 
> Personally I'm still missing two things:
> 1) A command to let me see what this Linus guy have applied compared to
> my tree - without touching anything in my tree. bk changes -R

	git fetch linus
	git log ..linus

Yes, it will fetch the things into your database, unlike BK, but that's 
kind of the point. That's what makes branches so powerful (you can do a 
lot more than "bk changes -R").

> 2) A dry-run of a fetch+pull. I can do that if I really study the man
> pages I know. But "git pull --dry-run" would be more convinient.

Hmm? Again, do

	git fetch <thing-to-be-fetched>

into a local branch first. That gets it into your repo, so that you can do 
things.

After that, I'm not quite sure what you mean by "--dry-run". Do you mean 
to know about file-level conflicts? You do need to do the merge in order 
to know whether the conflicts can be resolved, but even without doing the 
merge you can look for _file_level_ conflicts by other means.

I don't think anybody has done it, but a script like

	OTHER="$1"
	BASE=$(git-merge-base HEAD $OTHER) || exit
	git-merge-tree $BASE HEAD $OTHER | grep -v '^0'

will show if there were file-level conflicts (in a pretty strange format, 
admittedly).

Of course, 99% of the time, a three-way merge will just handle those fine 
(the output from "git-merge-tree" is enough to know to do a three-way 
merge on temp-files, if you want to try that).

		Linus
