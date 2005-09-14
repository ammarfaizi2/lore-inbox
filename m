Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965223AbVINOwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965223AbVINOwn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 10:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965220AbVINOwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 10:52:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65195 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965223AbVINOwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 10:52:42 -0400
Date: Wed, 14 Sep 2005 07:52:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthew Wilcox <matthew@wil.cx>
cc: Grant Grundler <grundler@parisc-linux.org>, Ingo Molnar <mingo@elte.hu>,
       Alexey Dobriyan <adobriyan@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org, seb@highlab.com
Subject: Re: -git11 breaks parisc and sh even more
In-Reply-To: <20050914125014.GA16698@parisc-linux.org>
Message-ID: <Pine.LNX.4.58.0509140724180.26803@g5.osdl.org>
References: <20050913174754.GA13132@mipter.zuzino.mipt.ru>
 <20050913185759.GA17272@mars.ravnborg.org> <20050913203720.GA12868@mipter.zuzino.mipt.ru>
 <20050914074248.GA21436@colo.lackof.org> <20050914074309.GA14116@elte.hu>
 <20050914091722.GA27148@colo.lackof.org> <20050914125014.GA16698@parisc-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 14 Sep 2005, Matthew Wilcox wrote:
> 
> The parisc tree hasn't been merged with Linus in a long time because I
> find git completely impossible to use.  The howtos are all out of date
> and contradict each other.  They don't tell me what I need to know.
> Everybody who uses them has their own collection of private scripts that
> work around the worst misfeatures.  It's a complete fucking disaster.

Actually, that's not true. I was asking people what scripts they use the 
other day, and was surprised to learn that they don't use any at all.

And especially if you use git itself - _without_ any special scripts, the
git mailing list is actually active and quite helpful. I haven't seen you 
ask anything there.. Hint hint..

> The Debian cogito package doesn't have half the tools mentioned in the
> howtos, as well as being months out of date.  Last time I had the energy
> to fight with it, it didn't even support pack files.

Now _that_ is true. You can't depend on vendor packaging. They are _way_ 
too slow. For now, you absolutely have to do it yourself.

(Well, "absolutely have to" may not be true - you can find RPM's etc, but 
you might as well resign yourself to it for the next few months).

Just do this: 

 - get the last daily snapshot from 

	http://www.codemonkey.org.uk/projects/git-snapshots/git/

   (this is mentioned in the overview, btw, directly reachable from 
   www.kernel.org/git, so it's even well documented)

 - compile and install it: "make" + "make install"

 - just as an exercise (and because it's a lot smaller than the kernel 
   and thus downloads much faster), get the git.git tree:

	git clone rsync://rsync.kernel.org/pub/scm/git/git.git git-tree
	cd git-tree
	git checkout
	make
	make install

   and you've now gotten the most up-to-date git there is. The nice thing 
   about this is that going an update is now

	git pull origin

   so you can trivially keep track of it forever after.

 - now you're getting ready to get a _real_ project. This will take some 
   time.

	git clone \
		rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git \
		kernel-tree
	cd kernel-tree
	git checkout

   and you have the kernel sources. On my 1.5Mbps DSL line, it takes about
   ten minutes, because you're downloading about 80MB of stuff (and 
   the checkout unpacks 17,000 files and takes 5 seconds for me, but a 
   _lot_ more if you don't have tons of memory to cache the thing).  But
   it's not horrible.

 - play around.

And git really isn't that hard to use any more. If you tried it two months 
ago, it was a _lot_ more complicated. These days, if you can work with 
CVS, it's a hell of a lot more pleasant than that ;)

(It doesn't have a really nice graphical merge tool like BK did, for 
example: you end up having to resolve merge clashes the CVS way by 
searching for "<<<<<"/"======"/">>>>>>" markers.. The good news is that 
it gets merge clashes pretty infrequently - I get them maybe once a week, 
and I merge a _lot_)

		Linus
