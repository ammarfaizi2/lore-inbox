Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317215AbSFRBkx>; Mon, 17 Jun 2002 21:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317230AbSFRBkw>; Mon, 17 Jun 2002 21:40:52 -0400
Received: from twinlark.arctic.org ([208.44.199.239]:13000 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S317214AbSFRBkw>; Mon, 17 Jun 2002 21:40:52 -0400
Date: Mon, 17 Jun 2002 18:40:53 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Andrew Morton <akpm@zip.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: 3x slower file reading oddity
In-Reply-To: <3D0E807C.5D50C17E@zip.com.au>
Message-ID: <Pine.LNX.4.44.0206171755450.18507-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2002, Andrew Morton wrote:

> dean gaudet wrote:
> > what if you have a disk array with lots of spindles?  it seems at some
> > point that you need to give the array or some lower level driver a lot of
> > i/os to choose from so that it can get better parallelism out of the
> > hardware.
>
> mm.  For that particular test, you'd get nice speedups from striping
> the blockgroups across disks, so each `cat' is probably talking to
> a different disk.  I don't think I've seen anything like that proposed
> though.

heh, a 128MB stripe?  that'd be huge :)

> You could fork one `cat' per file ;)  (Not so silly, really.  But if
> you took this approach, you'd need "many" more threads than blockgroups).

i actually tried this first :)  the problem then becomes a fork()
bottleneck before you run into the disk bottlenecks.  iirc the numbers
were ~45s for the 1-file-per-cat (for any -Pn, n<=10), ~30s for
100-files-per-cat (-P1) and ~1m15s for 100-files-per-cat (-P2).

> hmm.  What else?  Physical readahead - read metadata into the block
> device's pagecache and flip pages from there into directories and
> files on-demand.  Fat chance of that happening.

one idea i had -- given that the server has a volume manager and you're
working from a snapshot volume anyhow (only sane way to do backups), it
might make a lot more sense to use userland ext2/3 libraries to read the
snapshot block device anyhow.  but this kind of makes me cringe :)

-dean




