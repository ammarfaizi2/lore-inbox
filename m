Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261449AbREZPbf>; Sat, 26 May 2001 11:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261471AbREZPb0>; Sat, 26 May 2001 11:31:26 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:35856 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261449AbREZPbO>; Sat, 26 May 2001 11:31:14 -0400
Date: Sat, 26 May 2001 17:30:51 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
Message-ID: <20010526173051.B9634@athlon.random>
In-Reply-To: <20010526171459.Y9634@athlon.random> <Pine.LNX.4.21.0105261219360.30264-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0105261219360.30264-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Sat, May 26, 2001 at 12:22:59PM -0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2001 at 12:22:59PM -0300, Rik van Riel wrote:
> On Sat, 26 May 2001, Andrea Arcangeli wrote:
> 
> > @@ -1416,11 +1416,9 @@
> >  	 */
> >  	run_task_queue(&tq_disk);
> >  
> > -	/* 
> > -	 * Set our state for sleeping, then check again for buffer heads.
> > -	 * This ensures we won't miss a wake_up from an interrupt.
> > -	 */
> > -	wait_event(buffer_wait, nr_unused_buffer_heads >= MAX_BUF_PER_PAGE);
> > +	current->policy |= SCHED_YIELD;
> > +	__set_current_state(TASK_RUNNING);
> > +	schedule();
> >  	goto try_again;
> >  }
> 
> This cannot possibly fix the problem because this code is
> never reached.
> 
> What was observed in the backtraces by arjan, ben, marcelo
> and people at IBM was:
> 
> create_buffers -> get_unused_buffer_head -> __alloc_pages
> 
> with the system looping infinitely in __alloc_pages. The
> code you are changing above ONLY gets reached in case the
> __alloc_pages (and thus, get_unused_buffer_head) returns
> failure.

Fine, then post the strict __alloc_pages patch, after that you will run
into the above code. Those are different issues, like I'm claiming since
the first place, your patch didn't addressed the above.

I definitely agree that if __alloc_pages itself deadlocks the above
cannot make differences.

Andrea
