Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265471AbTIEStX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 14:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265520AbTIEStX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 14:49:23 -0400
Received: from ida.rowland.org ([192.131.102.52]:18692 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S265471AbTIEStV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 14:49:21 -0400
Date: Fri, 5 Sep 2003 14:49:15 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Andreas Dilger <adilger@clusterfs.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: How can I force a read to hit the disk?
In-Reply-To: <20030905121522.B30448@schatzie.adilger.int>
Message-ID: <Pine.LNX.4.44L0.0309051439560.678-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Sep 2003, Andreas Dilger wrote:

> On Sep 05, 2003  13:46 -0400, Alan Stern wrote:
> > My kernel module for Linux-2.6 needs to be able to verify that the media 
> > on which a file resides actually is readable.  How can I do that?
> > 
> > It would certainly suffice to use the normal VFS read routines, if there
> > was some way to force the system to actually read from the device rather
> > than just returning data already in the cache.  So I guess it would be 
> > enough to perform an fdatasync for the file and then invalidate the file's 
> > cache entries.  How does one invalidate a file's cache entries?  Does 
> > filemap_flush() perform both these operations for you?
> 
> If you open the file with O_DIRECT, it should read/write directly on the
> disk, and it will also invalidate any existing cache for the read/written
> area.

Unfortunately that's not a good solution for me.  The file has already 
been opened without O_DIRECT, and O_DIRECT wouldn't be appropriate because 
most of the time I do want I/O to go through the cache.  It's just on a 
few rare occasions that I need direct access to the disk.

Maybe simply opening a new struct file using O_DIRECT, for purposes of 
the verification, while keeping the old struct file around for other uses 
later, will work?  That would be awkward though -- and there's no 
guarantee that the original filename would still exist.  It would be a lot 
nicer to do everything using the original file reference.

Alan Stern

