Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318471AbSGSI0M>; Fri, 19 Jul 2002 04:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318472AbSGSI0M>; Fri, 19 Jul 2002 04:26:12 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:50442 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S318471AbSGSI0G>; Fri, 19 Jul 2002 04:26:06 -0400
Date: Fri, 19 Jul 2002 10:29:06 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020719102906.A5131@krusty.dt.e-technik.uni-dortmund.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020716124956.GK7955@tahoe.alcove-fr> <Pine.LNX.4.44.0207161107550.17919-100000@innerfire.net> <20020716153926.GR7955@tahoe.alcove-fr> <20020716194542.GD22053@merlin.emma.line.org> <20020716150422.A6254@q.mn.rr.com> <20020716161158.A461@shookay.newview.com> <20020716152231.B6254@q.mn.rr.com> <20020717114501.GB28284@merlin.emma.line.org> <20020717190259.GA31503@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020717190259.GA31503@clusterfs.com>; from adilger@clusterfs.com on Wed, Jul 17, 2002 at 01:02:59PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jul 2002, Andreas Dilger wrote:

> On Jul 17, 2002  13:45 +0200, Matthias Andree wrote:
> > On Tue, 16 Jul 2002, Shawn wrote:
> > > In this case, can you use a RAID mirror or something, then break it?
> > > 
> > > Also, there's the LVM snapshot at the block layer someone already
> > > mentioned, which when used with smaller partions is less overhead.
> > > (less FS delta)
> > 
> > All these "solutions" don't work out, I cannot remount R/O my partition,
> > and LVM low-level snapshots or breaking a RAID mirror simply won't work
> > out. I would have to remount r/o the partition to get a consistent image
> > in the first place, so the first step must fail already...
> 
> Have you been reading my emails at all?  LVM snapshots DO ensure that
> the snapshot filesystem is consistent for journaled filesystems.

What kernel version is necessary to achieve this on production kernels
(i. e. 2.4)?

Does "consistent" mean "fsck proof"?

Here's what I tried, on Linux-2.4.19-pre10-ac3 (IIRC) (ext3fs):

(from memory, history not available, different machine):
lvcreate --snapshot snap /dev/vg0/home
e2fsck -f /dev/vg0/snap
dump -0 ...

It reported zero dtime for one file and two bitmap differences.

Does "consistent" mean "consistent after you replay the log?" If so,
that's still a losing game, because I cannot fsck the snapshot (it's R/O
in the LVM case at least) to replay the journal -- and I don't assume
dump 0.4b29 (which I'm using) goes fishing in the journal, but did not
use the dump source code.

dump did not complain however, and given what e2fsck had to complain,
I'd happily force mount such a file system when just a deletion has not
completed.

-- 
Matthias Andree
