Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264847AbTE1TVO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 15:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264846AbTE1TVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 15:21:14 -0400
Received: from verdi.et.tudelft.nl ([130.161.38.158]:63873 "EHLO
	verdi.et.tudelft.nl") by vger.kernel.org with ESMTP id S264844AbTE1TVM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 15:21:12 -0400
Message-Id: <200305281934.h4SJYHtX015646@verdi.et.tudelft.nl>
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
X-Exmh-Isig-CompType: repl
X-Exmh-Isig-Folder: inbox
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org, robn@verdi.et.tudelft.nl
Subject: Re: 2.4 bug: fifo-write causes diskwrites to read-only fs ! 
In-Reply-To: Your message of "Wed, 28 May 2003 15:17:38 EDT."
             <Pine.LNX.4.53.0305281508140.13318@chaos> 
Mime-Version: 1.0
Content-Type: text/plain
Date: Wed, 28 May 2003 21:34:17 +0200
From: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 28 May 2003, Rob van Nieuwkerk wrote:
> 
> >
> > I wrote:
> > > It turns out that Linux is updating inode timestamps of fifos (named
> > > pipes) that are written to while residing on a read-only filesystem.
> > > It is not only updating in-ram info, but it will issue *physical*
> > > writes to the read-only fs on the disk !
> > 	.
> > 	.
> > 	.
> > > Sysinfo:
> > > --------
> > > - various 2.4 kernels including RH-2.4.20-13.9,
> > >   but also straight 2.4(ac) ones.
> > > - CompactFlash (= IDE disk)
> > > - Geode GX1 CPU (i586 compatible)
> >
> > Forgot to mention: I use an ext2 fs, but maybe it's a generic,
> > fs-independant problem.
> >
> > 	greetings,
> > 	Rob van Nieuwkerk
> 
> How does it 'know' it's a R/O file-system? Have you mounted it
> R/O, mounted it noatime, or just taken whatever you get when
> you boot from a ramdisk?

Hi Richard,

The kernel has the "ro" commandline-parameter.
There is no remount after the system boots.
"touch /bla" gives a read-only fs error.

> FYI, I created a FIFO with mkfifo, remounted the file-system
> R/O, executed `cat` with it's input coming from the FIFO, and
> then waited for a few minutes. I then wrote to the FIFO.
> The atime did not change with 2.4.20.

Just did the same here (on my workstation).  And the times *did* change ..
More precisely: the "modification" & "change" were updated, the "access"
time remained unchanged.

RH9, kernel-2.4.20-13.9

	greetings,
	Rob van Nieuwkerk
