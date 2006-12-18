Return-Path: <linux-kernel-owner+w=401wt.eu-S1753664AbWLRJze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753664AbWLRJze (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 04:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753649AbWLRJze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 04:55:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46372 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753667AbWLRJzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 04:55:32 -0500
Subject: [GFS2] Fix Kconfig [2/2]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Patrick Caulfield <pcaulfie@redhat.com>,
       Chris Zubrzycki <chris@middle--earth.org>, Adrian Bunk <bunk@stusta.de>,
       Randy Dunlap <randy.dunlap@oracle.com>,
       Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>,
       Aleksandr Koltsoff <czr@iki.fi>
In-Reply-To: <1166435650.3752.1263.camel@quoit.chygwyn.com>
References: <1166435650.3752.1263.camel@quoit.chygwyn.com>
Content-Type: text/plain; charset=UTF-8
Organization: Red Hat (UK) Ltd
Date: Mon, 18 Dec 2006 09:57:29 +0000
Message-Id: <1166435849.3752.1266.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 1003f06953472ecc34f12d9867670f475a8c1af6 Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Tue, 12 Dec 2006 10:16:25 +0000
Subject: [PATCH] [GFS2] Fix Kconfig
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Here is a patch to fix up the Kconfig so that we don't land up with
problems when people disable the NET subsystem.  Thanks for all the hints and
suggestions that people have sent me regarding this.

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
Cc: Aleksandr Koltsoff <czr@iki.fi>
Cc: Toralf Förster <toralf.foerster@gmx.de>
Cc: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Adrian Bunk <bunk@stusta.de>
Cc: Chris Zubrzycki <chris@middle--earth.org>
Cc: Patrick Caulfield <pcaulfie@redhat.com>
---
 fs/gfs2/Kconfig |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/fs/gfs2/Kconfig b/fs/gfs2/Kconfig
index c0791cb..6a2ffa2 100644
--- a/fs/gfs2/Kconfig
+++ b/fs/gfs2/Kconfig
@@ -34,7 +34,9 @@ config GFS2_FS_LOCKING_NOLOCK
 
 config GFS2_FS_LOCKING_DLM
 	tristate "GFS2 DLM locking module"
-	depends on GFS2_FS
+	depends on GFS2_FS && NET && INET && (IPV6 || IPV6=n)
+	select IP_SCTP if DLM_SCTP
+	select CONFIGFS_FS
 	select DLM
 	help
 	Multiple node locking module for GFS2
-- 
1.4.1



