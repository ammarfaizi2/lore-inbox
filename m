Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbVIKVsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbVIKVsM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 17:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbVIKVsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 17:48:12 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:46631 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S1750940AbVIKVsK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 17:48:10 -0400
Date: Sun, 11 Sep 2005 23:50:03 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] kbuild: fix silentoldconfig with make O=
Message-ID: <20050911215003.GC2177@mars.ravnborg.org>
References: <20050911214850.GA2177@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050911214850.GA2177@mars.ravnborg.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH 2/3] kbuild: fix silentoldconfig with make O=

Al Viro reported that sometimes silentoldconfig failed because
output directory was missing.
So create it unconditionally before executing conf

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

5011cdd01bedd66b314e330a638c97984c71b53d
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -491,6 +491,7 @@ include .config
 # If .config is newer than include/linux/autoconf.h, someone tinkered
 # with it and forgot to run make oldconfig
 include/linux/autoconf.h: .config
+	$(Q)mkdir -p include/linux
 	$(Q)$(MAKE) -f $(srctree)/Makefile silentoldconfig
 else
 # Dummy target needed, because used as prerequisite
