Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbTEUU3b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 16:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbTEUU3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 16:29:31 -0400
Received: from mail.gmx.de ([213.165.65.60]:8539 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262269AbTEUU3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 16:29:30 -0400
Message-Id: <5.2.0.9.2.20030521221522.00cc0790@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Wed, 21 May 2003 22:46:15 +0200
To: davidm@hpl.hp.com
From: Mike Galbraith <efault@gmx.de>
Subject: Re: web page on O(1) scheduler
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
In-Reply-To: <16075.48579.189593.405154@napali.hpl.hp.com>
References: <5.2.0.9.2.20030521111037.01ed0d58@pop.gmx.net>
 <16075.8557.309002.866895@napali.hpl.hp.com>
 <5.2.0.9.2.20030521111037.01ed0d58@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:56 AM 5/21/2003 -0700, David Mosberger wrote:
> >>>>> On Wed, 21 May 2003 11:26:31 +0200, Mike Galbraith <efault@gmx.de> 
> said:
>
>   Mike> The page mentions persistent starvation.  My own explorations
>   Mike> of this issue indicate that the primary source is always
>   Mike> selecting the highest priority queue.
>
>My working assumption is that the problem is a bug with the dynamic
>prioritization.  The task receiving the signals calls sleep() after
>handling a signal and hence it's dynamic priority should end up higher
>than the priority of the task sending signals (since the sender never
>relinquishes the CPU voluntarily).

The only thing that matters is how much you sleep vs run, so yes, it should 
have a higher priority unless that handling is heavy on cpu.  If it 
doesn't, then you have to have a different problem, because the dynamic 
priority portion of the scheduler is dead simple.  The only way I can 
imagine that priority could end up lower than expected is heavyweight 
interrupt load, or spinning out of control.

>However, I haven't actually had time to look at the relevant code, so
>I may be missing something.  If you understand the issue better,
>please explain to me why this isn't a dynamic priority issue.

I just saw your other post regarding the web page.  Now that I know that 
there's a detailed description in there somewhere, I'll go read it and see 
if any of what I've gleaned from crawling around the scheduler code is 
useful.  I thought you might be encountering the same kind of generic 
starvation I've seen.  Ergo, the simple diag patch.

         -Mike 

