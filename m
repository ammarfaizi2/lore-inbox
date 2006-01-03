Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965059AbWACXkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbWACXkw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbWACX1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:27:40 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:60379 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964871AbWACX1g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:27:36 -0500
To: torvalds@osdl.org
Subject: [PATCH 14/41] m68k: broken constraints on mulu.l
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Message-Id: <E1EtvZ1-0003MS-IF@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 23:27:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1133436151 -0500

too permissive constraint on mulu.l - the first argument should not be
an a-register.  Fixed by replacing "g" with "dm"; with older gcc we got
lucky and it had never attempted mulu.l %a0, %d1:%d0.  These days it
does, with predictable objections from as(1).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/m68k/math-emu/multi_arith.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

2aded1337ba4e6c54e9783e447b075f15931734c
diff --git a/arch/m68k/math-emu/multi_arith.h b/arch/m68k/math-emu/multi_arith.h
index 02251e5..4ad0ca9 100644
--- a/arch/m68k/math-emu/multi_arith.h
+++ b/arch/m68k/math-emu/multi_arith.h
@@ -366,7 +366,7 @@ static inline void fp_submant(struct fp_
 
 #define fp_mul64(desth, destl, src1, src2) ({				\
 	asm ("mulu.l %2,%1:%0" : "=d" (destl), "=d" (desth)		\
-		: "g" (src1), "0" (src2));				\
+		: "dm" (src1), "0" (src2));				\
 })
 #define fp_div64(quot, rem, srch, srcl, div)				\
 	asm ("divu.l %2,%1:%0" : "=d" (quot), "=d" (rem)		\
-- 
0.99.9.GIT

