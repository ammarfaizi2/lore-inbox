Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936355AbWK3M3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936355AbWK3M3a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936351AbWK3M3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:29:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51853 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936353AbWK3MVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:21:36 -0500
Subject: [DLM] Fix DLM config [46/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Patrick Caulfield <pcaulfie@redhat.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:20:42 +0000
Message-Id: <1164889242.3752.397.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From b98c95af01c10827e3443157651eb469071391a3 Mon Sep 17 00:00:00 2001
From: Patrick Caulfield <pcaulfie@redhat.com>
Date: Wed, 15 Nov 2006 12:29:24 -0500
Subject: [PATCH] [DLM] Fix DLM config

The attached patch fixes the DLM config so that it selects the chosen network
transport. It should fix the bug where DLM can be left selected when NET gets
unselected. This incorporates all the comments received about this patch.

Cc: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>
Signed-Off-By: Patrick Caulfield <pcaulfie@redhat.com>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/dlm/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/fs/dlm/Kconfig b/fs/dlm/Kconfig
index c5985b8..b5654a2 100644
--- a/fs/dlm/Kconfig
+++ b/fs/dlm/Kconfig
@@ -1,10 +1,11 @@
 menu "Distributed Lock Manager"
-	depends on INET && IP_SCTP && EXPERIMENTAL
+	depends on EXPERIMENTAL && INET
 
 config DLM
 	tristate "Distributed Lock Manager (DLM)"
 	depends on IPV6 || IPV6=n
 	select CONFIGFS_FS
+	select IP_SCTP if DLM_SCTP
 	help
 	A general purpose distributed lock manager for kernel or userspace
 	applications.
-- 
1.4.1



