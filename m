Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272452AbTHEGCP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 02:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272466AbTHEGCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 02:02:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:6316 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272452AbTHEGCO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 02:02:14 -0400
Date: Mon, 4 Aug 2003 23:03:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: piggin@cyberone.com.au, linux-kernel@vger.kernel.org, mingo@elte.hu,
       felipe_alfaro@linuxmail.org
Subject: Re: [PATCH] O13int for interactivity
Message-Id: <20030804230337.703de772.akpm@osdl.org>
In-Reply-To: <1060059844.3f2f3ac46e2f2@kolivas.org>
References: <200308050207.18096.kernel@kolivas.org>
	<200308051220.04779.kernel@kolivas.org>
	<3F2F149F.1020201@cyberone.com.au>
	<200308051318.47464.kernel@kolivas.org>
	<3F2F2517.7080507@cyberone.com.au>
	<1060059844.3f2f3ac46e2f2@kolivas.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> > In short: make the same policy for an interruptible and an uninterruptible
>  > sleep.
> 
>  That's the policy that has always existed...
> 
>  Interesting that I have only seen the desired effect and haven't noticed any 
>  side effect from this change so far. I'll keep experimenting as much as 
>  possible (as if I wasn't going to) and see what the testers find as well.

We do prefer that TASK_UNINTERRUPTIBLE processes are woken promptly so they
can submit more IO and go back to sleep.  Remember that we are artificially
leaving the disk head idle in the expectation that the task will submit
more I/O.  It's pretty sad if the CPU scheduler leaves the anticipated task
in the doldrums for five milliseconds.

Very early on in AS development I was playing with adding "extra boost" to
the anticipated-upon task, but it did appear that the stock scheduler was
sufficiently doing the right thing anyway.


