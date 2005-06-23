Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262033AbVFWDG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbVFWDG1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 23:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbVFWDG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 23:06:26 -0400
Received: from mail.dvmed.net ([216.237.124.58]:46513 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262026AbVFWDGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 23:06:12 -0400
Message-ID: <42BA271F.6080505@pobox.com>
Date: Wed, 22 Jun 2005 23:06:07 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Greg KH <greg@kroah.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Updated git HOWTO for kernel hackers
References: <42B9E536.60704@pobox.com> <20050622230905.GA7873@kroah.com> <Pine.LNX.4.58.0506221623210.11175@ppc970.osdl.org> <42B9FCAE.1000607@pobox.com> <Pine.LNX.4.58.0506221724140.11175@ppc970.osdl.org> <42BA14B8.2020609@pobox.com> <Pine.LNX.4.58.0506221853280.11175@ppc970.osdl.org> <42BA1B68.9040505@pobox.com> <Pine.LNX.4.58.0506221929430.11175@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506221929430.11175@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> What I'm saying is that for a tagged release, that really translates to
> "please pull tag xyz from repo abc" and the tools like git-ssh-pull will 
> just do the right thing: they'll pull the tag itself _and_ they'll pull 
> the objects it points to.

Yes, everything does the right there here.


> Of course, right now "git fetch" is hardcoded to always write FETCH_HEAD 
> (not the tag name), but I'm saying ythat _literally_ you can do this 
> already:
> 
> 	git fetch repo-name tags/xyz &&
> 		( cat .git/FETCH_HEAD > .git/tags/xyz )
> 
> and it should do exactly what you want. Hmm?

No, not at all.  This sub-thread is all about tags/ dir updates.  Users 
should be able to do

	git pull-more rsync://...

and get ALL of .git/refs/tags/* that have appeared since their last update.

Concrete example:  I have a git tree on local disk.  I need to find out 
where, between 2.6.12-rc1 and 2.6.12, a driver broke.  This requires 
that I have -ALL- linux-2.6.git/refs/tags on disk already, so that I can 
bounce quickly and easily between tags.

It is valuable to have a local copy of -all- tags, -before- you need 
them.  That is why people like me and GregKH use rsync directly.  We 
want EVERYTHING in the kernel.org linux-2.6.git tree, not just what we 
know we need right now.

	Jeff


