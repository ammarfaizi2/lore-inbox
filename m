Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264909AbTGGLXg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 07:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264912AbTGGLXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 07:23:36 -0400
Received: from dp.samba.org ([66.70.73.150]:27355 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264909AbTGGLXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 07:23:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16137.22943.460130.914035@nanango.paulus.ozlabs.org>
Date: Mon, 7 Jul 2003 21:29:35 +1000 (EST)
From: Paul Mackerras <paulus@samba.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: benh@kernel.crashing.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH 2.5.73] Signal stack fixes #1 introduce PF_SS_ACTIVE
In-Reply-To: <20030706101754.GA23341@wohnheim.fh-wedel.de>
References: <20030703202410.GA32008@wohnheim.fh-wedel.de>
	<20030704174339.GB22152@wohnheim.fh-wedel.de>
	<20030704174558.GC22152@wohnheim.fh-wedel.de>
	<20030704175439.GE22152@wohnheim.fh-wedel.de>
	<16134.2877.577780.35071@cargo.ozlabs.ibm.com>
	<20030705073946.GD32363@wohnheim.fh-wedel.de>
	<16135.57910.936187.611245@cargo.ozlabs.ibm.com>
	<20030706101754.GA23341@wohnheim.fh-wedel.de>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=?iso-8859-1?Q?J=81=F6rn?= Engel writes:

> In the course of the investigation, I found another spot, where we
> didn't get a core dump, which started this whole thread.  Guess what,
> people aren't happy either.  One workaround would be to never use the
> signal stack, but if this can be fixed properly, I would see more
> happy faces at work.  And I like happy faces.

Well, the most reliable way to get a core dump when you trash the
stack or something is to have no SIGSEGV handler at all. :)

In any case, there are all sorts of things that could go wrong and
leave the process stuck in an infinite loop.  If you really want a
core dump when things go wrong then you probably need some sort of
watchdog process plus a way for one process to force another to dump
core and exit (like a SIGKILL but with a core dump as well).

> There is an open source web server that, combined with a closed source
> library, fscks up your stack pointer.  I don't know how they did it

On PPC?  Sounds like you are overrunning an array on the stack and
clearing the stack backchain word.

> and I don't even care.  What I do care about is that it happened, that
> it can happen again any time, and that we handle this problem as
> gracefully as possible.  A core dump is graceful, a do_exit(SIGSEGV),
> as it was in the ppc code is not, and an inifite loop is anything but
> graceful.
> 
> I agree that my initial patch can cause other problems, but the
> problem itself should still get fixed.

You haven't convinced me that the kernel is doing anything wrong or
even suboptimal - it seems to me that you have run into some
unintended consequences of your code, that's all.  You can't expect
the kernel to work around all the bugs in your user processes. :)

Paul.
