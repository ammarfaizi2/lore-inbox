Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbTGFKEO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 06:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTGFKEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 06:04:14 -0400
Received: from [213.39.233.138] ([213.39.233.138]:51354 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261741AbTGFKEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 06:04:12 -0400
Date: Sun, 6 Jul 2003 12:17:54 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Paul Mackerras <paulus@samba.org>
Cc: benh@kernel.crashing.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH 2.5.73] Signal stack fixes #1 introduce PF_SS_ACTIVE
Message-ID: <20030706101754.GA23341@wohnheim.fh-wedel.de>
References: <20030703202410.GA32008@wohnheim.fh-wedel.de> <20030704174339.GB22152@wohnheim.fh-wedel.de> <20030704174558.GC22152@wohnheim.fh-wedel.de> <20030704175439.GE22152@wohnheim.fh-wedel.de> <16134.2877.577780.35071@cargo.ozlabs.ibm.com> <20030705073946.GD32363@wohnheim.fh-wedel.de> <16135.57910.936187.611245@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16135.57910.936187.611245@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 July 2003 18:47:50 +1000, Paul Mackerras wrote:
> 
> You can get the same effect by doing kill(0, SIGINT) inside a handler
> for SIGINT.  All you seem to be saying is "if you behave stupidly then
> bad things happen to you".  I don't see that this example exposes any
> bug or vulnerability in the kernel.

Maybe we are just working under different assumptions, so let me
explain my background a little.

Two of the reasons, why open source works well, are frequent releases
and lots of feedback.  In the embedded world, a typical number of
releases is one and a typical amount of feedback is none.  So you
either create a perfect product or you arrange for feedback yourself.

Without any user interaction tools around, the best feedback you can
get is a core dump plus maybe some information from /proc.  Remember
the borken patch for ppc I sent to you?  We didn't get a core dump and
people were quite unhappy, so the investigation began.

In the course of the investigation, I found another spot, where we
didn't get a core dump, which started this whole thread.  Guess what,
people aren't happy either.  One workaround would be to never use the
signal stack, but if this can be fixed properly, I would see more
happy faces at work.  And I like happy faces.

> You had to go to some trouble to get this effect - you had to use an
> asm statement to change the stack pointer, which is well and truly
> into "undefined behaviour" territory, and so you deserve all you
> get. :)  It's a very contrived example IMHO.

There is an open source web server that, combined with a closed source
library, fscks up your stack pointer.  I don't know how they did it
and I don't even care.  What I do care about is that it happened, that
it can happen again any time, and that we handle this problem as
gracefully as possible.  A core dump is graceful, a do_exit(SIGSEGV),
as it was in the ppc code is not, and an inifite loop is anything but
graceful.

I agree that my initial patch can cause other problems, but the
problem itself should still get fixed.

Jörn

-- 
More computing sins are committed in the name of efficiency (without
necessarily achieving it) than for any other single reason - including
blind stupidity.
-- W. A. Wulf 
