Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129810AbQJ0Qm6>; Fri, 27 Oct 2000 12:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129842AbQJ0Qmt>; Fri, 27 Oct 2000 12:42:49 -0400
Received: from ns1.wintelcom.net ([209.1.153.20]:15118 "EHLO fw.wintelcom.net")
	by vger.kernel.org with ESMTP id <S129810AbQJ0Qmo>;
	Fri, 27 Oct 2000 12:42:44 -0400
Date: Fri, 27 Oct 2000 09:42:35 -0700
From: Alfred Perlstein <bright@wintelcom.net>
To: Dan Kegel <dank@alumni.caltech.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jonathan Lemon <jlemon@flugsvamp.com>,
        Gideon Glass <gid@cisco.com>, Simon Kirby <sim@stormix.com>,
        chat@FreeBSD.ORG, linux-kernel@vger.kernel.org
Subject: Re: kqueue microbenchmark results
Message-ID: <20001027094235.C28123@fw.wintelcom.net>
In-Reply-To: <E13oyOE-00044z-00@the-village.bc.nu> <39F9AB95.735E26A7@alumni.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <39F9AB95.735E26A7@alumni.caltech.edu>; from dank@alumni.caltech.edu on Fri, Oct 27, 2000 at 09:21:41AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dan Kegel <dank@alumni.caltech.edu> [001027 09:40] wrote:
> Alan Cox wrote:
> > > > kqueue currently does this; a close() on an fd will remove any pending
> > > > events from the queues that they are on which correspond to that fd.
> > > 
> > > the application of a close event.  What can I say, "the fd formerly known
> > > as X" is now gone?  It would be incorrect to say that "fd X was closed",
> > > since X no longer refers to anything, and the application may have reused
> > > that fd for another file.
> > 
> > Which is precisely why you need to know where in the chain of events this
> > happened. Otherwise if I see
> > 
> >         'read on fd 5'
> >         'read on fd 5'
> > 
> > How do I know which read is for which fd in the multithreaded case
> 
> That can't happen, can it?  Let's say the following happens:
>    close(5)
>    accept() = 5
>    call kevent() and rebind fd 5
> The 'close(5)' would remove the old fd 5 events.  Therefore,
> any fd 5 events you see returned from kevent are for the new fd 5.
> 
> (I suspect it helps that kevent() is both the only way to
> bind events and the only way to pick them up; makes it harder
> for one thread to sneak a new fd into the event list without
> the thread calling kevent() noticing.)

Yes, that's how it does and should work.  Noticing the close()
should be done via thread communication/IPC not stuck into
kqueue.

-- 
-Alfred Perlstein - [bright@wintelcom.net|alfred@freebsd.org]
"I have the heart of a child; I keep it in a jar on my desk."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
