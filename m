Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWFNBqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWFNBqz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 21:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWFNBqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 21:46:54 -0400
Received: from xenotime.net ([66.160.160.81]:39873 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932394AbWFNBqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 21:46:54 -0400
Date: Tue, 13 Jun 2006 18:49:39 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, Matt_Domsch@dell.com
Subject: [PATCH 3/3] kernel-doc for lib//crc*.c
Message-Id: <20060613184939.9ff70040.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Make kernel-doc corrections & additions to lib/crc*.c.
Add crc functions to kernel-api.tmpl in DocBook.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/DocBook/kernel-api.tmpl |    6 +++
 lib/crc-ccitt.c                       |    6 +--
 lib/crc16.c                           |   10 +++---
 lib/crc32.c                           |   54 +++++++++++++---------------------
 4 files changed, 36 insertions(+), 40 deletions(-)

--- linux-2617-rc6.orig/lib/crc16.c
+++ linux-2617-rc6/lib/crc16.c
@@ -47,12 +47,12 @@ u16 const crc16_table[256] = {
 EXPORT_SYMBOL(crc16_table);
 
 /**
- * Compute the CRC-16 for the data buffer
+ * crc16 - compute the CRC-16 for the data buffer
+ * @crc:	previous CRC value
+ * @buffer:	data pointer
+ * @len:	number of bytes in the buffer
  *
- * @param crc     previous CRC value
- * @param buffer  data pointer
- * @param len     number of bytes in the buffer
- * @return        the updated CRC value
+ * Returns the updated CRC value.
  */
 u16 crc16(u16 crc, u8 const *buffer, size_t len)
 {
--- linux-2617-rc6.orig/Documentation/DocBook/kernel-api.tmpl
+++ linux-2617-rc6/Documentation/DocBook/kernel-api.tmpl
@@ -129,6 +129,12 @@ X!Ilib/string.c
      <sect1><title>Command-line Parsing</title>
 !Elib/cmdline.c
      </sect1>
+
+     <sect1><title>CRC Functions</title>
+!Elib/crc16.c
+!Elib/crc32.c
+!Elib/crc-ccitt.c
+     </sect1>
   </chapter>
 
   <chapter id="mm">
--- linux-2617-rc6.orig/lib/crc32.c
+++ linux-2617-rc6/lib/crc32.c
@@ -42,20 +42,21 @@ MODULE_AUTHOR("Matt Domsch <Matt_Domsch@
 MODULE_DESCRIPTION("Ethernet CRC32 calculations");
 MODULE_LICENSE("GPL");
 
+/**
+ * crc32_le() - Calculate bitwise little-endian Ethernet AUTODIN II CRC32
+ * @crc: seed value for computation.  ~0 for Ethernet, sometimes 0 for
+ *	other uses, or the previous crc32 value if computing incrementally.
+ * @p: pointer to buffer over which CRC is run
+ * @len: length of buffer @p
+ */
+u32 __attribute_pure__ crc32_le(u32 crc, unsigned char const *p, size_t len);
+
 #if CRC_LE_BITS == 1
 /*
  * In fact, the table-based code will work in this case, but it can be
  * simplified by inlining the table in ?: form.
  */
 
-/**
- * crc32_le() - Calculate bitwise little-endian Ethernet AUTODIN II CRC32
- * @crc - seed value for computation.  ~0 for Ethernet, sometimes 0 for
- *        other uses, or the previous crc32 value if computing incrementally.
- * @p   - pointer to buffer over which CRC is run
- * @len - length of buffer @p
- * 
- */
 u32 __attribute_pure__ crc32_le(u32 crc, unsigned char const *p, size_t len)
 {
 	int i;
@@ -68,14 +69,6 @@ u32 __attribute_pure__ crc32_le(u32 crc,
 }
 #else				/* Table-based approach */
 
-/**
- * crc32_le() - Calculate bitwise little-endian Ethernet AUTODIN II CRC32
- * @crc - seed value for computation.  ~0 for Ethernet, sometimes 0 for
- *        other uses, or the previous crc32 value if computing incrementally.
- * @p   - pointer to buffer over which CRC is run
- * @len - length of buffer @p
- * 
- */
 u32 __attribute_pure__ crc32_le(u32 crc, unsigned char const *p, size_t len)
 {
 # if CRC_LE_BITS == 8
@@ -145,20 +138,21 @@ u32 __attribute_pure__ crc32_le(u32 crc,
 }
 #endif
 
+/**
+ * crc32_be() - Calculate bitwise big-endian Ethernet AUTODIN II CRC32
+ * @crc: seed value for computation.  ~0 for Ethernet, sometimes 0 for
+ *	other uses, or the previous crc32 value if computing incrementally.
+ * @p: pointer to buffer over which CRC is run
+ * @len: length of buffer @p
+ */
+u32 __attribute_pure__ crc32_be(u32 crc, unsigned char const *p, size_t len);
+
 #if CRC_BE_BITS == 1
 /*
  * In fact, the table-based code will work in this case, but it can be
  * simplified by inlining the table in ?: form.
  */
 
-/**
- * crc32_be() - Calculate bitwise big-endian Ethernet AUTODIN II CRC32
- * @crc - seed value for computation.  ~0 for Ethernet, sometimes 0 for
- *        other uses, or the previous crc32 value if computing incrementally.
- * @p   - pointer to buffer over which CRC is run
- * @len - length of buffer @p
- * 
- */
 u32 __attribute_pure__ crc32_be(u32 crc, unsigned char const *p, size_t len)
 {
 	int i;
@@ -173,14 +167,6 @@ u32 __attribute_pure__ crc32_be(u32 crc,
 }
 
 #else				/* Table-based approach */
-/**
- * crc32_be() - Calculate bitwise big-endian Ethernet AUTODIN II CRC32
- * @crc - seed value for computation.  ~0 for Ethernet, sometimes 0 for
- *        other uses, or the previous crc32 value if computing incrementally.
- * @p   - pointer to buffer over which CRC is run
- * @len - length of buffer @p
- * 
- */
 u32 __attribute_pure__ crc32_be(u32 crc, unsigned char const *p, size_t len)
 {
 # if CRC_BE_BITS == 8
@@ -249,6 +235,10 @@ u32 __attribute_pure__ crc32_be(u32 crc,
 }
 #endif
 
+/**
+ * bitreverse - reverse the order of bits in a u32 value
+ * @x: value to be bit-reversed
+ */
 u32 bitreverse(u32 x)
 {
 	x = (x >> 16) | (x << 16);
--- linux-2617-rc6.orig/lib/crc-ccitt.c
+++ linux-2617-rc6/lib/crc-ccitt.c
@@ -53,9 +53,9 @@ EXPORT_SYMBOL(crc_ccitt_table);
 
 /**
  *	crc_ccitt - recompute the CRC for the data buffer
- *	@crc - previous CRC value
- *	@buffer - data pointer
- *	@len - number of bytes in the buffer
+ *	@crc: previous CRC value
+ *	@buffer: data pointer
+ *	@len: number of bytes in the buffer
  */
 u16 crc_ccitt(u16 crc, u8 const *buffer, size_t len)
 {


---
