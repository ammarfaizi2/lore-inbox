Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbWGYA2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWGYA2K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 20:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWGYA2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 20:28:10 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:34784 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932354AbWGYA2J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 20:28:09 -0400
Subject: [PATCH] [fs/mbcache.c] Add lock annotation for
	__mb_cache_entry_release_unlock
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>,
       Andreas Gruenbacher <a.gruenbacher@computer.org>
Content-Type: text/plain
Date: Mon, 24 Jul 2006 17:28:10 -0700
Message-Id: <1153787290.31581.37.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__mb_cache_entry_release_unlock releases mb_cache_spinlock, so annotate it
accordingly.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 fs/mbcache.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/fs/mbcache.c b/fs/mbcache.c
index e4fde1a..0ff7125 100644
--- a/fs/mbcache.c
+++ b/fs/mbcache.c
@@ -160,6 +160,7 @@ __mb_cache_entry_forget(struct mb_cache_
 
 static void
 __mb_cache_entry_release_unlock(struct mb_cache_entry *ce)
+	__releases(mb_cache_spinlock)
 {
 	/* Wake up all processes queuing for this cache entry. */
 	if (ce->e_queued)


