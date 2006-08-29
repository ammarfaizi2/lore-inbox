Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965120AbWH2Qts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965120AbWH2Qts (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 12:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965159AbWH2QtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 12:49:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23453 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965114AbWH2QqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 12:46:04 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 03/19] BLOCK: Stop fallback_migrate_page() from using page_has_buffers() [try #5]
Date: Tue, 29 Aug 2006 17:45:55 +0100
To: axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060829164555.15723.57722.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060829164549.15723.15017.stgit@warthog.cambridge.redhat.com>
References: <20060829164549.15723.15017.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Stop fallback_migrate_page() from using page_has_buffers() since that might not
be available.  Use PagePrivate() instead since that's more general.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 mm/migrate.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 3f1e0c2..0227163 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -525,7 +525,7 @@ static int fallback_migrate_page(struct 
 	 * Buffers may be managed in a filesystem specific way.
 	 * We must have no buffers or drop them.
 	 */
-	if (page_has_buffers(page) &&
+	if (PagePrivate(page) &&
 	    !try_to_release_page(page, GFP_KERNEL))
 		return -EAGAIN;
 
