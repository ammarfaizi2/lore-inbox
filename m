Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292829AbSCDTzk>; Mon, 4 Mar 2002 14:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292805AbSCDTzb>; Mon, 4 Mar 2002 14:55:31 -0500
Received: from dsl-213-023-043-195.arcor-ip.net ([213.23.43.195]:35735 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S292817AbSCDTz0>;
	Mon, 4 Mar 2002 14:55:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Chris Mason <mason@suse.com>, "Stephen C. Tweedie" <sct@redhat.com>,
        James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Date: Mon, 4 Mar 2002 20:51:09 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <phillips@bonn-fries.net> <20020304170434.B1444@redhat.com> <1201480000.1015262195@tiny>
In-Reply-To: <1201480000.1015262195@tiny>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16hyUH-0000fT-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 4, 2002 06:16 pm, Chris Mason wrote:
> On Monday, March 04, 2002 05:04:34 PM +0000 "Stephen C. Tweedie" <sct@redhat.com> wrote:
> 
> > Basically, as far as journal writes are concerned, you just want
> > things sequential for performance, so serialisation isn't a problem
> > (and it typically happens anyway).  After the journal write, the
> > eventual proper writeback of the dirty data to disk has no internal
> > ordering requirement at all --- it just needs to start strictly after
> > the commit, and end before the journal records get reused.  Beyond
> > that, the write order for the writeback data is irrelevant.
> 
> writeback data order is important, mostly because of where the data blocks
> are in relation to the log.  If you've got bdflush unloading data blocks
> to the disk, and another process doing a commit, the drive's queue
> might look like this:
> 
> data1, data2, data3, commit1, data4, data5 etc.
> 
> If commit1 is an ordered tag, the drive is required to flush 
> data1, data2 and data3, then write the commit, then seek back
> for data4 and data5.
> 
> If commit1 is not an ordered tag, the drive can write all the
> data blocks, then seek back to get the commit.

We can have more than one queue per device I think.  Then we can have reads
unaffected by write barriers, for example.  It never makes sense for a the 
write barrier to wait on a read.

-- 
Daniel
