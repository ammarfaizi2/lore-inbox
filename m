Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286931AbRL1RS6>; Fri, 28 Dec 2001 12:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284020AbRL1RSs>; Fri, 28 Dec 2001 12:18:48 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:30221 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S284090AbRL1RSo>; Fri, 28 Dec 2001 12:18:44 -0500
Date: Fri, 28 Dec 2001 09:22:28 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <jwb@saturn5.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17 absurd number of context switches
In-Reply-To: <20011228181403.2b364811.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.40.0112280920270.1466-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2001, Stephan von Krawczynski wrote:

> On Fri, 28 Dec 2001 09:07:48 -0800 (PST)
> Davide Libenzi <davidel@xmailserver.org> wrote:
>
> > The scheduler that Linus merged in 2.5.2-pre3 will solve the problem.
>
> Could you kindly provide a patch for 2.4.17 for Jeffrey to test and give
> comparison results to the list. This could be interesting for 2.4 too (which
> the world uses nowadays (and in the near future))?
>
> Thanks for your help ;-)

You can't, the scheduler is changed.
Try this, in sys_sched_yield() remove :

        spin_lock_irq(&runqueue_lock);
        move_last_runqueue(current);
        spin_unlock_irq(&runqueue_lock);

and replace it with :

        local_irq_disable();
        if (current->counter > 0)
            --current->counter;
        local_irq_enable();



- Davide


