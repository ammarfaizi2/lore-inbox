Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbTEQSId (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 14:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbTEQSId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 14:08:33 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:25992 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261710AbTEQSIc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 14:08:32 -0400
Subject: Re: Race between vmtruncate and mapped areas?
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, dmccr@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org,
       linux-mm@kvack.org, mika.penttila@kolumbus.fi
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OF9AB7161F.A333DD8B-ON88256D29.0064AB5F-88256D29.0064AD44@us.ibm.com>
From: Paul McKenney <Paul.McKenney@us.ibm.com>
Date: Sat, 17 May 2003 11:19:39 -0700
X-MIMETrack: Serialize by Router on D03NM116/03/M/IBM(Release 6.0.1 [IBM]|May 6, 2003) at
 05/17/2003 12:21:08
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





> On Thu, May 15, 2003 at 02:20:00AM -0700, Andrew Morton wrote:
> > Andrea Arcangeli <andrea@suse.de> wrote:
> > >
> > > and it's still racy
> >
> > damn, and it just booted ;)
> >
> > I'm just a little bit concerned over the ever-expanding inode.  Do you
> > think the dual sequence numbers can be replaced by a single generation
> > counter?
>
> yes, I wrote it as a single counter first, but was unreadable and it had
> more branches, so I added the other sequence number to make it cleaner.
> I don't mind another 4 bytes, that cacheline should be hot anyways.
>
> > I do think that we should push the revalidate operation over into the
vm_ops.
> > That'll require an extra arg to ->nopage, but it has a spare one anyway
(!).
>
> not sure why you need a callback, the lowlevel if needed can serialize
> using the same locking in the address space that vmtruncate uses. I
> would wait a real case need before adding a callback.

FYI, we verified that the revalidate callback could also do the same
job that the proposed nopagedone callback does -- permitting filesystems
that provide their on vm_operations_struct to avoid the race between
page faults and invalidating a page from a mapped file.

                                    Thanx, Paul

