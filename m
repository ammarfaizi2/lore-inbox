Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277656AbRJ3TMF>; Tue, 30 Oct 2001 14:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277653AbRJ3TLz>; Tue, 30 Oct 2001 14:11:55 -0500
Received: from [208.129.208.52] ([208.129.208.52]:41226 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S277564AbRJ3TLm>;
	Tue, 30 Oct 2001 14:11:42 -0500
Date: Tue, 30 Oct 2001 11:19:50 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Hubertus Franke <frankeh@watson.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, <lse-tech@lists.sourceforge.net>
Subject: Re: [PATCH][RFC] Proposal For A More Scalable Scheduler ...
In-Reply-To: <20011030115257.A16187@watson.ibm.com>
Message-ID: <Pine.LNX.4.40.0110301104330.1495-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2001, Hubertus Franke wrote:

> > Real time processes, when wakeup up fall calling reschedule_idle() that
> > will either find the CPU idle or will be reschedule due a favorable
> > preemption_goodness().
> > One of balancing scheme I'm using tries to distribute RT tasks evenly on
> > CPUs.
> >
>
> I think that would be a problem. My understanding is that if two RT process
> are globally runnable, then one must run the one with higher priority.
> Am I missing something here ?

The only difference is when an RT task is currently running and another RT
task kicks in with a not favorable preemption_goodness().
In the current scheduler reschedule_idle() loops through the CPUs to find
one for the incoming RT tasks while the proposed scheduler actually
doesn't.
What I'm coding is to plug in get_best_cpu() a way to evenly spread RT
tasks between CPUs.
But even the RT task rapid move to another CPU is not too rapid due
IPI+schedule() latency.
Maybe it's faster the currently running RT tasks to reschedule instead of
the remote CPU, maybe :)
The current IPI method creates very funny/undesirable behavior due
IPI+schedule() latency.
When watching at the  schedcnt  dump of a  lat_ctx  of my 2 way SMP
system, I saw both tasks lying on the same CPU with the other one
tempested by reschedule IPI without being able to catch one task due latency.




- Davide


