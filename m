Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbTIESQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 14:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263058AbTIESQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 14:16:57 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:25596 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S262680AbTIESQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 14:16:56 -0400
Date: Fri, 5 Sep 2003 12:15:22 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How can I force a read to hit the disk?
Message-ID: <20030905121522.B30448@schatzie.adilger.int>
Mail-Followup-To: Alan Stern <stern@rowland.harvard.edu>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0309051331230.678-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44L0.0309051331230.678-100000@ida.rowland.org>; from stern@rowland.harvard.edu on Fri, Sep 05, 2003 at 01:46:22PM -0400
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 05, 2003  13:46 -0400, Alan Stern wrote:
> My kernel module for Linux-2.6 needs to be able to verify that the media 
> on which a file resides actually is readable.  How can I do that?
> 
> It would certainly suffice to use the normal VFS read routines, if there
> was some way to force the system to actually read from the device rather
> than just returning data already in the cache.  So I guess it would be 
> enough to perform an fdatasync for the file and then invalidate the file's 
> cache entries.  How does one invalidate a file's cache entries?  Does 
> filemap_flush() perform both these operations for you?

If you open the file with O_DIRECT, it should read/write directly on the
disk, and it will also invalidate any existing cache for the read/written
area.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

