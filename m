Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267551AbUHEFEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267551AbUHEFEW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 01:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267549AbUHEFDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 01:03:48 -0400
Received: from holomorphy.com ([207.189.100.168]:6849 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267551AbUHEFBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 01:01:46 -0400
Date: Wed, 4 Aug 2004 22:01:41 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [sparc32] [12/13] gcc-3.3 macro parenthesization fix for memcpy.S
Message-ID: <20040805050141.GD2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040805043957.GT2334@holomorphy.com> <20040805044130.GU2334@holomorphy.com> <20040805044427.GV2334@holomorphy.com> <20040805044627.GW2334@holomorphy.com> <20040805044736.GX2334@holomorphy.com> <20040805044839.GY2334@holomorphy.com> <20040805044950.GZ2334@holomorphy.com> <20040805045417.GA2334@holomorphy.com> <20040805045528.GB2334@holomorphy.com> <20040805045643.GC2334@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805045643.GC2334@holomorphy.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 09:56:43PM -0700, William Lee Irwin III wrote:
> SMP support is in need of a great deal of work to port it from 2.2 and
> 2.4. Add a dependency on BROKEN in the Kconfig to warn the unwary.

From: Art Haas <ahaas@airmail.net>

The 1.3->1.4 changes to the arch/sparc/lib/copy_user.S file added
parenthesis to a number of macros within that file. The BK changlog
associated with this change indicate the change was to make the
file work with gcc-3.3.

When looking at the changes made, I see that similar macros exist in
memcpy.S as well, so would a patch adding parens to that file be
worthwhile? Also, just what was the problem with gcc-3.3 that was
resolved by adding the parenthesis? Macro mis-expansion I'm guessing.

Signed-off-by: Art Haas <ahaas@airmail.net>
Signed-off-by: William Irwin <wli@holomorphy.com>


Index: mm2-2.6.8-rc2/arch/sparc/lib/memcpy.S
===================================================================
--- mm2-2.6.8-rc2.orig/arch/sparc/lib/memcpy.S
+++ mm2-2.6.8-rc2/arch/sparc/lib/memcpy.S
@@ -42,124 +42,124 @@
 #endif
 
 /* Both these macros have to start with exactly the same insn */
-#define MOVE_BIGCHUNK(src, dst, offset, t0, t1, t2, t3, t4, t5, t6, t7) 				\
-	ldd	[%src + offset + 0x00], %t0; 								\
-	ldd	[%src + offset + 0x08], %t2; 								\
-	ldd	[%src + offset + 0x10], %t4; 								\
-	ldd	[%src + offset + 0x18], %t6; 								\
-	st	%t0, [%dst + offset + 0x00]; 								\
-	st	%t1, [%dst + offset + 0x04]; 								\
-	st	%t2, [%dst + offset + 0x08]; 								\
-	st	%t3, [%dst + offset + 0x0c]; 								\
-	st	%t4, [%dst + offset + 0x10]; 								\
-	st	%t5, [%dst + offset + 0x14]; 								\
-	st	%t6, [%dst + offset + 0x18]; 								\
-	st	%t7, [%dst + offset + 0x1c];
-
-#define MOVE_BIGALIGNCHUNK(src, dst, offset, t0, t1, t2, t3, t4, t5, t6, t7) 				\
-	ldd	[%src + offset + 0x00], %t0; 								\
-	ldd	[%src + offset + 0x08], %t2; 								\
-	ldd	[%src + offset + 0x10], %t4; 								\
-	ldd	[%src + offset + 0x18], %t6; 								\
-	std	%t0, [%dst + offset + 0x00]; 								\
-	std	%t2, [%dst + offset + 0x08]; 								\
-	std	%t4, [%dst + offset + 0x10]; 								\
-	std	%t6, [%dst + offset + 0x18];
-
-#define MOVE_LASTCHUNK(src, dst, offset, t0, t1, t2, t3) 						\
-	ldd	[%src - offset - 0x10], %t0; 								\
-	ldd	[%src - offset - 0x08], %t2; 								\
-	st	%t0, [%dst - offset - 0x10]; 								\
-	st	%t1, [%dst - offset - 0x0c]; 								\
-	st	%t2, [%dst - offset - 0x08]; 								\
-	st	%t3, [%dst - offset - 0x04];
-
-#define MOVE_LASTALIGNCHUNK(src, dst, offset, t0, t1, t2, t3) 						\
-	ldd	[%src - offset - 0x10], %t0; 								\
-	ldd	[%src - offset - 0x08], %t2; 								\
-	std	%t0, [%dst - offset - 0x10]; 								\
-	std	%t2, [%dst - offset - 0x08];
-
-#define MOVE_SHORTCHUNK(src, dst, offset, t0, t1) 							\
-	ldub	[%src - offset - 0x02], %t0; 								\
-	ldub	[%src - offset - 0x01], %t1; 								\
-	stb	%t0, [%dst - offset - 0x02]; 								\
-	stb	%t1, [%dst - offset - 0x01];
+#define MOVE_BIGCHUNK(src, dst, offset, t0, t1, t2, t3, t4, t5, t6, t7) \
+	ldd	[%src + (offset) + 0x00], %t0; \
+	ldd	[%src + (offset) + 0x08], %t2; \
+	ldd	[%src + (offset) + 0x10], %t4; \
+	ldd	[%src + (offset) + 0x18], %t6; \
+	st	%t0, [%dst + (offset) + 0x00]; \
+	st	%t1, [%dst + (offset) + 0x04]; \
+	st	%t2, [%dst + (offset) + 0x08]; \
+	st	%t3, [%dst + (offset) + 0x0c]; \
+	st	%t4, [%dst + (offset) + 0x10]; \
+	st	%t5, [%dst + (offset) + 0x14]; \
+	st	%t6, [%dst + (offset) + 0x18]; \
+	st	%t7, [%dst + (offset) + 0x1c];
+
+#define MOVE_BIGALIGNCHUNK(src, dst, offset, t0, t1, t2, t3, t4, t5, t6, t7) \
+	ldd	[%src + (offset) + 0x00], %t0; \
+	ldd	[%src + (offset) + 0x08], %t2; \
+	ldd	[%src + (offset) + 0x10], %t4; \
+	ldd	[%src + (offset) + 0x18], %t6; \
+	std	%t0, [%dst + (offset) + 0x00]; \
+	std	%t2, [%dst + (offset) + 0x08]; \
+	std	%t4, [%dst + (offset) + 0x10]; \
+	std	%t6, [%dst + (offset) + 0x18];
+
+#define MOVE_LASTCHUNK(src, dst, offset, t0, t1, t2, t3) \
+	ldd	[%src - (offset) - 0x10], %t0; \
+	ldd	[%src - (offset) - 0x08], %t2; \
+	st	%t0, [%dst - (offset) - 0x10]; \
+	st	%t1, [%dst - (offset) - 0x0c]; \
+	st	%t2, [%dst - (offset) - 0x08]; \
+	st	%t3, [%dst - (offset) - 0x04];
+
+#define MOVE_LASTALIGNCHUNK(src, dst, offset, t0, t1, t2, t3) \
+	ldd	[%src - (offset) - 0x10], %t0; \
+	ldd	[%src - (offset) - 0x08], %t2; \
+	std	%t0, [%dst - (offset) - 0x10]; \
+	std	%t2, [%dst - (offset) - 0x08];
+
+#define MOVE_SHORTCHUNK(src, dst, offset, t0, t1) \
+	ldub	[%src - (offset) - 0x02], %t0; \
+	ldub	[%src - (offset) - 0x01], %t1; \
+	stb	%t0, [%dst - (offset) - 0x02]; \
+	stb	%t1, [%dst - (offset) - 0x01];
 
 /* Both these macros have to start with exactly the same insn */
-#define RMOVE_BIGCHUNK(src, dst, offset, t0, t1, t2, t3, t4, t5, t6, t7) 				\
-	ldd	[%src - offset - 0x20], %t0; 								\
-	ldd	[%src - offset - 0x18], %t2; 								\
-	ldd	[%src - offset - 0x10], %t4; 								\
-	ldd	[%src - offset - 0x08], %t6; 								\
-	st	%t0, [%dst - offset - 0x20]; 								\
-	st	%t1, [%dst - offset - 0x1c]; 								\
-	st	%t2, [%dst - offset - 0x18]; 								\
-	st	%t3, [%dst - offset - 0x14]; 								\
-	st	%t4, [%dst - offset - 0x10]; 								\
-	st	%t5, [%dst - offset - 0x0c]; 								\
-	st	%t6, [%dst - offset - 0x08]; 								\
-	st	%t7, [%dst - offset - 0x04];
-
-#define RMOVE_BIGALIGNCHUNK(src, dst, offset, t0, t1, t2, t3, t4, t5, t6, t7) 				\
-	ldd	[%src - offset - 0x20], %t0; 								\
-	ldd	[%src - offset - 0x18], %t2; 								\
-	ldd	[%src - offset - 0x10], %t4; 								\
-	ldd	[%src - offset - 0x08], %t6; 								\
-	std	%t0, [%dst - offset - 0x20]; 								\
-	std	%t2, [%dst - offset - 0x18]; 								\
-	std	%t4, [%dst - offset - 0x10]; 								\
-	std	%t6, [%dst - offset - 0x08];
-
-#define RMOVE_LASTCHUNK(src, dst, offset, t0, t1, t2, t3) 						\
-	ldd	[%src + offset + 0x00], %t0; 								\
-	ldd	[%src + offset + 0x08], %t2; 								\
-	st	%t0, [%dst + offset + 0x00]; 								\
-	st	%t1, [%dst + offset + 0x04]; 								\
-	st	%t2, [%dst + offset + 0x08]; 								\
-	st	%t3, [%dst + offset + 0x0c];
-
-#define RMOVE_SHORTCHUNK(src, dst, offset, t0, t1) 							\
-	ldub	[%src + offset + 0x00], %t0; 								\
-	ldub	[%src + offset + 0x01], %t1; 								\
-	stb	%t0, [%dst + offset + 0x00]; 								\
-	stb	%t1, [%dst + offset + 0x01];
-
-#define SMOVE_CHUNK(src, dst, offset, t0, t1, t2, t3, t4, t5, t6, prev, shil, shir, offset2) 		\
-	ldd	[%src + offset + 0x00], %t0; 								\
-	ldd	[%src + offset + 0x08], %t2; 								\
-	srl	%t0, shir, %t5; 									\
-	srl	%t1, shir, %t6; 									\
-	sll	%t0, shil, %t0; 									\
-	or	%t5, %prev, %t5; 									\
-	sll	%t1, shil, %prev; 									\
-	or	%t6, %t0, %t0; 										\
-	srl	%t2, shir, %t1; 									\
-	srl	%t3, shir, %t6; 									\
-	sll	%t2, shil, %t2; 									\
-	or	%t1, %prev, %t1; 									\
-	std	%t4, [%dst + offset + offset2 - 0x04]; 							\
-	std	%t0, [%dst + offset + offset2 + 0x04];							\
-	sll	%t3, shil, %prev; 									\
+#define RMOVE_BIGCHUNK(src, dst, offset, t0, t1, t2, t3, t4, t5, t6, t7) \
+	ldd	[%src - (offset) - 0x20], %t0; \
+	ldd	[%src - (offset) - 0x18], %t2; \
+	ldd	[%src - (offset) - 0x10], %t4; \
+	ldd	[%src - (offset) - 0x08], %t6; \
+	st	%t0, [%dst - (offset) - 0x20]; \
+	st	%t1, [%dst - (offset) - 0x1c]; \
+	st	%t2, [%dst - (offset) - 0x18]; \
+	st	%t3, [%dst - (offset) - 0x14]; \
+	st	%t4, [%dst - (offset) - 0x10]; \
+	st	%t5, [%dst - (offset) - 0x0c]; \
+	st	%t6, [%dst - (offset) - 0x08]; \
+	st	%t7, [%dst - (offset) - 0x04];
+
+#define RMOVE_BIGALIGNCHUNK(src, dst, offset, t0, t1, t2, t3, t4, t5, t6, t7) \
+	ldd	[%src - (offset) - 0x20], %t0; \
+	ldd	[%src - (offset) - 0x18], %t2; \
+	ldd	[%src - (offset) - 0x10], %t4; \
+	ldd	[%src - (offset) - 0x08], %t6; \
+	std	%t0, [%dst - (offset) - 0x20]; \
+	std	%t2, [%dst - (offset) - 0x18]; \
+	std	%t4, [%dst - (offset) - 0x10]; \
+	std	%t6, [%dst - (offset) - 0x08];
+
+#define RMOVE_LASTCHUNK(src, dst, offset, t0, t1, t2, t3) \
+	ldd	[%src + (offset) + 0x00], %t0; \
+	ldd	[%src + (offset) + 0x08], %t2; \
+	st	%t0, [%dst + (offset) + 0x00]; \
+	st	%t1, [%dst + (offset) + 0x04]; \
+	st	%t2, [%dst + (offset) + 0x08]; \
+	st	%t3, [%dst + (offset) + 0x0c];
+
+#define RMOVE_SHORTCHUNK(src, dst, offset, t0, t1) \
+	ldub	[%src + (offset) + 0x00], %t0; \
+	ldub	[%src + (offset) + 0x01], %t1; \
+	stb	%t0, [%dst + (offset) + 0x00]; \
+	stb	%t1, [%dst + (offset) + 0x01];
+
+#define SMOVE_CHUNK(src, dst, offset, t0, t1, t2, t3, t4, t5, t6, prev, shil, shir, offset2) \
+	ldd	[%src + (offset) + 0x00], %t0; \
+	ldd	[%src + (offset) + 0x08], %t2; \
+	srl	%t0, shir, %t5; \
+	srl	%t1, shir, %t6; \
+	sll	%t0, shil, %t0; \
+	or	%t5, %prev, %t5; \
+	sll	%t1, shil, %prev; \
+	or	%t6, %t0, %t0; \
+	srl	%t2, shir, %t1; \
+	srl	%t3, shir, %t6; \
+	sll	%t2, shil, %t2; \
+	or	%t1, %prev, %t1; \
+	std	%t4, [%dst + (offset) + (offset2) - 0x04]; \
+	std	%t0, [%dst + (offset) + (offset2) + 0x04]; \
+	sll	%t3, shil, %prev; \
 	or	%t6, %t2, %t4;
 
-#define SMOVE_ALIGNCHUNK(src, dst, offset, t0, t1, t2, t3, t4, t5, t6, prev, shil, shir, offset2) 	\
-	ldd	[%src + offset + 0x00], %t0; 								\
-	ldd	[%src + offset + 0x08], %t2; 								\
-	srl	%t0, shir, %t4; 									\
-	srl	%t1, shir, %t5; 									\
-	sll	%t0, shil, %t6; 									\
-	or	%t4, %prev, %t0; 									\
-	sll	%t1, shil, %prev; 									\
-	or	%t5, %t6, %t1; 										\
-	srl	%t2, shir, %t4; 									\
-	srl	%t3, shir, %t5; 									\
-	sll	%t2, shil, %t6; 									\
-	or	%t4, %prev, %t2; 									\
-	sll	%t3, shil, %prev; 									\
-	or	%t5, %t6, %t3;										\
-	std	%t0, [%dst + offset + offset2 + 0x00]; 							\
-	std	%t2, [%dst + offset + offset2 + 0x08];
+#define SMOVE_ALIGNCHUNK(src, dst, offset, t0, t1, t2, t3, t4, t5, t6, prev, shil, shir, offset2) \
+	ldd	[%src + (offset) + 0x00], %t0; \
+	ldd	[%src + (offset) + 0x08], %t2; \
+	srl	%t0, shir, %t4;	\
+	srl	%t1, shir, %t5;	\
+	sll	%t0, shil, %t6;	\
+	or	%t4, %prev, %t0; \
+	sll	%t1, shil, %prev; \
+	or	%t5, %t6, %t1; \
+	srl	%t2, shir, %t4;	\
+	srl	%t3, shir, %t5;	\
+	sll	%t2, shil, %t6; \
+	or	%t4, %prev, %t2; \
+	sll	%t3, shil, %prev; \
+	or	%t5, %t6, %t3; \
+	std	%t0, [%dst + (offset) + (offset2) + 0x00]; \
+	std	%t2, [%dst + (offset) + (offset2) + 0x08];
 
 	.text
 	.align	4
