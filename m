Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262172AbVFRSKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbVFRSKc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 14:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbVFRSIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 14:08:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43669 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262164AbVFRRt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 13:49:59 -0400
Date: Sat, 18 Jun 2005 10:51:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, Netdev List <netdev@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] 2.6.x net driver updates
In-Reply-To: <42B456E2.8000500@pobox.com>
Message-ID: <Pine.LNX.4.58.0506181047190.2268@ppc970.osdl.org>
References: <42B456E2.8000500@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Jun 2005, Jeff Garzik wrote:
> 
> GIT NOTE 1:  The top-of-tree cset is the result of my use of the new git 
> conflict merging code.  It seemed to work quite nicely.  I did:
> 
> 	git-pull-script $vanilla_linus_repo	# conflicts appeared
> 	vi drivers/net/r8169.c			# fix conflict
> 	git-update-cache drivers/net/r8169.c
> 	git-commit-tree ...

The last step can be just "git commit", and it will do the right thing
these days (and with a nice big warnign that it looks like you're
committing a merge).

In fact, it's much preferable that you use "git commit", because it will
also then remove the old MERGE_HEAD if the commit was successful, leaving
the state proper (so that subsequent "git commit" things don't think it's
a merge). It also makes it less likely that you forget your parents.
Maybe.

> GIT NOTE 2: After doing a lot of simple+automatic merging, over time, I 
> have a lot of .merge_* files.  Would be nice is git-resolve-script, or 
> whomever, would clean up after itself.

Yeah, something as simple as

	rm -f .merge_file_*

in git-resolve-script should fix it..

		Linus
