Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262218AbUKQHB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbUKQHB6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 02:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbUKQHB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 02:01:57 -0500
Received: from danga.com ([66.150.15.140]:1759 "EHLO danga.com")
	by vger.kernel.org with ESMTP id S262218AbUKQHAm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 02:00:42 -0500
Date: Tue, 16 Nov 2004 23:00:41 -0800 (PST)
From: Brad Fitzpatrick <brad@danga.com>
X-X-Sender: bradfitz@danga.com
To: Nathan Scott <nathans@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Lisa Phillips <lisa@danga.com>, Mark Smith <marksmith@danga.com>,
       linux-xfs@oss.sgi.com
Subject: Re: 2.6.9: unkillable processes during heavy IO
In-Reply-To: <20041117045506.GA1802@frodo>
Message-ID: <Pine.LNX.4.58.0411162251170.7904@danga.com>
References: <Pine.LNX.4.58.0411141403040.22805@danga.com>
 <Pine.LNX.4.58.0411160549070.7904@danga.com> <20041116200156.2b2526e5.akpm@osdl.org>
 <20041117045506.GA1802@frodo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan,

On Wed, 17 Nov 2004, Nathan Scott wrote:

> > > On Sun, 14 Nov 2004, Brad Fitzpatrick wrote:
> > >
> > > > We have two database servers which freeze up during heavy IO load.  The
>
> Brad, could you send me details on how you've setup mysqld
> and how to generate a load similar to yours, so that I can
> reproduce the hang locally?

The MySQL people made a tool to reproduce MySQL-like load for the specific
purpose of not putting you through the database setup pain:

http://sysbench.sourceforge.net/

To simulate our InnoDB:

   -- use the tool to do "seqwr" and write out a 50GB file or so

   -- use the tool to make another file, about 30GB.

   -- use the tool to do "rndrw" to do random I/O over that 50 GB
      file, with the O_DIRECT flag on, with a bunch of threads doing
      16k reads/writes.

   -- use the tool to do random IO w/o O_DIRECT on the smaller file
      at the same time as the O_DIRECT run, also with a number of
      threads, doing smaller reads/writes.

This is happening on a machine with LVM2, as well as directly on
/dev/sdb2 (an IBM ServeRAID), so device-mapper shouldn't be an issue one
way or another.

The filesystem size is 270 GB on one machine (on /dev/sdb2) and 120 GB on
LVM2.


> > > > The hardware/software stack is:
> > > >
> > > >   - Dual Opteron 246, SMP kernel, w/ NUMA
> > > >   - 9 GB of memory (4GB in one zone, 5GB in the other)
> > > >   - MySQL, running mostly InnoDB, but some MyISAM
>
> ( I don't even know what those two things are, so you can
> probably guess at the level of assistance I'll need here. :)

Well, sysbench should help you find the problem.

Let me know if I can help more.  Thanks for looking into this.

- Brad


>
> thanks!
>
> --
> Nathan
>
>
