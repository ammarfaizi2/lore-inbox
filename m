Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263803AbTJORnV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 13:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263807AbTJORnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 13:43:21 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:43409 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263803AbTJORnP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 13:43:15 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 15 Oct 2003 10:39:08 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: question on incoming packets and scheduler
In-Reply-To: <3F8CA55C.1080203@nortelnetworks.com>
Message-ID: <Pine.LNX.4.56.0310151035480.2144@bigblue.dev.mdolabs.com>
References: <3F8CA55C.1080203@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Oct 2003, Chris Friesen wrote:

>
> I have a long-running cpu hog background task, and a high-priority
> critical task that waits on a socket for network traffic.  When a packet
> comes in, I'd like the cpu hog to be swapped out ASAP, rather than
> waiting for the end of the timeslice.  Is there any way to make this happen?
>
> The code paths that I managed to trace didn't seem to be calling the
> scheduler to force the context switch.  Hopefully I missed something.

What do you mean for high priority? Is it an RT task? The wakeup (AKA
inserion in the run queue) happen soon :
IRQ->do_IRQ->softirq->net_rx_action->ip_rcv->...
but if your task is not RT there no guarantee that it'll preempt the
current running.



- Davide

