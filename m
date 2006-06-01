Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964946AbWFAKDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbWFAKDO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 06:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWFAKC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 06:02:56 -0400
Received: from mail.suse.de ([195.135.220.2]:53647 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964908AbWFAKCr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 06:02:47 -0400
Message-Id: <20060601095125.773684000@hasse.suse.de>
User-Agent: quilt/0.44-16
Date: Thu, 01 Jun 2006 11:51:25 +0200
From: jblunck@suse.de
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, viro@zeniv.linux.org.uk,
       dgc@sgi.com, balbir@in.ibm.com
Subject: [patch 0/5] [PATCH,RFC] vfs: per-superblock unused dentries list (2nd version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is an updated version of my original patches.

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

Comments?
       Jan

