Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318770AbSHQXM2>; Sat, 17 Aug 2002 19:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318771AbSHQXM2>; Sat, 17 Aug 2002 19:12:28 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:56849
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318770AbSHQXM1>; Sat, 17 Aug 2002 19:12:27 -0400
Date: Sat, 17 Aug 2002 16:06:46 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE?  IDE-TNG driver
In-Reply-To: <Pine.LNX.4.44.0208172353330.3111-100000@sharra.ivimey.org>
Message-ID: <Pine.LNX.4.10.10208171557510.23171-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Aug 2002, Ruth Ivimey-Cook wrote:

> On Sat, 17 Aug 2002, Andre Hedrick wrote:
> >
> >ide_ioctl(fd, HDIO_SET_IDE_SCSI, bool)
> 
> Seems fine to me...
> 
> >Where bool does the subdriver switch.
> >Just that ioctl's are being blasted and people using are frowned upon.
> 
> ? so how is cdrecord (or whatever) supposed to do its stuff -- is it ioctl()  
> -> fcntl()? If so, I suppose that's ok, but the basic premise still exists,
> surely?
> 
> >This was a feature Alan Cox poked me for to try and move away from how
> >modules are basically an all or nothing grab-all.
> 
> I don't think modules are the answer to any of this:
>  a) some people want basically module-less kernels

This is designed to work regardless.

/dev/hdc == ide-cd builtin
insmod ide-scsi

ide_ioctl(fd, HDIO_SET_IDE_SCSI, bool)

converts /dev/hdc == ide-cd builtin to ide-scsi(add-in-module).

>  b) in some environments, you need to be able to select the IO mechanism 
>     without the ability to select the module to load.

See above, I think it solves the problem.
Once ide-scsi is added to the ide_module link list it is as good as
built-in.

> anyway...
> 
> <slightly confused by it all>

Me too, because I do not know the direction goal so I am doing the very
best I can.  What I really need is an active development team.

Before me:

Mark Lord, Gadi Oxman, Eric Anderson worked well.

ML ide-disk and ide.c global.
GO ide-floppy, ide-tape, ide-scsi
EA ide-cd

Anyways that was long before transport layer w/ all the hardware issues
began to dominate things.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

