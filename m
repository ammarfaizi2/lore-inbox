Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279704AbRJ3A76>; Mon, 29 Oct 2001 19:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279705AbRJ3A7h>; Mon, 29 Oct 2001 19:59:37 -0500
Received: from t05-17.ra.uc.edu ([129.137.228.113]:54912 "EHLO cartman")
	by vger.kernel.org with ESMTP id <S279704AbRJ3A7g>;
	Mon, 29 Oct 2001 19:59:36 -0500
Date: Mon, 29 Oct 2001 19:58:58 -0500
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 8139too termination
Message-ID: <20011029195858.A649@cartman>
In-Reply-To: <20011029181029.A320@cartman> <3BDDE5DF.71917D8F@zip.com.au>, <3BDDE5DF.71917D8F@zip.com.au> <20011029190817.B320@cartman> <3BDDF4B0.194E132F@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BDDF4B0.194E132F@zip.com.au>
User-Agent: Mutt/1.3.23i
From: Robert Kuebel <kuebelr@email.uc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2001 at 04:30:40PM -0800, Andrew Morton wrote:
> Robert Kuebel wrote:
> > 
> > what about changing doing
> >         spin_lock_irq(&current->sigmask_lock);
> >         sigfillset(&current->blocked);  /* block all sig's */
> >         recalc_sigpending(current);
> >         spin_unlock_irq(&current->sigmask_lock);
> > 
> > instead of
> > 
> >         spin_lock_irq(&current->sigmask_lock);
> >         sigemptyset(&current->blocked);
> >         recalc_sigpending(current);
> >         spin_unlock_irq(&current->sigmask_lock);
> > 
> > and replacing the signal_pending() stuff in the loops of
> > rtl8139_thread() with checks for tp->diediedie?
> 
> If you block all the signals then the kill_proc() won't
> bring the thread out of interruptible sleep?

right, you would have to take out the kill_proc().
can't you just let the thread return and not use kill_proc()?  i have
been checking out the reiserfsd thread.

i could be missing something.

