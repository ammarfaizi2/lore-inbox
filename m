Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbTDORZG (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 13:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbTDORZG 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 13:25:06 -0400
Received: from mail.gmx.net ([213.165.65.60]:14229 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261824AbTDORZF 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 13:25:05 -0400
Message-ID: <3E9C4330.1040906@gmx.net>
Date: Tue, 15 Apr 2003 19:36:48 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] [2.5] include/asm-generic/bitops.h {set,clear}_bit return
 void
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

{set,clear}_bit for all arches no longer return int, but void.
This patch renames the old generic implementations to
test_and_{set,clear}_bit and adds new-style {set,clear}_bit.

Regards,
Carl-Daniel

===== include/asm-generic/bitops.h 1.2 vs edited =====
--- 1.2/include/asm-generic/bitops.h	Fri May  3 02:08:35 2002
+++ edited/include/asm-generic/bitops.h	Thu Apr 10 09:12:41 2003
@@ -16,7 +16,31 @@
  * C language equivalents written by Theodore Ts'o, 9/26/92
  */

+extern __inline__ void set_bit(int nr,long * addr)
+{
+	int	mask;
+
+	addr += nr >> 5;
+	mask = 1 << (nr & 0x1f);
+	cli();
+	*addr |= mask;
+	sti();
+	return;
+}
+
+extern __inline__ void clear_bit(int nr, long * addr)
+{
+	int	mask;
+
+	addr += nr >> 5;
+	mask = 1 << (nr & 0x1f);
+	cli();
+	*addr &= ~mask;
+	sti();
+	return;
+}
+
-extern __inline__ int set_bit(int nr,long * addr)
+extern __inline__ int test_and_set_bit(int nr,long * addr)
 {
 	int	mask, retval;

@@ -29,7 +53,7 @@
 	return retval;
 }

-extern __inline__ int clear_bit(int nr, long * addr)
+extern __inline__ int test_and_clear_bit(int nr, long * addr)
 {
 	int	mask, retval;


-- 
Linux scales to much more than 64 CPUs!
See include/linux/smp.h:64
#define MSG_ALL_BUT_SELF 0x8000 /* Assume <32768 CPU's */

