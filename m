Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262292AbVG0PDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262292AbVG0PDd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 11:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbVG0PDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 11:03:32 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:62135 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262292AbVG0PC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 11:02:56 -0400
Subject: Re: [RFC][PATCH] Make MAX_RT_PRIO and MAX_USER_RT_PRIO configurable
From: Steven Rostedt <rostedt@goodmis.org>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.OSF.4.05.10507271645210.24769-100000@da410.phys.au.dk>
References: <Pine.OSF.4.05.10507271645210.24769-100000@da410.phys.au.dk>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 27 Jul 2005 11:02:42 -0400
Message-Id: <1122476562.29823.83.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-27 at 16:53 +0200, Esben Nielsen wrote:
> Isn't there a way to mark it "warning! warning! dangerous!" ?

Sure,

  config MAX_RT_PRIO
     int "Maximum RT priority (DANGEROUS!)"


> 
> Anyway: I think 100 RT priorities is way overkill - and slowing things
> down by making the scheduler checking more empty slots in the runqueue.
> Default ought to be 10. In practise it will be very hard to have
> a task at the lower RT priority behaving real-time with 99 higher
> priority tasks around. I find it hard to believe that somebody has an RT
> app needing more than 10 priorities and can't do with RR or FIFO
> scheduling within a fewer number of prorities.

I've wondered this too, especially when customers ask for more.  I never
question them (don't bite the hand that feeds you), but I really think
that they like to prioritize things by 10.  So you go from 10 20 30
instead, leaving room in between incase you forget something. Kind of
like the old BASIC programming days with line numbers.

There's also the case that you have groups of tasks that are all higher
in priority than other groups.  But the tasks themselves have priorities
with each other.  So you group the tasks in a range where they are
greater than or less then other task groups.  And then you can arrange
the tasks yourself.  But this all gets quite complex and then leads to
more custom kernels :-)

-- Steve


