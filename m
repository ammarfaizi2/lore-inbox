Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965024AbWEYGeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbWEYGeU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 02:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbWEYGeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 02:34:20 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:16031 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S965020AbWEYGeT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 02:34:19 -0400
Date: Thu, 25 May 2006 11:59:57 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: David Chinner <dgc@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH]  Per-superblock unused dentry LRU lists V2
Message-ID: <20060525062957.GC25185@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20060524110001.GU1331387@melbourne.sgi.com> <20060525040604.GB25185@in.ibm.com> <20060525061553.GC8069029@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060525061553.GC8069029@melbourne.sgi.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> FWIW, this create/unlink load has been triggering reliable "Busy
> inodes after unmount" errors that I've slowly been tracking down.
> After I fixed the last problem in XFS late last week, I've
> been getting a failure that i think is the unmount/prune_dcache
> races that you and Neil have recently fixed.

Good, we were not able to reproduce the problem and test the fix.
I guess we have a more reliable way of testing the fix now.

> 
> Basically, I'm seeing a transient elevated reference  count on
> the root inode of the XFS filesystem during the final put_super()
> in generic_shutdown_super(). If I trigger a BUG_ON() when that
> elevated reference count is detected, byt he time al the cpus
> are stopped and I'm in kdb, the reference count on the root inode
> is only 1. The next thing I was going to track was where the dentry
> for the root inodes was.

The dput() would happen eventually, in this case after the umount.
kprobes might be more reliable for extracting information in this
case. 

> 
> I'll know if this really is the same race soon, as the create/unlink
> test would trip it under an hour.....
> 
> Cheers,
> 
> Dave.

	Cheers,
	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
