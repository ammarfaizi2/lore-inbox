Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310521AbSCEHm4>; Tue, 5 Mar 2002 02:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310520AbSCEHmt>; Tue, 5 Mar 2002 02:42:49 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:11533 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S310517AbSCEHmb>;
	Tue, 5 Mar 2002 02:42:31 -0500
Date: Tue, 5 Mar 2002 08:42:21 +0100
From: Jens Axboe <axboe@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Chris Mason <mason@suse.com>, "Stephen C. Tweedie" <sct@redhat.com>,
        James Bottomley <James.Bottomley@steeleye.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Message-ID: <20020305074221.GC716@suse.de>
In-Reply-To: <phillips@bonn-fries.net> <20020304170434.B1444@redhat.com> <1201480000.1015262195@tiny> <E16hyUH-0000fT-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16hyUH-0000fT-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04 2002, Daniel Phillips wrote:
> > writeback data order is important, mostly because of where the data blocks
> > are in relation to the log.  If you've got bdflush unloading data blocks
> > to the disk, and another process doing a commit, the drive's queue
> > might look like this:
> > 
> > data1, data2, data3, commit1, data4, data5 etc.
> > 
> > If commit1 is an ordered tag, the drive is required to flush 
> > data1, data2 and data3, then write the commit, then seek back
> > for data4 and data5.
> > 
> > If commit1 is not an ordered tag, the drive can write all the
> > data blocks, then seek back to get the commit.
> 
> We can have more than one queue per device I think.  Then we can have reads
> unaffected by write barriers, for example.  It never makes sense for a the 
> write barrier to wait on a read.

No, there will always be at most one queue for a device. There might be
more than one device on a queue, though, so yes the implementation at
the block/queue level still leaves something to be desired.

-- 
Jens Axboe

