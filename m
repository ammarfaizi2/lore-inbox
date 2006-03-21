Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751566AbWCUQiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbWCUQiG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWCUQfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:35:44 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:30988 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932414AbWCUQVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:11 -0500
Cc: Mattia Dongili <malattia@linux.it>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 20/46] kbuild: fix a cscope bug (make cscope segfaults)
In-Reply-To: <1142958055125-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:55 +0100
Message-Id: <11429580551637-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Workaround a cscope bug where a trailing ':' in VPATH makes it segfault
and let it build the cross-reference succesfully.

VPATH=/home/mattia/devel/kernel/git/linux-2.6: cscope -b
[1]    17555 segmentation fault VPATH=/home/mattia/devel/kernel/git/linux-2.6: cscope -b

Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

0f558c333445a0181f33f9e6f996ce7cf008206a
diff --git a/Makefile b/Makefile
index a55a1e4..7a95f4f 100644
--- a/Makefile
+++ b/Makefile
@@ -137,7 +137,7 @@ objtree		:= $(CURDIR)
 src		:= $(srctree)
 obj		:= $(objtree)
 
-VPATH		:= $(srctree):$(KBUILD_EXTMOD)
+VPATH		:= $(srctree)$(if $(KBUILD_EXTMOD),:$(KBUILD_EXTMOD))
 
 export srctree objtree VPATH TOPDIR
 
-- 
1.0.GIT


