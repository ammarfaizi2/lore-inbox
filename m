Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSE1XBs>; Tue, 28 May 2002 19:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311710AbSE1XBr>; Tue, 28 May 2002 19:01:47 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:42504 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S311025AbSE1XBq>; Tue, 28 May 2002 19:01:46 -0400
Date: Tue, 28 May 2002 16:01:43 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: wait queue process state
Message-ID: <20020528160143.G885@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3CF2A0FB.8090507@um.edu.mt> <1022572663.12203.127.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2002 at 09:57:41AM +0200, Terje Eggestad wrote:
> Well, the only reason I'm aware of is that your have system calls that
> can't be interrupted, and sys calls that can (and when they do they
> return -1 and errno=EINTR). 
> 
> The number of syscall that actually can return EINTR is actually fairly
> small. And some like read()/write() may or may not depending on the type
> of file. If the file is a socket it usually can, but if it's a regular
> file it can't. 
> 
> A regular file access is as you uninteruptable as you point out, and to
> top it of it can be made nonblocking. The reason is that a regular file
> IO is deterministic, it must succeed or fail ASAP, and if it fail it's
> either a full FS, or a corrupt FS or a HW failure. (The latter two req
> reboot/HW repair, the first is a "normal" case). Socket IO is
> nondeterministic and we need a way to interrupt it. 
> 
> I guess deterministic/nondeterministic activities is one way to describe
> either a kernel task is interruptable or nor. Another rule of thumb is
> that you're noninteruptable if you're waiting for HW to complete a task.
> (If you don't want to wait, you should have done it async anyway). 
> You're interruptable if you wait for another program to do a task.
> 
> 
> Make sense?
> 
> TJ

I'm not going to speak to whether this is true in the
current kernels or not.

The read system call is interuptable, period.  Disk access
is considered slow.   If you code asuming it will not be
interupted or that an interupt will cause a return of -1
your code may break on Linux and will certainly not be
portable.

POSIX is ambigious on this and disk reads (on UNIX) have
historically returned partial data when interupted during a
disk read where some of the data was already in buffer.


>  
> 
> On Mon, 2002-05-27 at 23:11, Joseph Cordina wrote:
> > Hi,
> >    I am quite new to this list and thus does not know if this question 
> > has been answered many a times. I have looked in the archive but could 
> > not find it. Here goes anyway:
> >      I realised that when processes are placed in the wait queue, they 
> > are set at either INTERRUPTIBLE or NONINTERRUPTIBLE. I also noticed that 
> > something like file access is set as NONINTERRUPTIBLE. Could someone 
> > please tell me the reason for having these two states. I can understand 
> > that INTERRUPTIBLE can be made to be interrupted by a timer or a signal 
> > and vice versa for UNTERRUPTIBLE. Yet what makes blocking system calls 
> > as INTERRUPTIBLE or NONINTERRUPTIBLE. Also why is file access considered 
> > as NONINTERRUPTIBLE.
> > 
> > In addition, inside the kernel running, are these two different states 
> > treated differently (apart from the allowance to be interrupted or 
> > otherwise).
> > 
> > The reason I am asking is that I am working on scheduler activations 
> > which allow new kernel threads to be created when a kernel thread blocks 
> > inside the kernel. Yet this only works for INTERRUPTIBLE processes, I 
> > was thinking of making it work also for NONINTERRUPTIBLE processes. Just 
> > wondering if this would have any repurcusions. Also when a process 
> > generates a page fault which causes a page to be retreived from the 
> > filesystem, it such a process placed in the wait queue as 
> > NONINTERRUPTIBLE also ?
> > 
> > Cheers
> > 
> > Joseph Cordina
> > University of Malta
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -- 
> _________________________________________________________________________
> 
> Terje Eggestad                  mailto:terje.eggestad@scali.no
> Scali Scalable Linux Systems    http://www.scali.com
> 
> Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
> P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
> N-0619 Oslo                     fax:    +47 22 62 89 51
> NORWAY            
> _________________________________________________________________________
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
