Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263999AbTJOSlf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 14:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263998AbTJOSjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 14:39:46 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:3986 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263996AbTJOSjN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 14:39:13 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 15 Oct 2003 11:35:07 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: question on incoming packets and scheduler
In-Reply-To: <3F8D8F3A.5040506@nortelnetworks.com>
Message-ID: <Pine.LNX.4.56.0310151133030.2144@bigblue.dev.mdolabs.com>
References: <3F8CA55C.1080203@nortelnetworks.com>
 <Pine.LNX.4.56.0310151035480.2144@bigblue.dev.mdolabs.com>
 <3F8D8F3A.5040506@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Oct 2003, Chris Friesen wrote:

> Davide Libenzi wrote:
> > On Tue, 14 Oct 2003, Chris Friesen wrote:
>
> >>I have a long-running cpu hog background task, and a high-priority
> >>critical task that waits on a socket for network traffic.  When a packet
> >>comes in, I'd like the cpu hog to be swapped out ASAP, rather than
> >>waiting for the end of the timeslice.  Is there any way to make this happen?
>
>
> > What do you mean for high priority? Is it an RT task? The wakeup (AKA
> > inserion in the run queue) happen soon :
> > IRQ->do_IRQ->softirq->net_rx_action->ip_rcv->...
> > but if your task is not RT there no guarantee that it'll preempt the
> > current running.
>
> Yes, it was an RT task.
>
> It appears that 2.4.20 fixes this issue, but there is another one
> remaining that the latency appears to be dependent on the number of
> incoming packets.  See thread "incoming packet latency in 2.4.[18-20]"
> for details.  This behaviour doesn't show up in 2.6, and I'm about to
> test 2.4.22.

Are you sure it's not a livelock issue during the burst?


- Davide

