Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286937AbRL1Rjm>; Fri, 28 Dec 2001 12:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286938AbRL1Rjb>; Fri, 28 Dec 2001 12:39:31 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:41229 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S286937AbRL1RjX>; Fri, 28 Dec 2001 12:39:23 -0500
Date: Fri, 28 Dec 2001 09:43:08 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Stephan von Krawczynski <skraw@ithnet.com>, <jwb@saturn5.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17 absurd number of context switches
In-Reply-To: <E16K12o-0001BR-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0112280939200.1466-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2001, Alan Cox wrote:

> >         local_irq_disable();
> >         if (current->counter > 0)
> >             --current->counter;
> >         local_irq_enable();
>
> Umm: SuS sayeth..
>
>    DESCRIPTION
>
>      The sched_yield() function forces the running thread to relinquish the
>      processor until it again becomes the head of its thread list. It takes
>      no arguments.
>
> Which doesnt seem to be what you are doing.

1) the scheduler in 2.5.2-pre3 does it in a different way because the
	dynamic priority is split from the time slice.

2) the current scheduler does not permit you doing such a thing in a smart
	way so, if i've to choose i prefer an implementation that solves
	real world cases. i challenge you to measure the counter tick loss
	during the yield() call anyway. it's very easy indeed to measure
	the current behavior, like we're currently seeing




- Davide


