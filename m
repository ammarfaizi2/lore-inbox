Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbVDJTN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVDJTN4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 15:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbVDJTNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 15:13:55 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:46600 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261583AbVDJTN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 15:13:29 -0400
Date: Sun, 10 Apr 2005 21:13:19 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Petr Baudis <pasky@ucw.cz>
Cc: Ingo Molnar <mingo@elte.hu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
Subject: Re: Re: [ANNOUNCE] git-pasky-0.1
Message-ID: <20050410191319.GE7858@alpha.home.local>
References: <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050410024157.GE3451@pasky.ji.cz> <20050410162723.GC26537@pasky.ji.cz> <20050410173349.GA17549@elte.hu> <20050410174221.GD7858@alpha.home.local> <20050410174512.GA18768@elte.hu> <20050410184522.GA5902@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050410184522.GA5902@pasky.ji.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2005 at 08:45:22PM +0200, Petr Baudis wrote:
 
> It turns out to be the forks for doing all the cuts and such what is
> bogging it down so awfully (doing diff-tree takes 0.48s ;-). I do about
> 15 forks per change, I guess, and for some reason cut takes a long of
> time on its own.
> 
> I've rewritten the cuts with the use of bash arrays and other smart
> stuff. I somehow don't feel comfortable using this and prefer the
> old-fashioned ways, but it would be plain unusable without this.

I've encountered the same problem in a config-generation script a while
ago. Fortunately, bash provides enough ways to remove most of the forks,
but the result is less portable.

I've downloaded your code, but it does not compile here because of the
tv_nsec fields in struct stat (2.4, glibc 2.2), so I cannot use it to
get the most up to date version to take a look at the script. Basically,
all the 'cut' and 'sed' can be removed, as well as the 'dirname'. You
can also call mkdir only if the dirs don't exist. I really think you
should end up with only one fork in the loop to call 'diff'.

> Now I'm down to
> 
> 	real    1m21.440s
> 	user    0m32.374s
> 	sys     0m42.200s
> 
> and I kinda doubt if it is possible to cut this much down. Almost no
> disk activity, I have almost everything cached by now, apparently.

It is very common to cut times by a factor of 10 or more when replacing
common unix tools by pure shell. Dynamic library initialization also
takes a lot of time nowadays, and probably you have localisation which
is big too. Sometimes, just wiping a few variables at the top of the
shell might remove some useless overhead.

> Anyway, you can git pull to get the optimized version.
> 
> Thanks for the help,

Willy

