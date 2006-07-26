Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbWGZS5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbWGZS5R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 14:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWGZS5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 14:57:17 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:57481 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750876AbWGZS5Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 14:57:16 -0400
Subject: [PATCH] [fs] Add lock annotation to grab_super
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain
Date: Wed, 26 Jul 2006 11:57:17 -0700
Message-Id: <1153940237.12517.62.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

grab_super gets called with sb_lock held, and releases it.  Add a lock
annotation to this function so that sparse can check callers for lock pairing,
and so that sparse will not complain about this function since it
intentionally uses the lock in this manner.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 fs/super.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 6d4e817..97a521c 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -198,7 +198,7 @@ EXPORT_SYMBOL(deactivate_super);
  *	success, 0 if we had failed (superblock contents was already dead or
  *	dying when grab_super() had been called).
  */
-static int grab_super(struct super_block *s)
+static int grab_super(struct super_block *s) __releases(sb_lock)
 {
 	s->s_count++;
 	spin_unlock(&sb_lock);


