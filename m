Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262245AbVC2MBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbVC2MBJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 07:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbVC2MAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 07:00:14 -0500
Received: from mx2.elte.hu ([157.181.151.9]:13507 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262254AbVC2L57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 06:57:59 -0500
Date: Tue, 29 Mar 2005 13:56:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] logdev debugging memory device for tough to debug areas
Message-ID: <20050329115656.GA15708@elte.hu>
References: <1109032784.32648.24.camel@localhost.localdomain> <20050329090707.GD7074@elte.hu> <1112097210.3691.51.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112097210.3691.51.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Also, I'm almost done adding the pending owner work against .41-11. I 
> see you now have 41-13, and if you already implemented it, let me 
> know. [...]

nope, i havent touched that area of code, knowing that you are working 
on it.

> [...] I've been fighting your deadlock detection to make sure it works 
> with the changes. Then finally I found a race condition that I'm 
> solving.

great - just send it along when you have it.

> To have a task take back the ownership, I had the stealer call 
> task_blocks_on_lock on the task that it stole it from. To get this to 
> work, when a task is given the pending ownership, it doesn't NULL the 
> blocked_on at that point (although the waiter->task is set to NULL).  
> But this gives the race condition in pi_setprio where it checks for 
> p->blocked_on still exists. Reason is that I don't want the waking up 
> of a process to call any more locks. To solve this, I had to (and this 
> is what I don't like right now) add another flag for the process 
> called PF_BLOCKED. So that this can tell the pi_setprio when to stop.  
> This flag is set in task_blocks_on_lock and cleared in pick_new_owner 
> where the setting of blocked_on to NULL use to be.

which locks are affected? I'd prefer the simplest solution. If there's 
more overhead with deadlock detection (which is a debugging feature), 
that doesnt matter much.

> Unless you already implemented this, I'll have a patch for you to look 
> at later today, and you can then (if you want) critique it :-)

sure.

	Ingo
