Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275910AbSIUMvZ>; Sat, 21 Sep 2002 08:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275911AbSIUMvZ>; Sat, 21 Sep 2002 08:51:25 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:25261 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S275910AbSIUMvY>;
	Sat, 21 Sep 2002 08:51:24 -0400
Date: Sat, 21 Sep 2002 14:56:26 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: quadratic behaviour
Message-ID: <20020921125626.GA15603@win.tue.nl>
References: <20020918211547.GA14657@win.tue.nl> <Pine.LNX.4.44.0209190502120.5184-100000@localhost.localdomain> <20020919131157.GA14938@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020919131157.GA14938@win.tue.nl>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 03:11:57PM +0200, Andries Brouwer wrote:
> On Thu, Sep 19, 2002 at 05:05:17AM +0200, Ingo Molnar wrote:

> > because, as mentioned before, that particular loop i fixed in 2.5.35.
> 
> But now that I look at patch-2.5.35
> I don't see any improvement: for_each_task() is now called
> for_each_process(), but otherwise base.c is just as quadratic
> as it was.
> 
> So, why do you think this problem has been fixed?

Let me repeat this, and call it an observation instead of a question,
so that you do not think I am in doubt.

If you have 20000 processes, and do ps, then get_pid_list() will be
called 1000 times, and the for_each_process() loop will examine
10000000 processes.

Unlike the get_pid() situation, which was actually amortized linear with a very
small coefficient, here we have a bad quadratic behaviour, still in 2.5.37.

Andries
