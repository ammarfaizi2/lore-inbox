Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030979AbVIIXfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030979AbVIIXfi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 19:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030981AbVIIXfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 19:35:38 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:24453 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030979AbVIIXfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 19:35:37 -0400
Date: Fri, 9 Sep 2005 16:35:30 -0700
From: Paul Jackson <pj@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm@osdl.org, Simon.Derr@bull.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuset semaphore depth check deadlock fix
Message-Id: <20050909163530.7b160863.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.58.0509091512180.3051@g5.osdl.org>
References: <20050909220116.26993.9674.sendpatchset@jackhammer.engr.sgi.com>
	<Pine.LNX.4.58.0509091512180.3051@g5.osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus wrote:
> We _really_ don't want to have function names like "cs_up()" 

I thoroughly agree with your attention to naming, and spent more time
than I will admit in public futzing over this detail.

I wrote the code using cpuset_lock(void) and cpuset_unlock(void), for
reasons such as you state, and out of personnal instinct.

But then I noticed that I wanted these routines to replace up(&sem) and
down(&sem) (in kernel/cpuset.c), so changed them to cpuset_up(&sem) and
cpuset_down(&sem), adding in the explicitly passed argument.

But then I noticed that these names looked "too global" to me, and
intentionally changed that to cs_up(&sem) and cs_down(&sem).  I tend
to intentionally choose shorter names for more local stuff, especially
inlines and such that won't even show up on a stack trace.

 1) Is cpuset_up(&sem) and cpuset_down(&sem) ok by you?  I would like
    to have the up/down in there somewhere.

 2) How the heck do I make this change:
     - Send another patch from scratch, ignoring the first one I sent.
     - Send a second patch that layers on the first.
     - Let you do the edit.
     - ??

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
