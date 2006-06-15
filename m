Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030226AbWFOL3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbWFOL3N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 07:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030234AbWFOL3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 07:29:13 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:60349 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030226AbWFOL3N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 07:29:13 -0400
Date: Thu, 15 Jun 2006 12:29:12 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: [PATCH] sparc build breakage
Message-ID: <20060615112912.GN27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rd_prompt et.al. depend on CONFIG_BLK_DEV_RAM, not CONFIG_BLK_INITRD; now
that those are independent, setup.c blows with INITRD on and BLK_DEV_RAM
off.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/sparc/kernel/setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

863c76a6fe8c5d4e42b03a255f67739402e25c0d
diff --git a/arch/sparc/kernel/setup.c b/arch/sparc/kernel/setup.c
index 3509e43..0da5789 100644
--- a/arch/sparc/kernel/setup.c
+++ b/arch/sparc/kernel/setup.c
@@ -331,7 +331,7 @@ #endif
 	if (!root_flags)
 		root_mountflags &= ~MS_RDONLY;
 	ROOT_DEV = old_decode_dev(root_dev);
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_BLK_DEV_RAM
 	rd_image_start = ram_flags & RAMDISK_IMAGE_START_MASK;
 	rd_prompt = ((ram_flags & RAMDISK_PROMPT_FLAG) != 0);
 	rd_doload = ((ram_flags & RAMDISK_LOAD_FLAG) != 0);	
-- 
1.3.GIT

