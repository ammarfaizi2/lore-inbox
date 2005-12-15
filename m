Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965189AbVLOJAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965189AbVLOJAj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965192AbVLOJAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:00:38 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:40581 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965189AbVLOJAh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:00:37 -0500
Date: Thu, 15 Dec 2005 09:00:37 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Subject: [PATCH 3/3] m68k: compile fix - updated vmlinux.lds to include LOCK_TEXT
Message-ID: <20051215090037.GV27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

... and that should get m68k to build with gcc 3.x in mainline.  gcc4
fixes are separate story.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
[rz: BTW, proposed variant of thread_info patchset is available for review,
see ftp.linux.org.uk/pub/people/viro/task_thread_info-mbox...  Doesn't
do any incompatible changes, mergable at leisure, reduces the remaining
renaming to ~50 lines - the only chunk that will have to go at 2.6.16...]

 arch/m68k/kernel/vmlinux-std.lds  |    1 +
 arch/m68k/kernel/vmlinux-sun3.lds |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

cc448b2f798627bc448ca14f3d6fb39f356bb117
diff --git a/arch/m68k/kernel/vmlinux-std.lds b/arch/m68k/kernel/vmlinux-std.lds
index e58654f..69d1d3d 100644
--- a/arch/m68k/kernel/vmlinux-std.lds
+++ b/arch/m68k/kernel/vmlinux-std.lds
@@ -13,6 +13,7 @@ SECTIONS
   .text : {
 	*(.text)
 	SCHED_TEXT
+	LOCK_TEXT
 	*(.fixup)
 	*(.gnu.warning)
 	} :text = 0x4e75
diff --git a/arch/m68k/kernel/vmlinux-sun3.lds b/arch/m68k/kernel/vmlinux-sun3.lds
index cc37e8d..f814e66 100644
--- a/arch/m68k/kernel/vmlinux-sun3.lds
+++ b/arch/m68k/kernel/vmlinux-sun3.lds
@@ -14,6 +14,7 @@ SECTIONS
 	*(.head)
 	*(.text)
 	SCHED_TEXT
+	LOCK_TEXT
 	*(.fixup)
 	*(.gnu.warning)
 	} :text = 0x4e75
-- 
0.99.9.GIT

