Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262462AbVFVBQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbVFVBQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 21:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbVFVBQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 21:16:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64745 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262465AbVFVBQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 21:16:11 -0400
Date: Tue, 21 Jun 2005 18:18:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: git-pull-script on my linus tree fails..
In-Reply-To: <42B8B4C8.70704@pobox.com>
Message-ID: <Pine.LNX.4.58.0506211810170.2353@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506211304320.2915@skynet>
 <Pine.LNX.4.58.0506210837020.2268@ppc970.osdl.org> <42B838BC.8090601@pobox.com>
 <Pine.LNX.4.58.0506210905560.2268@ppc970.osdl.org> <42B84E20.7010100@pobox.com>
 <Pine.LNX.4.58.0506211039350.2268@ppc970.osdl.org> <42B8542A.9020700@pobox.com>
 <Pine.LNX.4.58.0506211103370.2268@ppc970.osdl.org> <42B859B4.5060209@pobox.com>
 <Pine.LNX.4.58.0506211124310.2268@ppc970.osdl.org> <42B8A82E.4020207@pobox.com>
 <42B8A8CA.9040804@pobox.com> <Pine.LNX.4.58.0506211709220.2353@ppc970.osdl.org>
 <42B8B4C8.70704@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Jun 2005, Jeff Garzik wrote:
> 
> git-checkout-script is now switching branches correctly :)

Goodie.

> Now stay tuned for my next email, where I demonstrate how to reproduce 
> git-prune-script eating data :)

Before you demonstrate that, let me give you a quick warning on a very 
useful but also very peculiar and perhaps baffling feature of my version 
of "git checkout" as opposed to your "git switch".

In particular, think about what happens when you have changes in your
working directory, and you use "git checkout <newbranch>" (that is,
without the "-f" flag).

Now, if those changes actually _clash_ with the difference in the branch
you're switching to, you'll get an error (something like "Entry 'filename'
not uptodate. Cannot merge."). But if you have only edited files that are
the _same_ in both branches, then when you switch branches, those edits
will literally _follow_ you into the new branch.

Before, with your "git switch" script, any pending dirty state just got
thrown away.

Now, I'm convinced this is actually exactly the behaviour you want, but I 
thought I'd mention it before you notice it on your own and get confused.

And hey, if you don't like the feature, you can always just use the "-f"  
flag, which will act the way your old script did, and always just throw
any pending changes away when you check out a new branch.

			Linus
