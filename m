Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbWIVLLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWIVLLx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 07:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWIVLLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 07:11:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59285 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932295AbWIVLLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 07:11:50 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 1/2] NFS: Manage NFS modularity vs FS-Cache modularity
Date: Fri, 22 Sep 2006 12:11:37 +0100
To: akpm@osdl.org, evil@g-house.de
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060922111137.16615.7794.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manage NFS modularity vs FS-Cache modularity such that NFS doesn't have the
option to use the cache if NFS is built in and FS-Cache is a module.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index afec7e1..77cc578 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -1507,7 +1507,8 @@ config NFS_V4
 
 config NFS_FSCACHE
 	bool "Provide NFS client caching support (EXPERIMENTAL)"
-	depends on NFS_FS && FSCACHE && EXPERIMENTAL
+	depends on EXPERIMENTAL
+	depends on NFS_FS=m && FSCACHE || NFS_FS=y && FSCACHE=y
 	help
 	  Say Y here if you want NFS data to be cached locally on disc through
 	  the general filesystem cache manager
