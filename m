Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264865AbTE1Uj1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 16:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264866AbTE1UjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 16:39:23 -0400
Received: from verdi.et.tudelft.nl ([130.161.38.158]:1666 "EHLO
	verdi.et.tudelft.nl") by vger.kernel.org with ESMTP id S264865AbTE1UjT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 16:39:19 -0400
Message-Id: <200305282052.h4SKqUBw016537@verdi.et.tudelft.nl>
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
X-Exmh-Isig-CompType: repl
X-Exmh-Isig-Folder: inbox
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org, robn@verdi.et.tudelft.nl
Subject: Re: 2.4 bug: fifo-write causes diskwrites to read-only fs ! 
In-Reply-To: Your message of "Wed, 28 May 2003 16:22:47 EDT."
             <Pine.LNX.4.53.0305281612160.13968@chaos> 
Mime-Version: 1.0
Content-Type: text/plain
Date: Wed, 28 May 2003 22:52:30 +0200
From: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Richard,

> > > > > It turns out that Linux is updating inode timestamps of fifos (named
> > > > > pipes) that are written to while residing on a read-only filesystem.
> > > > > It is not only updating in-ram info, but it will issue *physical*
> > > > > writes to the read-only fs on the disk !

> > > FYI, I created a FIFO with mkfifo, remounted the file-system
> > > R/O, executed `cat` with it's input coming from the FIFO, and
> > > then waited for a few minutes. I then wrote to the FIFO.
> > > The atime did not change with 2.4.20.
> >
> > Just did the same here (on my workstation).  And the times *did* change ..
> > More precisely: the "modification" & "change" were updated, the "access"
> > time remained unchanged.
> >
> 
> Okay. I can now verify the problem. There are two problems as this

Yeah !, I'm no longer alone .. :-)
	.
	.
> As you can clearly see, access time (atime) is not changed.
> However, both ctime and mtime are both changed with every
> FIFO access. Since this FIFO is provably on a R/O file system,
> nothing should change.

Note that the fact that you see the times changing in the fs while it
is mounted doesn't imply a problem in itself: serial and tty device
nodes get their time-stamps updated too on a read-only fs when they
are written.  But these changes are in ram only: when you reboot you
get the old values back.

But with FIFOs the changes *do* get written out to the read-only fs !

Hmm, wonder what happens if you try it on a real read-only medium like
a CDR.  Maybe kernel errors/panic ..

> Now, somebody will probably claim that this is the correct
> POSIX defined behavior <sigh> so you might have to make some
> work-around like use a pipe or socket instead of the FIFO??

Seems very stupid to me if POSIX specifies this.
I don't have the POSIX spec, but maybe it specifies what "read-only"
is supposed to mean somewhere too ..

But let's wait & see .. :-)

	greetings,
	Rob van Nieuwkerk
