Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751611AbWIXVvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbWIXVvL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 17:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751615AbWIXVvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 17:51:11 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:15507 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S1751611AbWIXVvK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:51:10 -0400
Date: Sun, 24 Sep 2006 23:56:25 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, rolandd@cisco.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] missing includes from infiniband merge
Message-ID: <20060924215625.GA27605@uranus.ravnborg.org>
References: <20060923154416.GH29920@ftp.linux.org.uk> <20060923202912.GA22293@uranus.ravnborg.org> <20060923203605.GN29920@ftp.linux.org.uk> <20060924064446.GA13320@uranus.ravnborg.org> <20060924191917.GQ29920@ftp.linux.org.uk> <20060924205244.GA26774@uranus.ravnborg.org> <20060924213508.GR29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060924213508.GR29920@ftp.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Or we could stick to current mess where one has
> > to have a shitload of crosscompiles and CPU power to check even trivial
> > changes to a few include files.
> 
> We _are_ stuck with it.
For old stuff - to a high degree yes.

> > Partly this could be fixed by making header files in asm-$(ARCH)
> > second class citizen - that always got included via their linux/
> > counterpart.
> 
> Which only makes dependency graph fatter...  What's the difference
> between including asm/uaccess.h and linux/uaccess.h?
It makes it fatter on the horizontal level - yes.
But then files do not rely on files being included by asm-* files
anymore - so less difference between architecutes.

> Basically, you pull tons of includes into linux/blah.h because it
> happens to include asm/foo.h and _that_ depends on having linux/barf.h
> for $WEIRD_TARGET.
That would be wrong. Any file in asm-* that needs a file from linux/
should pull that include to the linux/ counterpart and in this way
we are on track again.

It boils down to something simple as:
Do we want to keep arch independence lower on the price of higher number
includes in asm- counter part files in linux/?


> And guess what?  You are back to the same cross-compiles,
> since attempt to remove blah.h -> barf.h will break $WEIRD_TARGET, but
> you won't notice that unless you cross-compile for it.
No.
There is a huge difference modifying architecture independent code like
infiniband or module.c and to try to clean up headers.
Cleaning up headers really really require that one cross compile
a lot no matter how files are organized.

> So all you get is a bunch of harder to explain includes between linux/*.h,
> _and_ extra dependencies that make no sense whatsoever.
They are easy to explain: They are there to keep arch independence lower -
and the cost is a number (tons?) of extra includes.

OK - this was a fun thread talking about arch specific includes.
But since I do not plan to follow-up with patches I will
drop of for now. bugzilla and others tell me I should concentrate
on other things.

	Sam
