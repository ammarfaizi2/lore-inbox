Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317742AbSIJRXJ>; Tue, 10 Sep 2002 13:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317859AbSIJRXJ>; Tue, 10 Sep 2002 13:23:09 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:30193 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317742AbSIJRXH>;
	Tue, 10 Sep 2002 13:23:07 -0400
Subject: Re: [RFC] Multi-path IO in 2.5/2.6 ? [OFF TOPIC]
To: Christoph Hellwig <hch@infradead.org>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, lmb@suse.de
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFC567F6B3.F9CC93E2-ON85256C30.005CADEB@pok.ibm.com>
From: "Ben Rafanello" <benr@us.ibm.com>
Date: Tue, 10 Sep 2002 12:27:03 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11  |July 29, 2002) at
 09/10/2002 01:27:05 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 2002-09-10 at 11:33, Christoph Hellwig wrote:
>>       Support at least 1024 disks
>>       Support at least 1024 volumes
>>       Support at least 32 partitions per disk
>
>At least those criterias aren't archived.

EVMS has no design limit on the number of disks
that it can support, and, the way it is coded,
the only limiting factor on the number of disks
it can support is the amount of memory available.
Any limits on the number of disks that EVMS can
use come from Linux itself, and, as such, are
beyond the control of the EVMS Team.  We are not
out to rewrite the kernel and the device drivers -
we are just trying to meet the requirements we
were given.

As for 1024 volumes, that limit is due to the
fact that EVMS has only 1 major number, as
discussed in the original post.  If EVMS were
allowed more major numbers, then this criteria
could be reached or exceeded.  However, we thought
it extremely unlikely that EVMS would be given
enough major numbers under 2.4x to reach this goal,
so we coded accordingly.  Should a miracle occur
and EVMS be given another three major numbers,
we could easily update our code to make use of
these extra major numbers and achieve 1023 volumes.

As for partitions, EVMS has no fixed limit on the
number of partitions per disk.  The limit for
partitions on a disk depends upon the size of the
disk and the disk partitioning scheme used.  I
currently run a stress test on EVMS where I create
405 partitions on a single SCSI disk.  These
partitions are then combined in various ways to
form volumes, which are then formatted and have
I/O tests performed on them.  All 405 partitions
are used.  Under EVMS, you could take any of
those partitions and turn it into a volume, which
makes it accessible. The only limit on EVMS is
the number of volumes it can create, and this is
due to EVMS having only 1 major number under 2.4x.
So not only did we meet this requirement, we greatly
exceeded this requirement.

Regards,

Ben Rafanello
EVMS Team Lead
IBM Linux Technology Center
(512) 838-4762
benr@us.ibm.com


