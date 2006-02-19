Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWBSVHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWBSVHf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 16:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWBSVHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 16:07:35 -0500
Received: from smtp1.pp.htv.fi ([213.243.153.37]:42469 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S932109AbWBSVHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 16:07:35 -0500
Date: Sun, 19 Feb 2006 23:07:33 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       zanussi@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] relay: Migrate from relayfs to a generic relay API.
Message-ID: <20060219210733.GA3682@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
	zanussi@us.ibm.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a small patch set for getting rid of relayfs, and moving the core of
its functionality to kernel/relay.c. The API is kept consistent for everything
but the relayfs-specific bits, meaning people will have to use other file
systems to implement relay channel buffers.

There's support for a sysfs relay attribute (resent with a signed-off-by
tag and cleaned up description), and it's also trivial to do via debugfs.

Patches are ordered by invasiveness, the first few start out relatively
harmless, with the later ones removing relayfs entirely. There's
definitely room for cleanup and improvement in the new relay.c, but one
thing at a time..

Tested with sysfs. Against current git.

To get an idea of the total amount of changes:

---

 fs/relayfs/Makefile        |    4 
 fs/relayfs/buffers.c       |  190 ---------
 fs/relayfs/buffers.h       |   12 
 fs/relayfs/inode.c         |  581 ----------------------------
 fs/relayfs/relay.c         |  482 -----------------------
 fs/relayfs/relay.h         |    9 
 include/linux/relayfs_fs.h |  290 --------------
 fs/Kconfig                 |   12 
 fs/Makefile                |    1 
 fs/sysfs/Makefile          |    3 
 fs/sysfs/dir.c             |   28 +
 fs/sysfs/inode.c           |    5 
 fs/sysfs/relay.c           |   72 +++
 include/linux/relay.h      |  281 +++++++++++++
 include/linux/relayfs_fs.h |    3 
 include/linux/sysfs.h      |   33 +
 init/Kconfig               |   11 
 kernel/Makefile            |    1 
 kernel/relay.c             |  923 ++++++++++++++++++++++++++++++++++++++++++++-
 19 files changed, 1349 insertions(+), 1592 deletions(-)
