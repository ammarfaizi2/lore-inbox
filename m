Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262759AbTI1Vnc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 17:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbTI1Vnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 17:43:32 -0400
Received: from [139.30.44.2] ([139.30.44.2]:18896 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S262759AbTI1Vn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 17:43:29 -0400
Date: Sun, 28 Sep 2003 23:43:08 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Linus Torvalds <torvalds@osdl.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Bernardo Innocenti <bernie@develer.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>, Russell King <rmk@arm.linux.org.uk>
Subject: Re: Linux 2.6.0-test6
In-Reply-To: <20030928200001.GC16921@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.33.0309282337190.16567-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, how about this:
>
> for each header file {
> 	make header.o
> 1)	if it doesn't build {
> 		print out a warning
> 		continue
> 	}
> 	for each #include line {
> 		remove the #include line
> 		make header.o
> 2)		if it build {
> 			print out a warning
> 		}
> 3)		if there are less than x gcc warnings {
> 			print out a warning
> 		}
> 	}
> }
>
> 1) is my old proposal.  2) is the natural counterpart.  3) could be
> what you want.  If some header is only needed for something like your
> example, we may be able to catch it this way.
>
> Would this work?  Would something else work even better?


Problem is, this depends too much on the specific configuration, and thus
will never be a general solution (will generate false positives and false
negatives). Might be a good start, though.

Tim


P.S.: My secret plan is to write a parser or hack sparse to do this for
both #if and #else branches of conditionals at the same time. This
however, is a big project, and I don't think of even _starting_ this
before next year.

