Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbVDKAK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVDKAK7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 20:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbVDKAK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 20:10:59 -0400
Received: from w241.dkm.cz ([62.24.88.241]:15585 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261640AbVDKAKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 20:10:47 -0400
Date: Mon, 11 Apr 2005 02:10:46 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Paul Jackson <pj@engr.sgi.com>
Cc: Linus Torvalds <torvalds@osdl.org>, junkio@cox.net, rddunlap@osdl.org,
       ross@jose.lug.udel.edu, linux-kernel@vger.kernel.org
Subject: Re: Re: more git updates..
Message-ID: <20050411001046.GF5902@pasky.ji.cz>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <7vhdifcbmo.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504100824470.1267@ppc970.osdl.org> <20050410115055.2a6c26e8.pj@engr.sgi.com> <Pine.LNX.4.58.0504101338360.1267@ppc970.osdl.org> <20050410161457.2a30099a.pj@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050410161457.2a30099a.pj@engr.sgi.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Mon, Apr 11, 2005 at 01:14:57AM CEST, I got a letter
where Paul Jackson <pj@engr.sgi.com> told me that...
> Useful explanation - thanks, Linus.
> 
> Is this picture and description accurate:
> 
> ==============================================================
> 
> 
>              < working directory files (foo.c) >
>                            ^
>   ^                        |
>   |  upward ops            |            downward ops  |
>   |  ----------            |            ------------  |
>   | checkout-cache         |            update-cache  |
>   | show-diff              |                          v
>                            v
>         < current directory cache (".dircache/index") >
>                            ^
>   ^                        |
>   |  upward ops            |            downward ops  |
>   |  ----------            |            ------------  |
>   |   read-tree            |             write-tree   |
>   |                        |            commit-tree   |
>                            |                          v
>                            v
> < git filesystem (blobs, trees, commits: .dircache/{HEAD,objects}) >

Well, except that from purely technical standpoint commit-tree has
nothing to do in this picture - it creates new object in the git
filesystem based on its input data, but regardless to the directory
cache or current tree. It probably still belongs where it is from the
workflow standpoint, though.

..snip..
> Minor question:
> 
>   I must have an old version - I got 'git-0.03', but
>   it doesn't have 'checkout-cache', and its 'read-tree'
>   directly writes my working files.
>  
>   How do I get a current version?  Well, one way I see,
>   and that's to pick up Pasky's:
>     
>     http://pasky.or.cz/~pasky/dev/git/git-pasky-base.tar.bz2
>  
>   Perhaps that's the best way?

You can take mine, and do:

	git pull pasky
	git pull linus
	cp .dircache/HEAD .dircache/HEAD.local

Now, your tree and git filesystem is up to date.

	git track local

Now, when you do git pull pasky, your working tree will not be updated
automatically anymore.

	git track linus

Now, you start tracking Linus' tree instead. Note that the initial
update will blow away the scripts in your current tree, so before you do
the last two steps you will probably want to clone the tree and set PATH
to the one still tracking me, so you get all the comfort. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.
