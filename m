Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315213AbSEUQvz>; Tue, 21 May 2002 12:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315227AbSEUQvy>; Tue, 21 May 2002 12:51:54 -0400
Received: from chaos.analogic.com ([204.178.40.224]:18048 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S315213AbSEUQvr>; Tue, 21 May 2002 12:51:47 -0400
Date: Tue, 21 May 2002 12:52:38 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Calin A. Culianu" <calin@ajvar.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Lazy Newbie Question
In-Reply-To: <Pine.LNX.4.33L2.0205211159110.14445-100000@rtlab.med.cornell.edu>
Message-ID: <Pine.LNX.3.95.1020521124137.1506A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2002, Calin A. Culianu wrote:

> On Tue, 21 May 2002, Richard B. Johnson wrote:
> 
> > On Tue, 21 May 2002, Calin A. Culianu wrote:
> >
> > >
> > > Whats the best way to do the equivalent of a stat() on a char * pathname
> > > from inside a kernel module?  Don't ask why I need to do this.. I know it
> > > sounds evil but I just need to do it...  Basically I need to find out the
> > > minor number of a device file.
> > >
> >
> > No. You never "need to do it". Some user-mode task, somewhere, installs
> > your module. That same task can open your device and via ioctl() tell
> > it anything it needs to know.
> 
> Well I need to do it.  I know all about ioctls and the like,
> thank-you-very-much.  I am writing code for COMEDI (have you heard of this
> driver suite?) which uses a kernel-space API for Realtime Linux
> (RTAI/RT-Linux).  So yes, I NEED TO DO IT!  :)
> 

Well the COMEDI I know about, written mostly by David Schleef, does
not require manipulating files in kernel space. This is a collection
of drivers, tools, and libraries for data acquisition.

> >
> > A "file" is something the kernel handles on behalf of a task. That
> > task has a context which, amongst other things, allows the kernel
> > to assign file-descriptors. The kernel is not a task. It does not
> > have a "context". Of course it can create one and it can steal one.
> > These are the two methods used inside the kernel to handle "files".
> >
> > And, unless the kernel task "thread" is permanent, it's a dirty
> > way of corrupting the kernel.
> >
> 
> Yes, as meantioned above.. my thread is permanent.  It is a periodic
> realtime priority thread.  However, the stuff that needs to determine
> device minors is going to run at non-realtime priority.
> 
> At any rate.. please don't chastise me.  I am asking a simple question and
> I wanted a straightforward answer.. I didn't expect to be flamed for it.
> 

My response was hardly a flame. Grep the driver sources for
kernel_thread().  There are important methods of terminating such
threads, if necessary, such as before removing a module. A kernel
thread can use files, but they have to execute sys_open(), etc.,
you do not attempt to use the user-mode trap (int 0x80).


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

