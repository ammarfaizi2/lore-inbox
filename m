Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267994AbUIGNCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267994AbUIGNCd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 09:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268024AbUIGNCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 09:02:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13261 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267994AbUIGNCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 09:02:31 -0400
Date: Tue, 7 Sep 2004 14:02:13 +0100
Message-Id: <200409071302.i87D2Dus030892@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Mingming Cao <cmm@us.ibm.com>, pbadari@us.ibm.com,
       Ram Pai <linuxram@us.ibm.com>
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 0/6]: Cleanup and rbtree for ext3 reservations in 2.6.9-rc1-mm4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patches in the following set contain several cleanups for ext3
reservations, fix a reproducable SMP race, and turn the per-superblock
linear list of reservations into an rbtree for better scaling.

Apart from performance and the SMP race, there should be no
behavioural change in this set of patches, except for one item: the
EXT3_IOC_GETRSVSZ and EXT3_IOC_SETRSVSZ ioctl numbers are currently
using a non-standard character in their names, 'r' instead of 'f' (the
latter is used for all existing ext2/3 ioctls), so I thought it would
be best to rename that sooner rather than later if we're going to do
it at all.

These changes have been in rawhide for a couple of weeks, and have
been undergoing testing both within Red Hat and at IBM.  
