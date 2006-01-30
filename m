Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbWA3RtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWA3RtW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 12:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWA3RtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 12:49:22 -0500
Received: from cantor2.suse.de ([195.135.220.15]:22694 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964846AbWA3RtV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 12:49:21 -0500
Date: Mon, 30 Jan 2006 18:49:19 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] record last user if malloc request is exact 4k
Message-ID: <20060130174919.GA7599@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a reason why a 4096 malloc is not recorded?
untested patch below.


allow SLAB_STORE_USER also with an exact 4k request.

Signed-off-by: Olaf Hering <olh@suse.de>

 mm/slab.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.16-rc1-olh/mm/slab.c
===================================================================
--- linux-2.6.16-rc1-olh.orig/mm/slab.c
+++ linux-2.6.16-rc1-olh/mm/slab.c
@@ -1637,7 +1637,7 @@ kmem_cache_create (const char *name, siz
 	 * above the next power of two: caches with object sizes just above a
 	 * power of two have a significant amount of internal fragmentation.
 	 */
-	if ((size < 4096
+	if ((size <= 4096
 	     || fls(size - 1) == fls(size - 1 + 3 * BYTES_PER_WORD)))
 		flags |= SLAB_RED_ZONE | SLAB_STORE_USER;
 	if (!(flags & SLAB_DESTROY_BY_RCU))

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
