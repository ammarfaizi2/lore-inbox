Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263995AbUGAFjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263995AbUGAFjl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 01:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264034AbUGAFjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 01:39:41 -0400
Received: from mail3.speakeasy.net ([216.254.0.203]:28322 "EHLO
	mail3.speakeasy.net") by vger.kernel.org with ESMTP id S263995AbUGAFjj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 01:39:39 -0400
Date: Wed, 30 Jun 2004 22:39:34 -0700
Message-Id: <200407010539.i615dYke017137@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
X-Fcc: ~/Mail/linus
Cc: Andreas Schwab <schwab@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: zombie with CLONE_THREAD
In-Reply-To: Andrea Arcangeli's message of  Thursday, 1 July 2004 06:08:34 +0200 <20040701040834.GC15086@dualathlon.random>
Emacs: ed  ::  20-megaton hydrogen bomb : firecracker
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> this looks much less obvious than my fix. Instead of fixing
> TASK_DEAD like I did, you're actually working around the fact the child
> didn't go away when exit_notify was called on it. 

No, I am preserving the feature that the child doesn't go away in this case.
ptraced threads always become zombies and let the ptracer see their exit
notification and status value.  That is the way we want it to stay.

Linus makes the same point:
> To let the tracer look at the exit code?
> 
> How would you otherwise see what exit code the child exited with?

In fact, the exit code is usually completely uninteresting for a
CLONE_THREAD thread (after all, ptrace is the *only* way to see that value,
so the _exit call didn't expect to pass useful information that way).
However, the reliable notification of the fact that the thread died is very
useful for anything tracing/debugging it.


Thanks,
Roland

