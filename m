Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVCHLFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVCHLFp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 06:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbVCHLFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 06:05:44 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:9105 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261980AbVCHLEr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 06:04:47 -0500
Date: Tue, 8 Mar 2005 12:04:32 +0100
From: Jens Axboe <axboe@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Junfeng Yang <yjf@stanford.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devl@stanford.edu
Subject: Re: [CHECKER] crash after fsync causing serious FS corruptions (ext2, 2.6.11)
Message-ID: <20050308110432.GA13008@suse.de>
References: <Pine.GSO.4.44.0503070124460.29202-100000@elaine24.Stanford.EDU> <20050307104513.GD8071@suse.de> <20050308110200.GB23640@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050308110200.GB23640@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08 2005, Pavel Machek wrote:
> On Po 07-03-05 11:45:13, Jens Axboe wrote:
> > On Mon, Mar 07 2005, Junfeng Yang wrote:
> > > 
> > > Hi,
> > > 
> > > FiSC (our FS checker) issues a warning on ext2, complaining that crash
> > > after fsync causes file system to corrupt.  FS corrupts in two different
> > > ways: 1. file contains illegal blocks (such as block # -2) 2. one block
> > > owned by two different files.
> > > 
> > > I diagnosed the warning a little bit and it appears that this warning can
> > > be triggered by the following steps:
> > > 
> > > 1. a file is truncated, so several blocks are freed
> > > 2. a new file is created, and the blocks freed in step 1 are reused
> > > 3. fsync on the new file
> > > 4. crash and run fsck to recover.
> > > 
> > > fsync should guarantee that a specific file is persistent on disk.
> > > Presumably, operations on other files should not mess up with the file we
> > > just fsync (true ?)  However, I also understand that ext2 by default
> > > relies on e2fsck to provide file system consistency.  Do you guys consider
> > > the above warning as a bug or not?  Any clarification on this will be very
> > > helpful.
> > 
> > fsync on ext2 only really guarantees that the data has reached
> > the disk, what the disk does it outside the realm of the fs.
> > If the ide drive has write back caching enabled, the data just
> > might only be in cache. If the power is removed right after fsync
> > returns, the drive might not get a chance to actually commit the
> > write to platter.
> 
> I *think* they are using emulation for their checker, so drivers
> lying about writes should not be problem.

Yes, Junfeng informed me of that later.

-- 
Jens Axboe

