Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbTIOFnF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 01:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbTIOFnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 01:43:05 -0400
Received: from dp.samba.org ([66.70.73.150]:42687 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262420AbTIOFnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 01:43:00 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jamie Lokier <jamie@shareable.org>
Cc: Felipe W Damasio <felipewd@terra.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel/futex.c: Uneeded memory barrier 
In-reply-to: Your message of "Sun, 14 Sep 2003 15:08:39 +0100."
             <20030914140839.GC16525@mail.jlokier.co.uk> 
Date: Mon, 15 Sep 2003 13:41:30 +1000
Message-Id: <20030915054300.947EB2C290@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030914140839.GC16525@mail.jlokier.co.uk> you write:
> Rusty Russell wrote:
> > I personally *HATE* the set_task_state()/__set_task_state() macros.
> > Simple assignments shouldn't be hidden behind macros, unless there's
> > something really subtle involved.
> 
> There _is_ something subtle involved.  Back in ye olde days, folk

This is what I hate about EMail.  You had two choices here: either I
don't understand you, or you don't understand me.  You chose wrong,
and wasted a lot of time on an (excellent, BTW) explanation.

I wasn't clear: __set_task_state() and __set_current_state() should
not exist, they are assignments.  set_task_state() should not exist,
since it's only used for current anyway.  set_current_state should be
split into set_current_interruptible() and
set_current_uninterruptible(), except...

> Sprinkling special kinds of memory barrier into all the drivers is not
> the kind of thing driver writers get right.  Also if you look at the

....hiding the subtlety in wrapper functions is the wrong approach.  We
have excellent wait_event, wait_event_interruptible and
wait_event_interruptible_timeout macros in wait.h which these drivers
should be using, which would make them simpler, less buggy and
smaller.

Hope that clarifies?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
