Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276525AbRJGSCB>; Sun, 7 Oct 2001 14:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276519AbRJGSBv>; Sun, 7 Oct 2001 14:01:51 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:52724 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S276538AbRJGSBd>; Sun, 7 Oct 2001 14:01:33 -0400
Message-ID: <3BC0982A.84ECBE7B@mvista.com>
Date: Sun, 07 Oct 2001 11:00:10 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mika Liljeberg <Mika.Liljeberg@welho.com>
CC: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Benjamin LaHaise <bcrl@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Context switch times
In-Reply-To: <E15pWfR-0006g5-00@the-village.bc.nu> <3BC02709.A8E6F999@welho.com> <20011007150358.G30515@nightmaster.csn.tu-chemnitz.de> <3BC05D2E.94F05935@welho.com> <20011007162439.P748@nightmaster.csn.tu-chemnitz.de> <3BC067BB.73AF1EB5@welho.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mika Liljeberg wrote:
> 
> Ingo Oeser wrote:
> > There are idle tasks per CPU. If there are runnable tasks and the
> > idle-task of a CPU is running it, it is not fully loaded at this
> > time.
> >
> > No idle task is running, if all CPUs are fully loaded AFAIR.
> 
> Yes. However, you still want to balance the queues even if all CPUs are
> 100% utilized. It's a fairness issue. Otherwise you could have 1 task
> running on one CPU and 49 tasks on another.
> 
On the face of it this only seems unfair.  I think what we want to do is
to allocate the cpu resources among competing tasks as dictated by their
NICE values.  If each task gets its allotted share it should not matter
if one of them is monopolizing one cpu.  This is not to say that things
will work out this way, but to say that this is not the measure, nor the
thing to look at.

I suggest that, using the "recalculate tick" as a measure of time (I
know it is not very linear) when a cpu finds itself with nothing to do
(because all its tasks have completed their slices or blocked) and other
cpus have tasks in their queues it is time to "shop" for a new task to
run.  This would then do load balancing just before each "recalculate
tick".

Of course, the above assumes that each cpu has its own run queue.

George
