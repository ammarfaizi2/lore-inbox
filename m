Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265992AbUFJCwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265992AbUFJCwK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 22:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265998AbUFJCwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 22:52:10 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:51435 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S265992AbUFJCwH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 22:52:07 -0400
Subject: Re: [PATCH] Fix signal race during process exit
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roland McGrath <roland@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeremy Kerr <jk@ozlabs.org>
In-Reply-To: <200406100148.i5A1mwHl009763@magilla.sf.frob.com>
References: <200406100148.i5A1mwHl009763@magilla.sf.frob.com>
Content-Type: text/plain
Message-Id: <1086835873.27404.362.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 10 Jun 2004 12:51:13 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-10 at 11:48, Roland McGrath wrote:
> The concern I had is basically that this might not be true of all cases.
> The only problem case that has come up is the current task's own interrupt
> handlers calling signal code while interrupting release_task.  I know for
> the case of posix-timers it's not an issue because their cleanup is handled
> with special synchronization in __exit_signal.  What I'm not sure about is
> all other sources of asynchronous signals that use task_struct pointers
> rather than PID lookups and so might do one while release_task is in progress.
> e.g. async IO signals triggered via driver interrupts, etc.

Yes.  In 2.4 we explicitly checked in the signal code.

Why don't we do the sane thing and just do release_task() from
__put_task_struct(), rather than the current two-stage thing?

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

