Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbVKMRvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbVKMRvI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 12:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbVKMRvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 12:51:08 -0500
Received: from pat.uio.no ([129.240.130.16]:37005 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751360AbVKMRvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 12:51:07 -0500
Subject: [GIT] Fix memory leak in lease code
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sun, 13 Nov 2005 12:50:54 -0500
Message-Id: <1131904255.8871.14.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.88, required 12,
	autolearn=disabled, AWL 1.93, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus

Please pull from the repository at

    git://git.linux-nfs.org/pub/linux/nfs-2.6.git

This will change the following files, through the appended changesets.

Cheers,
  Trond

---
 fs/locks.c |    1 -
 fs/locks.c |    2 +-
 2 files changed, 1 insertions(+), 2 deletions(-)

commit f3a9388e4ebea57583272007311fffa26ebbb305
Author: Chris Wright <chrisw@osdl.org>
Date:   Fri Nov 11 17:20:14 2005 -0800

    [PATCH] VFS: local denial-of-service with file leases

     Remove time_out_leases() printk that's easily triggered by users.

     Signed-off-by: Chris Wright <chrisw@osdl.org>
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit dc15ae14e97ee9d5ed740cbb0b94996076d8b37e
Author: J. Bruce Fields <bfields@fieldses.org>
Date:   Thu Nov 10 19:08:00 2005 -0500

    [PATCH] VFS: Fix memory leak with file leases

     The patch
     http://linux.bkbits.net:8080/linux-2.6/diffs/fs/locks.c@1.70??nav=index.htm     introduced a pretty nasty memory leak in the lease code. When freeing
     the lease, the code in locks_delete_lock() will correctly clean up
     the fasync queue, but when we return to fcntl_setlease(), the freed
     fasync entry will be reinstated.

     This patch ensures that we skip the call to fasync_helper() when we're
     freeing up the lease.

     Signed-off-by: J. Bruce Fields <bfields@fieldses.org>
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>


