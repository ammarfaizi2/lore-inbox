Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272742AbTG1IfA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 04:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272744AbTG1Ie7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 04:34:59 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:30882
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272742AbTG1Ieu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 04:34:50 -0400
Message-ID: <1059382204.3f24e3bc32d56@kolivas.org>
Date: Mon, 28 Jul 2003 18:50:04 +1000
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] sched-2.6.0-test1-G6, interactivity changes
References: <Pine.LNX.4.44.0307280921360.3537-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0307280921360.3537-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ingo Molnar <mingo@elte.hu>:

> 
> On Mon, 28 Jul 2003, Con Kolivas wrote:
> 
> > On Sun, 27 Jul 2003 23:40, Ingo Molnar wrote:
> > >  - further increase timeslice granularity
> > 
> > For a while now I've been running a 1000Hz 2.4 O(1) kernel tree that
> > uses timeslice granularity set to MIN_TIMESLICE which has stark
> > smoothness improvements in X. I've avoided promoting this idea because
> > of the theoretical drop in throughput this might cause. I've not been
> > able to see any detriment in my basic testing of this small granularity,
> > so I was curious to see what you throught was a reasonable lower limit?
> 
> it's a hard question. The 25 msecs in -G6 is probably too low.

Just another thought on that is to make sure they don't get requeued to start 
with just 2 ticks left - which would happen to all nice 0 tasks running their 
full timeslice. Here is what I'm doing in O10:

+	} else if (!((task_timeslice(p) - p->time_slice) %
+		TIMESLICE_GRANULARITY) && (p->time_slice > MIN_TIMESLICE) &&
+		(p->array == rq->active)) {

Con
