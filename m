Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289413AbSAOEvQ>; Mon, 14 Jan 2002 23:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289418AbSAOEvG>; Mon, 14 Jan 2002 23:51:06 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:60341 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S289413AbSAOEuw>;
	Mon, 14 Jan 2002 23:50:52 -0500
Date: Mon, 14 Jan 2002 23:50:50 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] cleanup file.h and INIT_TASK a bit
In-Reply-To: <20020114233512.M30639@redhat.com>
Message-ID: <Pine.GSO.4.21.0201142347380.2614-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Jan 2002, Benjamin LaHaise wrote:

> Resend.  Several people pointed out they like the cleanup, nobody complained.
> 
> On Sun, Jan 13, 2002 at 06:59:47PM -0500, Benjamin LaHaise wrote:
> > This patches does a couple of things: first off, it removes the sched.h 
> > include from file.h that was added recently, as we really don't need yet 
> > another include file chain mess.  To make this a bit more palatable, a 
> > few of the inlines are moved out of file.h and into fcntl.c, plus the 
> > files_struct is moved to file.h from sched.h.  Since this meant adding 
> > file.h to the various arch/*/kernel/init_task.c files, I took the time 
> > to move the INIT_* bits for initializing the init task out of sched.h 
> > and into init_task.h.  If this is okay, please apply the patch.  There 
> > are other cleanups to do if people are interested: the #define for init_task 
> > is currently duplicated in *all* asm-*/processor.h files to be exactly 
> > the same thing...  This is a way of testing the waters on include file 
> > cleanups.  Done properly, they shave ~10-15% off of the kernel compile 
> > time on my machine.
> > 
> > Oh, the file.h cleanup exposed a mess (bug): usb.c was duplicating code 
> > from daemonize().

Please, split it in two chunks - init_task.h stuff and everything else.
The former is obviously good thing, the latter may need more - I understand
why you do the #define tricks, but I'm less than sure that it's the best
way.

As for the USB...  There is a bunch of other places that should do
daemonize() - I'll dig the patch out and send it.

