Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbTI1TRT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 15:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbTI1TRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 15:17:19 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:16307 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262691AbTI1TRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 15:17:17 -0400
Date: Sun, 28 Sep 2003 21:16:22 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@osdl.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Bernardo Innocenti <bernie@develer.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Linux 2.6.0-test6
Message-ID: <20030928191622.GA16921@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.44.0309281213240.4929-100000@callisto> <Pine.LNX.4.44.0309281035370.6307-100000@home.osdl.org> <20030928184642.GA1681@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030928184642.GA1681@mars.ravnborg.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 September 2003 20:46:42 +0200, Sam Ravnborg wrote:
> On Sun, Sep 28, 2003 at 10:37:36AM -0700, Linus Torvalds wrote:
> > 
> > This, btw, is a pretty common thing. I wonder what we could do to make 
> > sure that different architectures wouldn't have so different include file 
> > structures. It's happened _way_ too often.
> > 
> > Any ideas?
> 
> Without too much thinking....
> Would it help to require all major[1] header files to include all the
> header files needed for them to compile?
> We could make that part of the build process or we could make that an
> optional step.
> 
> Obviously that would not solve any issues in asm-$(ARCH).
> 
> [1] There are ~600 files in include/linux - we could pick up the
> 50 most important and checkcompile them.

How about a check_headers target that roughly works like this:

for (all header files in include/linux and include/asm) {
	echo "#include <$HEADER>" > header.c
	make header.o
	rm header.c header.o
}

Did a quick test for linux/fs.h in -test5 and it compiled fine, but
broke after removing some random #include.

Another thing, Sam, "make header.o" causes make to call itself
indefinitely.  Had to "make somedir/header.o".  Not sure if you
consider this to be a bug, your decision.

Jörn

-- 
Fools ignore complexity.  Pragmatists suffer it.
Some can avoid it.  Geniuses remove it.
-- Perlis's Programming Proverb #58, SIGPLAN Notices, Sept.  1982
