Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbVHLQv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVHLQv5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 12:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbVHLQv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 12:51:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13268 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750700AbVHLQv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 12:51:57 -0400
Date: Fri, 12 Aug 2005 09:51:48 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Helge Hafting <helge.hafting@aitel.hist.no>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Airlie <airlied@gmail.com>, akpm@osdl.org
Subject: Re: rc6 keeps hanging and blanking displays where rc4-mm1 works
 fine.
In-Reply-To: <42FC7372.7040607@aitel.hist.no>
Message-ID: <Pine.LNX.4.58.0508120937140.3295@g5.osdl.org>
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org> 
 <20050805104025.GA14688@aitel.hist.no> <21d7e99705080503515e3045d5@mail.gmail.com>
 <42F89F79.1060103@aitel.hist.no> <42FC7372.7040607@aitel.hist.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Aug 2005, Helge Hafting wrote:
>
> > at the moment. The setup is fine with 2.6.13-rc4-mm1 x86-64, no 
> > problems there.
> 
> The problem still exists in 2.6.13-rc6.  Usually, all I get is a 
> suddenly black display, solveable by resizing.

Is there any chance you could try bisecting the problem? Either just 
binary-searching the patches or by using the git bisect helper scripts?

Obviously the git approach needs a "good" kernel in git, but if 
2.6.13-rc4-mm1 is ok, then I assume that 2.6.13-rc4 is ok too? That's a 
fair number of changes:

	 git-rev-list v2.6.13-rc4..v2.6.13-rc6 | wc
	    340     340   13940

but if you can tighten it up a bit (you already had trouble at rc5, I 
think), it shouldn't require testing more than a few kernels.

Git has had bisection support for a while, but the helper scripts to use 
it sanely are fairly new, so I think you'd need the git-0.99.4 release for 
those. But then you'd just do

	git bisect start
	git bisect bad v2.6.13-rc5
	git bisect good v2.6.13-rc4

and start bisecting (that will check out a mid-way point automatically, 
you build it, and then do "git bisect bad" or "git bisect good" depending 
on whether the result is bad or good - it will continue to try to find 
half-way points until it has found the point that turns from good to 
bad..)

		Linus
