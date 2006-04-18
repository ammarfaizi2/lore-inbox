Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbWDRNzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWDRNzp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 09:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbWDRNzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 09:55:44 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:30418 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751021AbWDRNzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 09:55:44 -0400
Subject: Re: [RT] bad BUG_ON in rtmutex.c
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1145368228.17085.85.camel@localhost.localdomain>
References: <1145324887.17085.35.camel@localhost.localdomain>
	 <1145362851.5447.12.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0604180831390.9005@gandalf.stny.rr.com>
	 <1145365886.5447.28.camel@localhost.localdomain>
	 <1145368228.17085.85.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 18 Apr 2006 09:55:32 -0400
Message-Id: <1145368532.17085.88.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-18 at 09:50 -0400, Steven Rostedt wrote:

> BUT!  I need to take another good look at the code, and maybe my
> previous example of the failed BUG_ON is really a clue that there exists
> a deeper bug.  If the processes D and E from my last example were of
> different priorities, but still higher than A, could the end result be
> setting A to the lower of the two?  This would be a bug, because then A
> would not inherit the correct priority!

OK, this shouldn't be a problem (answering my own question ;).

The setting of the task's prio is done by __rt_mutex_adjust_prio(task)
and this sets the task's prio to the highest prio task that is blocked
on a lock own by "task", or to "task"s original prio if that is higher.

So nevermind.

-- Steve


