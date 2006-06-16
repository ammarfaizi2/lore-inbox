Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbWFPSnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWFPSnt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 14:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWFPSnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 14:43:49 -0400
Received: from cantor.suse.de ([195.135.220.2]:63872 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751370AbWFPSns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 14:43:48 -0400
Message-Id: <20060616104321.778718000@hasse.suse.de>
User-Agent: quilt/0.44-17
Date: Fri, 16 Jun 2006 12:43:21 +0200
From: jblunck@suse.de
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, viro@zeniv.linux.org.uk,
       dgc@sgi.com, balbir@in.ibm.com, neilb@suse.de
Subject: [PATCH 0/5] vfs: per-superblock unused dentries list (3rd version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is an updated version of my original patches. This time the
changes Andrew proposed are adressed. David can you test them wrt the
scan_count stuff?

This is an attempt to have per-superblock unused dentry lists. Since dentries
are lazy-removed from the unused list, one big list doesn't scale very good
wrt systems with a hugh dentry cache. The dcache shrinkers spend a long time
traversing the list under the dcache spinlock.

The patches introduce an additional list_head per superblock holding only the
dentries of the specific superblock. The next dentry can be found quickly so
the shrinkers don't need to hold the dcache lock for long.

One nice side-effect: the "busy inodes after unmount" race is fixed because
prune_dcache() is getting the s_umount lock before it starts working on the
superblock's dentries.

These patches are against torvalds/linux-2.6.git from today.

Comments?
      Jan


