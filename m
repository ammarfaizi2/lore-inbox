Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274509AbRJJDfz>; Tue, 9 Oct 2001 23:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274513AbRJJDfr>; Tue, 9 Oct 2001 23:35:47 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:18941 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S274509AbRJJDfa>; Tue, 9 Oct 2001 23:35:30 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Tue, 9 Oct 2001 21:35:26 -0600
To: Xuan Baldauf <xuan--lkml@baldauf.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dynamic swap prioritizing
Message-ID: <20011009213526.J6348@turbolinux.com>
Mail-Followup-To: Xuan Baldauf <xuan--lkml@baldauf.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3BC373A8.CD94917B@baldauf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BC373A8.CD94917B@baldauf.org>
User-Agent: Mutt/1.3.22i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 10, 2001  00:01 +0200, Xuan Baldauf wrote:
> I have a linux box with 3 harddisks of different
> characteristics (size, seek time, throughput), each capable
> of holding a swap partition. Sometimes, one harddisk is
> driven heavily (e.g. database application), sometimes, the
> other harddisk is busy.

Daniel Phillips was working on something which may be useful in
this regard.  Basically, he was trying to determine how "busy" a
disk was, so that if there are dirty pages to be written on an
"idle" disk they would be written immediately.  The theory is
that if you wait longer, the disk may be busy with other I/O and
you have "wasted" the resource of disk bandwidth doing nothing.

Similarly, if you knew how busy each disk with a swap partition
was, you could swap to the most idle disk (assuming equal speed)
or at least take this into account if the speeds are different.

If this is to be generally useful, it would be good to find things
like max sequential read speed, max sequential write speed, and max
seek time (at least).  Estimates for max sequential read speed and
seek time could be found at boot time for each disk relatively
easily, but write speed may have to be found only at runtime (or
it could all be fed in to the kernel from user space from benchmarks
run previously).

Once we had data like that, it would be relatively easy to keep
track of the queue depth for each device to determine "business"
and estimated time to an empty queue and make intelligent disk
I/O scheduling decisions (e.g. which MD RAID 1 disk to read from,
which disk to swap to, guaranteed I/O rate for XFS, etc).

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

