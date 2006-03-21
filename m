Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030308AbWCUQdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030308AbWCUQdd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030313AbWCUQa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:30:26 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:29708 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030305AbWCUQVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:13 -0500
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 33/46] kbuild: fix make dir/file.xx when asm symlink is missing
In-Reply-To: <11429580562919-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:56 +0100
Message-Id: <1142958056929-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added a dependency so we do full preparation before trying to build single
file targets. This fixes a case where Andrew Morton did:
	make kernel/sched.o
        rm include/asm
	make kernel/sched.o     -> splat

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Makefile |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

f6ecebd6592ea70e9450ec70efb24220dd961ebc
diff --git a/Makefile b/Makefile
index ce2bfbd..12c8d71 100644
--- a/Makefile
+++ b/Makefile
@@ -1289,17 +1289,17 @@ kernelversion:
 # ---------------------------------------------------------------------------
 # The directory part is taken from first prerequisite, so this
 # works even with external modules
-%.s: %.c scripts FORCE
+%.s: %.c prepare scripts FORCE
 	$(Q)$(MAKE) $(build)=$(dir $<) $(dir $<)$(notdir $@)
-%.i: %.c scripts FORCE
+%.i: %.c prepare scripts FORCE
 	$(Q)$(MAKE) $(build)=$(dir $<) $(dir $<)$(notdir $@)
-%.o: %.c scripts FORCE
+%.o: %.c prepare scripts FORCE
 	$(Q)$(MAKE) $(build)=$(dir $<) $(dir $<)$(notdir $@)
-%.lst: %.c scripts FORCE
+%.lst: %.c prepare scripts FORCE
 	$(Q)$(MAKE) $(build)=$(dir $<) $(dir $<)$(notdir $@)
-%.s: %.S scripts FORCE
+%.s: %.S prepare scripts FORCE
 	$(Q)$(MAKE) $(build)=$(dir $<) $(dir $<)$(notdir $@)
-%.o: %.S scripts FORCE
+%.o: %.S prepare scripts FORCE
 	$(Q)$(MAKE) $(build)=$(dir $<) $(dir $<)$(notdir $@)
 
 # For external modules we shall include any directory of the target,
-- 
1.0.GIT


