Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266469AbUA2WkT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 17:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266471AbUA2WkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 17:40:19 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:53768 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S266469AbUA2WkL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 17:40:11 -0500
Date: Thu, 29 Jan 2004 23:52:40 +0100
To: venom@sns.it
Cc: Christoph Hellwig <hch@infradead.org>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       Florian Huber <florian.huber@mnet-online.de>,
       JFS Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Jfs-discussion] md raid + jfs + jfs_fsck
Message-ID: <20040129225240.GA3118@hh.idb.hist.no>
References: <20040127205324.A19913@infradead.org> <Pine.LNX.4.43.0401281021030.31225-100000@cibs9.sns.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.43.0401281021030.31225-100000@cibs9.sns.it>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 10:24:14AM +0100, venom@sns.it wrote:
> 
> 
> On Tue, 27 Jan 2004, Christoph Hellwig wrote:
> >
> > Yes, it does.  But JFS should get the right size from the gendisk anyway.
> > Or did you create the raid with the filesystem already existant?  While that
> > appears to work for a non-full ext2/ext3 filesystem it's not something you
> > should do because it makes the filesystem internal bookkeeping wrong and
> > you'll run into trouble with any filesystem sooner or later.
> >
> In most situation to create a new FS on a RAID1 MD is not an option.
> It happens that you have to mirror a partition, maybe alarge one, and it
> already had a filesystem on top of it. Then what should you do?
> backup, mirror and then restore? Sometimes it is not possible this too.
> Then you accept to deal with the possible problems...
> 
If you need to mirror it - then you have an empty mirror disk ready, right?
Create a degraded array on the mirror disk, then make a fs there. Then
copy everything over from the original partition.  After this, change
the original partition to raid and add it to the other array. (It will
then be updated from the copy). 


This approach works with all filesystems, including those that
cannot be resized.  Data is copied twice instead of once, but
teh copying step will defragment files and you have the option
of changing filesystem or take advantage of sparse files if
you so wish.

Helge Hafting
