Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314469AbSE0Hta>; Mon, 27 May 2002 03:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314484AbSE0Ht3>; Mon, 27 May 2002 03:49:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61702 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314469AbSE0Ht3>;
	Mon, 27 May 2002 03:49:29 -0400
Message-ID: <3CF1E5CF.2B11258F@zip.com.au>
Date: Mon, 27 May 2002 00:52:47 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Rohland <cr@sap.com>
CC: zlatko.calusic@iskon.hr, linux-kernel@vger.kernel.org,
        Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.5.18 / ext3 / oracle trouble
In-Reply-To: <877klr2ank.fsf@atlas.iskon.hr> <d6vi836v.fsf@sap.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Rohland wrote:
> 
> Hi Zlatko,
> 
> On Sun, 26 May 2002, Zlatko Calusic wrote:
> > Hi!
> >
> > After lots of testing, I can say that 2.5.18 works great in all
> > three modes of ext3 for all but one purpose. Oracle database still
> > gets corrupted during insert load. More precisely, online redo log
> > gets corrupted, database panics and restore is in order.
> >
> > This leads me to thinking that there's something wrong with sysv
> > shared memory in 2.5.x. Although the problem could also be in
> > fsync() or swap_out() & co. paths, it's yet to be discovered.
> >
> > It could also be that journaled mode helps the trouble, and it could
> > be that some swapping makes it more certain, but none of these two
> > facts are proved for sure. Take it as an observation.
> >
> > Christoph, I don't know if you're still taking care of shmem in
> > 2.5.x, so take my apologies if you didn't want to see this email.
> >
> > Regards,
> > --
> > Zlatko
> 
> Unfortunately I do not have the time to work on shmem right now. Hugh
> Dickins is the right guy to contact nowadays.
> 

Most likely suspect here is the heavy fsync() load is triggering
some timing problem in ext3 - it'll be pushing the commits though
at high rate.

I'll teach fsx-linux (great test app, btw) about fsync() and see
how it stands up.  And if Zlatko can retest on ext2 that would be a
big help.

-
