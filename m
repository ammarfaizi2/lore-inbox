Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131474AbRAPPFq>; Tue, 16 Jan 2001 10:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131794AbRAPPFh>; Tue, 16 Jan 2001 10:05:37 -0500
Received: from host156.207-175-42.redhat.com ([207.175.42.156]:3596 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S131474AbRAPPFU>; Tue, 16 Jan 2001 10:05:20 -0500
Date: Tue, 16 Jan 2001 10:05:06 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: "David L. Parsley" <parsley@linuxjedi.org>
Cc: Felix von Leitner <leitner@convergence.de>, linux-kernel@vger.kernel.org,
        mingo@elte.hu
Subject: Re: Is sendfile all that sexy?
Message-ID: <20010116100506.C1120@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <20010116114018.A28720@convergence.de> <Pine.LNX.4.30.0101161338270.947-100000@elte.hu> <20010116134737.A29366@convergence.de> <20010116144849.B19949@pcep-jamie.cern.ch> <20010116152023.A32180@convergence.de> <3A646322.B76A1661@linuxjedi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A646322.B76A1661@linuxjedi.org>; from parsley@linuxjedi.org on Tue, Jan 16, 2001 at 10:05:06AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2001 at 10:05:06AM -0500, David L. Parsley wrote:
> Felix von Leitner wrote:
> > >   close (0);
> > >   close (1);
> > >   close (2);
> > >   open ("/dev/console", O_RDWR);
> > >   dup ();
> > >   dup ();
> > 
> > So it's not actually part of POSIX, it's just to get around fixing
> > legacy code? ;-)
> 
> This makes me wonder...
> 
> If the kernel only kept a queue of the three smallest unused fd's, and
> when the queue emptied handed out whatever it liked, how many things
> would break?  I suspect this would cover a lot of bases...

First it would break Unix98 and other standards:

The Single UNIX (R) Specification, Version 2
Copyright (c) 1997 The Open Group
...
 int open(const char *path, int oflag, ... );
...
The open() function will return a file descriptor for the named file that is the lowest file descriptor not currently
open for that process. The open file description is new, and therefore the file descriptor does not share it with any
other process in the system. The FD_CLOEXEC file descriptor flag associated with the new file descriptor will be
cleared.

	Jakub
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
