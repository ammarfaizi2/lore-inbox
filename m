Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132503AbRD0XWc>; Fri, 27 Apr 2001 19:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132520AbRD0XWV>; Fri, 27 Apr 2001 19:22:21 -0400
Received: from nrg.org ([216.101.165.106]:33085 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S132503AbRD0XWS>;
	Fri, 27 Apr 2001 19:22:18 -0400
Date: Fri, 27 Apr 2001 16:22:14 -0700 (PDT)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Mike Galbraith <mikeg@wen-online.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: #define HZ 1024 -- negative effects?
In-Reply-To: <Pine.LNX.4.33.0104272225120.354-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.05.10104271609400.3283-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Apr 2001, Mike Galbraith wrote:
> On Fri, 27 Apr 2001, Nigel Gamble wrote:
> > > What about SCHED_YIELD and allocating during vm stress times?
> 
> snip
> 
> > A well-written GUI should not be using SCHED_YIELD.  If it is
> 
> I was refering to the gui (or other tasks) allocating memory during
> vm stress periods, and running into the yield in __alloc_pages()..
> not a voluntary yield.

Oh, I see.  Well, if this were causing the problem, then running the GUI
at a real-time priority would be a better solution than increasing the
clock frequency, since SCHED_YIELD has no effect on real-time tasks
unless there are other runnable real-time tasks at the same priority.
The call to schedule() would just reschedule the real-time GUI task
itself immediately.

However, in times of vm stress it is more likely that GUI performance
problems would be caused by parts of the GUI having been paged out,
rather than by anything which could be helped by scheduling differences.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

MontaVista Software                             nigel@mvista.com

