Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265520AbSJXQGL>; Thu, 24 Oct 2002 12:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265521AbSJXQGL>; Thu, 24 Oct 2002 12:06:11 -0400
Received: from packet.digeo.com ([12.110.80.53]:52871 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265520AbSJXQGK>;
	Thu, 24 Oct 2002 12:06:10 -0400
Message-ID: <3DB81BE0.8EDDF728@digeo.com>
Date: Thu, 24 Oct 2002 09:12:16 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, chrisl@vmware.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: writepage return value check in vmscan.c
References: <20021024082505.GB1471@vmware.com> <3DB7B11B.9E552CFF@digeo.com> <1035450906.8675.4.camel@irongate.swansea.linux.org.uk> <20021024114455.GG3354@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Oct 2002 16:12:17.0177 (UTC) FILETIME=[1F554890:01C27B78]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Thu, Oct 24, 2002 at 10:15:06AM +0100, Alan Cox wrote:
> > On Thu, 2002-10-24 at 09:36, Andrew Morton wrote:
> > > A few fixes have been discussed.  One way would be to allocate
> > > the space for the page when it is first faulted into reality and
> > > deliver SIGBUS if backing store for it could not be allocated.
> >
> > You still have to handle the situation where the page goes walkies and
> > you get ENOSPC or any other ERANDOMSUPRISE from things like NFS. SIGBUS
> > appears the right thing to do.
> 
> I would tend to agree SIGBUS could be the right thing to do since the
> other (current) option is silent data corruption.
> 

Or at least remember the data loss within the mapping for a subsequent
msync/fsync operation.

We'd need a similar thing for detecting write I/O errors too.

	write(fd, data);
	sleep(60);
	fsync(fd);	-> doesn't report write errors.

But that's all filed under "bug fixes" and can be done after you-know-when.
