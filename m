Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284696AbRLIXsl>; Sun, 9 Dec 2001 18:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284698AbRLIXs0>; Sun, 9 Dec 2001 18:48:26 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:32525 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S284676AbRLIXsR>; Sun, 9 Dec 2001 18:48:17 -0500
Date: Sun, 9 Dec 2001 15:50:04 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mike Kravetz <kravetz@us.ibm.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rusty Russell <rusty@rustcorp.com.au>,
        <anton@samba.org>, <davej@suse.de>, <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Linux 2.4.17-pre5
In-Reply-To: <20011209144433.B1087@w-mikek2.sequent.com>
Message-ID: <Pine.LNX.4.40.0112091548260.996-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Dec 2001, Mike Kravetz wrote:

> On Sun, Dec 09, 2001 at 04:24:59PM +0000, Alan Cox wrote:
> > I'm currently using the following rule in wake up
> >
> > 	if(current->mm->runnable > 0)	/* One already running ? */
> > 		cpu = current->mm->last_cpu;
> > 	else
> > 		cpu = idle_cpu();
> > 	else
> > 		cpu = cpu_num[fast_fl1(runnable_set)]
> >
> > that is
> > 	If we are running threads with this mm on a cpu throw them at the
> > 		same core
> > 	If there is an idle CPU use it
> > 	Take the mask of currently executing priority levels, find the last
> > 	set bit (lowest pri) being executed, and look up a cpu running at
> > 	that priority
> >
> > Then the idle stealing code will do the rest of the balancing, but at least
> > it converges towards each mm living on one cpu core.
>
> This implies that the idle loop will poll looking for work to do.
> Is that correct?  Davide's scheduler also does this.  I believe
> the current default idle loop (at least for i386) does as little
> as possible and stops execting instructions.  Comments in the code
> mention power consumption.  Should we be concerned with this?

My idea is not to poll ( due energy issues ) but to wake up idles (
kernel/timer.c ) at every timer tick to let them monitor the overall
balancing status.




- Davide


