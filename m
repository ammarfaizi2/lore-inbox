Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030449AbWCUQbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030449AbWCUQbF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030301AbWCUQap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:30:45 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:30476 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932439AbWCUQVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:12 -0500
Cc: Jan Beulich <jbeulich@novell.com>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 23/46] kbuild: version.h should depend on .kernelrelease
In-Reply-To: <11429580553825-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:55 +0100
Message-Id: <1142958055509-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rebuilding a previously built tree while using make's -j options from time to
time results in the version.h check running at the same time as the updating
of .kernelrelease, resulting in UTS_RELEASE remaining an empty string (and as
a side effect causing the entire kernel to be rebuilt).

Signed-Off-By: Jan Beulich <jbeulich@novell.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

c3f9da90b6e63c968070aa72057fe15356b3f7b5
diff --git a/Makefile b/Makefile
index 7a95f4f..ce2bfbd 100644
--- a/Makefile
+++ b/Makefile
@@ -852,7 +852,7 @@ define filechk_version.h
 	)
 endef
 
-include/linux/version.h: $(srctree)/Makefile .config FORCE
+include/linux/version.h: $(srctree)/Makefile .config .kernelrelease FORCE
 	$(call filechk,version.h)
 
 # ---------------------------------------------------------------------------
-- 
1.0.GIT


