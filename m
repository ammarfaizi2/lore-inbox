Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266579AbUGPQgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266579AbUGPQgq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 12:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266583AbUGPQgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 12:36:46 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:65285 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S266579AbUGPQgm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 12:36:42 -0400
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       vojtech@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix NR_KEYS off-by-one error
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 17 Jul 2004 01:35:59 +0900
Message-ID: <87llhjlxjk.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KDGKBENT ioctl can use 256 entries (0-255), but it was defined as
key_map[NR_KEYS] (NR_KEYS == 255). The code seems also thinking it's 256.

	key_map[0] = U(K_ALLOCATED);
	for (j = 1; j < NR_KEYS; j++)
		key_map[j] = U(K_HOLE);

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 include/linux/keyboard.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN include/linux/keyboard.h~nr_keys-off-by-one include/linux/keyboard.h
--- linux-2.6.8-rc1/include/linux/keyboard.h~nr_keys-off-by-one	2004-07-16 06:20:10.000000000 +0900
+++ linux-2.6.8-rc1-hirofumi/include/linux/keyboard.h	2004-07-16 06:20:10.000000000 +0900
@@ -16,7 +16,7 @@
 
 #define NR_SHIFT	9
 
-#define NR_KEYS		255
+#define NR_KEYS		256
 #define MAX_NR_KEYMAPS	256
 /* This means 128Kb if all keymaps are allocated. Only the superuser
 	may increase the number of keymaps beyond MAX_NR_OF_USER_KEYMAPS. */
_
