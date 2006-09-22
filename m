Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWIVLLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWIVLLv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 07:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbWIVLLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 07:11:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59541 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932294AbWIVLLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 07:11:50 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 2/2] AFS: Manage AFS modularity vs FS-Cache modularity
Date: Fri, 22 Sep 2006 12:11:40 +0100
To: akpm@osdl.org, evil@g-house.de
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060922111140.16615.46012.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060922111137.16615.7794.stgit@warthog.cambridge.redhat.com>
References: <20060922111137.16615.7794.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manage AFS modularity vs FS-Cache modularity such that AFS doesn't have the
option to use the cache if AFS is built in and FS-Cache is a module.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 77cc578..25d2019 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -1952,7 +1952,8 @@ # for fs/nls/Config.in
 
 config AFS_FSCACHE
 	bool "Provide AFS client caching support"
-	depends on AFS_FS && FSCACHE && EXPERIMENTAL
+	depends on EXPERIMENTAL
+	depends on AFS_FS=m && FSCACHE || AFS_FS=y && FSCACHE=y
 	help
 	  Say Y here if you want AFS data to be cached locally on through the
 	  generic filesystem cache manager
