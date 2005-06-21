Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbVFUR2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbVFUR2Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 13:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbVFUR2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 13:28:16 -0400
Received: from mail.dvmed.net ([216.237.124.58]:19112 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262205AbVFUR2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 13:28:06 -0400
Message-ID: <42B84E20.7010100@pobox.com>
Date: Tue, 21 Jun 2005 13:28:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: git-pull-script on my linus tree fails..
References: <Pine.LNX.4.58.0506211304320.2915@skynet> <Pine.LNX.4.58.0506210837020.2268@ppc970.osdl.org> <42B838BC.8090601@pobox.com> <Pine.LNX.4.58.0506210905560.2268@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506210905560.2268@ppc970.osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> It's not quite your "switch", though, because it will always _write_ to
> the current HEAD, it won't be switching the current HEAD around to another
> branch. I almost think that behavkiour would be more useful, I'll think
> about how to do it sanely.

The reason I requested git-checkout-script is to make git-switch-tree 
pretty much trivial.  The new git-switch-tree will sit on top of 
git-checkout-script, like

	if $1
		switch HEAD to refs/heads/$1
	git-checkout-script

So, as created, git-checkout-script is a useful foundation for other 
scripts.

As of right now, I only have two[1] scripts that are non-vanilla:

git-switch-tree:	retarget .git/HEAD to refs/heads/$1
git-new-branch:		cp refs/heads/master refs/heads/$1

With git-checkout-script, both of these are now trivial and obvious.

	Jeff



[1] Actually I have a third, 'git-changes-script'.  The only reason I 
use this is that it supports the old BitKeeper syntax of

	cd my-repo-2.6
	git-changes-script -L ../linux-2.6

to obtain a list of changes that are _only_ present in my-repo-2.6, and 
not in ../linux-2.6 repo.  git-changes-script works with .git/HEAD at 
the repo level, and knows nothing of branches (which is fine).
