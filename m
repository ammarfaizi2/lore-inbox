Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317219AbSFRAzG>; Mon, 17 Jun 2002 20:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317232AbSFRAzF>; Mon, 17 Jun 2002 20:55:05 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:38644 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317219AbSFRAzD>; Mon, 17 Jun 2002 20:55:03 -0400
Subject: Re: Question about sched_yield()
From: Robert Love <rml@tech9.net>
To: David Schwartz <davids@webmaster.com>
Cc: mgix@mgix.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020618004630.AAA28082@shell.webmaster.com@whenever>
References: <20020618004630.AAA28082@shell.webmaster.com@whenever>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 17 Jun 2002 17:55:02 -0700
Message-Id: <1024361703.924.176.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-06-17 at 17:46, David Schwartz wrote:

> 	You seem to have a misconception about what sched_yield is for.
> It is not a  replacement for blocking or a scheduling priority
> adjustment. It simply lets other ready-to-run tasks be scheduled
before returning to the current task.
> 
> 	Here's a quote from SuS3:
> 
> "The sched_yield() function shall force the running thread to relinquish the 
> processor until it again becomes the head of its thread list. It takes no 
> arguments."
> 
> 	This neither says nor implies anything about CPU usage. It simply says
> that  the current thread will yield and be put at the end of the list.

And you seem to have a misconception about sched_yield, too.  If a
machine has n tasks, half of which are doing CPU-intense work and the
other half of which are just yielding... why on Earth would the yielding
tasks get any noticeable amount of CPU use?

Seems to me the behavior of sched_yield is a bit broken.  If the tasks
are correctly returned to the end of their runqueue, this should not
happen.  Note, for example, you will not see this behavior in 2.5.

Quite frankly, even if the supposed standard says nothing of this... I
do not care: calling sched_yield in a loop should not show up as a CPU
hog.

	Robert Love

