Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289007AbSANTxy>; Mon, 14 Jan 2002 14:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288955AbSANTw1>; Mon, 14 Jan 2002 14:52:27 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:56307 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S288952AbSANTvh>; Mon, 14 Jan 2002 14:51:37 -0500
Message-ID: <3C433695.A9188FF2@mvista.com>
Date: Mon, 14 Jan 2002 11:50:45 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: arjanv@redhat.com
CC: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <20020114104532.59950d86.skraw@ithnet.com>; from skraw@ithnet.com on lun ene 14 2002 at 10:45:32 +0100 <20020114160256.A2922@werewolf.able.es> <3C42F33C.88F423F6@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> 
> "J.A. Magallon" wrote:
> >
> > On 20020114 Stephan von Krawczynski wrote:
> > >
> > >Hm, obviously the ll-patches look simple, but their pure required number makes
> > >me think they are as well stupid as simple. This whole story looks like making
> > >an old mac do real multitasking, just spread around scheduling points
> >
> > Yup. That remind me of...
> > Would there be any kernel call every driver is doing just to hide there
> > a conditional_schedule() so everyone does it even without knowledge of it ?
> > Just like Apple put the SystemTask() inside GetNextEvent()...
> 
> Well the preempt patch sort of does this in every spin_unlock*() .....
> -
Gosh, not really.  The nature of the preempt patch is to allow
preemption on completion of the interrupt that put the contending task
back in the run list.  This can not be done if a spin lock is held, so
yes, there is a test on exit from the spin lock, but the point is that
this is only needed when the lock is release, not in unlocked code.

The utility of most of the ll patches is that they address the problem
within locked regions.  This is why there is a lock-break patch that is
designed to augment the preempt patch.  It picks up several of the long
held spin locks and pops out of them early to allow preemption, and then
relocks and continues (after picking up the pieces, of course).
-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
