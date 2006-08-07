Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbWHGVNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbWHGVNv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 17:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWHGVLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 17:11:46 -0400
Received: from xenotime.net ([66.160.160.81]:14555 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932376AbWHGVLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 17:11:12 -0400
Date: Mon, 7 Aug 2006 14:04:03 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, torvalds <torvalds@osdl.org>, ralf@linux-mips.org
Subject: [PATCH 6/9] Replace ARCH_HAS_SOCKET_TYPES with
 CONFIG_ARCH_SOCKET_TYPES
Message-Id: <20060807140403.b5b4c86e.rdunlap@xenotime.net>
In-Reply-To: <20060807120928.c0fe7045.rdunlap@xenotime.net>
References: <20060807120928.c0fe7045.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Replace ARCH_HAS_SOCKET_TYPES with CONFIG_ARCH_SOCKET_TYPES.
Move it from header files to Kconfig space.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 arch/mips/Kconfig         |    3 +++
 include/asm-mips/socket.h |    5 ++---
 include/linux/net.h       |    4 ++--
 3 files changed, 7 insertions(+), 5 deletions(-)

--- linux-2618-rc4-arch.orig/include/asm-mips/socket.h
+++ linux-2618-rc4-arch/include/asm-mips/socket.h
@@ -77,7 +77,8 @@ To add: #define SO_REUSEPORT 0x0200	/* A
  *
  * Please notice that for binary compat reasons MIPS has to
  * override the enum sock_type in include/linux/net.h, so
- * we define ARCH_HAS_SOCKET_TYPES here.
+ * include/linux/net.h checks for ifdef CONFIG_ARCH_SOCKET_TYPES
+ * to see if these are already defined.
  *
  * @SOCK_DGRAM - datagram (conn.less) socket
  * @SOCK_STREAM - stream (connection) socket
@@ -99,8 +100,6 @@ enum sock_type {
 
 #define SOCK_MAX (SOCK_PACKET + 1)
 
-#define ARCH_HAS_SOCKET_TYPES 1
-
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_SOCKET_H */
--- linux-2618-rc4-arch.orig/include/linux/net.h
+++ linux-2618-rc4-arch/include/linux/net.h
@@ -63,7 +63,7 @@ typedef enum {
 #define SOCK_PASSCRED		3
 #define SOCK_PASSSEC		4
 
-#ifndef ARCH_HAS_SOCKET_TYPES
+#ifndef CONFIG_ARCH_SOCKET_TYPES
 /**
  * enum sock_type - Socket types
  * @SOCK_STREAM: stream (connection) socket
@@ -91,7 +91,7 @@ enum sock_type {
 
 #define SOCK_MAX (SOCK_PACKET + 1)
 
-#endif /* ARCH_HAS_SOCKET_TYPES */
+#endif /* CONFIG_ARCH_SOCKET_TYPES */
 
 /**
  *  struct socket - general BSD socket
--- linux-2618-rc4-arch.orig/arch/mips/Kconfig
+++ linux-2618-rc4-arch/arch/mips/Kconfig
@@ -915,6 +915,9 @@ config MIPS_NILE4
 config MIPS_DISABLE_OBSOLETE_IDE
 	bool
 
+config ARCH_SOCKET_TYPES
+	def_bool y
+
 #
 # Endianess selection.  Suffiently obscure so many users don't know what to
 # answer,so we try hard to limit the available choices.  Also the use of a


---
