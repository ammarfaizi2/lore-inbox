Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263989AbTDJHKY (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 03:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263990AbTDJHKY (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 03:10:24 -0400
Received: from imap.gmx.net ([213.165.64.20]:52102 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263989AbTDJHKW (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 03:10:22 -0400
Message-ID: <3E951B93.4040402@gmx.net>
Date: Thu, 10 Apr 2003 09:21:55 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] include/asm-generic/bitops.h {set,clear}_bit return void
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020401080904090305080703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020401080904090305080703
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linus,

{set,clear}_bit for all arches no longer return int, but void.
This patch adjusts the generic implementation accordingly.

Regards,
Carl-Daniel
-- 
Linux scales to much more than 64 CPUs!
See include/linux/smp.h:64
#define MSG_ALL_BUT_SELF        0x8000  /* Assume <32768 CPU's */

--------------020401080904090305080703
Content-Type: text/plain;
 name="linux_bitops.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux_bitops.diff"

===== include/asm-generic/bitops.h 1.2 vs edited =====
--- 1.2/include/asm-generic/bitops.h	Fri May  3 02:08:35 2002
+++ edited/include/asm-generic/bitops.h	Thu Apr 10 09:12:41 2003
@@ -16,7 +16,31 @@
  * C language equivalents written by Theodore Ts'o, 9/26/92
  */
 
-extern __inline__ int set_bit(int nr,long * addr)
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
 

--------------020401080904090305080703--

