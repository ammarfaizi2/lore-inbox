Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261944AbVCQQ0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbVCQQ0W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 11:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbVCQQ0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 11:26:21 -0500
Received: from citi.umich.edu ([141.211.133.111]:62557 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S261944AbVCQQ0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 11:26:11 -0500
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: [PATCH 0/2] RFC: exporting per-superblock statistics to user space
Message-Id: <20050317162611.6F2741BB95@citi.umich.edu>
Date: Thu, 17 Mar 2005 11:26:11 -0500 (EST)
From: cel@citi.umich.edu (Chuck Lever)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 We still have a need to provide "iostat" like statistics for NFS
 clients.  Following are a couple of patches, against 2.6.11.3, which
 prototype an approach for providing this kind of data to user programs.

 I'd like some comment on the approach.

 01-mountstats.patch adds a new file called /proc/self/mountstats and a
 new file system method called show_stats.  this just replicates
 /proc/mounts and the show_options hook.

 02-nfs-iostat.patch teachs the NFS client to use the new show_stats
 hook as a demonstration.

 Note that this approach addresses previously voiced concerns about
 exporting per-superblock stats to user space.

 1. Processes can't see stats for file systems mounted outside their
    namespace.

 2. Reading the stats file is serialized with mount and unmount
    operations.

 3. The approach doesn't use /sys or kobjects.

 4. There are no lifetime issues tied to file systems loaded as a
    module.

