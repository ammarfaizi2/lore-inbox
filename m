Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261978AbREZSjE>; Sat, 26 May 2001 14:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261979AbREZSiy>; Sat, 26 May 2001 14:38:54 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:43789 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S261978AbREZSio>;
	Sat, 26 May 2001 14:38:44 -0400
Date: Sat, 26 May 2001 12:51:38 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
In-Reply-To: <20010526173051.B9634@athlon.random>
Message-ID: <Pine.LNX.4.21.0105261250160.30264-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 May 2001, Andrea Arcangeli wrote:

> > > -	/* 
> > > -	 * Set our state for sleeping, then check again for buffer heads.
> > > -	 * This ensures we won't miss a wake_up from an interrupt.
> > > -	 */
> > > -	wait_event(buffer_wait, nr_unused_buffer_heads >= MAX_BUF_PER_PAGE);
> > > +	current->policy |= SCHED_YIELD;
> > > +	__set_current_state(TASK_RUNNING);
> > > +	schedule();
> > >  	goto try_again;
> > >  }

I'm still curious ... is it _really_ needed to busy-spin here?

I've seen some big problems with processes eating CPU time
while not getting any work done and am slowly trying to
eliminate those places in the VM by waiting on things.

Is it really needed to introduce a new busy-wait place in the
kernel?

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

