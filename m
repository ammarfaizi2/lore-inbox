Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262203AbVFRUV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbVFRUV5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 16:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbVFRUV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 16:21:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52654 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262203AbVFRUVp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 16:21:45 -0400
Date: Sat, 18 Jun 2005 13:23:47 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, Netdev List <netdev@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] 2.6.x net driver updates
In-Reply-To: <42B47E68.9020601@pobox.com>
Message-ID: <Pine.LNX.4.58.0506181318240.2268@ppc970.osdl.org>
References: <42B456E2.8000500@pobox.com> <Pine.LNX.4.58.0506181047190.2268@ppc970.osdl.org>
 <Pine.LNX.4.58.0506181105110.2268@ppc970.osdl.org>
 <Pine.LNX.4.58.0506181112590.2268@ppc970.osdl.org> <42B469B6.2060502@pobox.com>
 <Pine.LNX.4.58.0506181146260.2268@ppc970.osdl.org> <42B47E68.9020601@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Jun 2005, Jeff Garzik wrote:
> 
> I re-did the merge locally, as a test, finalizing with 'git commit' 
> rather than 'git-commit-tree ...' and the parent info came out correct. 
>   FWIW.

Well, you can certainly do it by hand with git-commit-tree too, you just 
need to make sure that you give all the relevant parents, ie something 
like

	git-commit-tree $(git-write-tree) -p HEAD -p MERGE_HEAD

will do the right thing too (and is what "git commit" ends up doing in the 
end, of course).

In fact, the "git commit" script will _only_ handle the merge case of
having done a single "git pull", and if you do anything more complex that
has more than two parents, you'll have to go back to scripting the use of
git-commit-tree by hand.

I've considered trying to automate this a bit more: right now it really 
does depend on people and scripts always getting the parents right, but at 
least in theory I could embed the parent information in the "index" file 
at least as an additional safety-measure.

However, I'm not entirely sure that is a good idea: the current approach
is _extremely_ flexible, exactly because it allows you to do anything you
want with parents. That flexibility can be nice, but it's obviously also
what makes it a bit dangerous.

So the git approach is "give them rope", with a few scripts that handle 
the normal cases right. That's the unix way, after all..

		Linus
