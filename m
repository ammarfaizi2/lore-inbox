Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265608AbTBXIk0>; Mon, 24 Feb 2003 03:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265612AbTBXIk0>; Mon, 24 Feb 2003 03:40:26 -0500
Received: from cimice4.netroute.cz ([212.71.168.94]:14074 "EHLO
	vagabond.cybernet.cz") by vger.kernel.org with ESMTP
	id <S265608AbTBXIkZ>; Mon, 24 Feb 2003 03:40:25 -0500
Date: Mon, 24 Feb 2003 09:50:35 +0100
From: Jan Hudec <bulb@ucw.cz>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Syscalls on behalf of another process (was Syscalls in kernel space)
Message-ID: <20030224085035.GB18741@vagabond>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0302211909140.1417-100000@students.iiit.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302211909140.1417-100000@students.iiit.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 07:10:56PM +0530, Prasad wrote:
> 
> (Resending the previous mail)
> 
> I am sorry for not being clear the previous time... but i think its time
> to tell you where i needed it.  I, as a graduating project am working on a
> distributed computing system, a part of which is "transparent process
> migration in non-distributed environments".  In my system i would like to
> ship the syscalls back to the original node(where the process originated).
> so for that i have a kernel thread that takes the requests and is supposed
> to execute the syscalls on behalf of the process (I have the idle task
> structure existing on the originating node even after the process is
> migrated to the other node).  And the question is how do i do that.  The
> idea I had was to execute the functions behind the syscalls directly, but
> again, these functions use a lot of 'current'.  Could you help me out of
> this situation!
> 	An alternative was that if get_current was called I would check if
> the 'current' points to my kernel thread and if i have a remote syscall
> pending, then i would return a pointer to the particular process's
> task_struct.  This I think is a work-around that should work.  Please do
> comment on this too.

current generaly has to mean current for the syscall to work. For some
syscalls it does not actually matter which process executes them. You
will have to run some in another thread than your main (because they
would block). The few processes that do care in which process they run,
you probably need to emulate them, but IIRC there is not many of them.

Note: there is implementation of this. It's called Mosix. You could look
how it does this.

> Prasad.
> 
> On Thu, 20 Feb 2003, Andrea Arcangeli wrote:
> > > 
> > > He is talking about directly calling the function behind the syscall,
> > > not actually executing a syscall itself.
> > 
> > this is not what I understood from your previous discussion also given
> > you suggest not to do that when he can call sys_read/sys_write instead
> > because they're just exported etc.. I just wanted to add a better
> > "never".
> > 
> > > syscalls should be made from userspace, not the kernel.
> > 
> > This is what I tried to say.
> > 
> > Andrea
> > 
> 
> -- 
> Failure is not an option
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
