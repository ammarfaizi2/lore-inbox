Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317945AbSHKIxc>; Sun, 11 Aug 2002 04:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318047AbSHKIxc>; Sun, 11 Aug 2002 04:53:32 -0400
Received: from codepoet.org ([166.70.99.138]:22493 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S317945AbSHKIxb>;
	Sun, 11 Aug 2002 04:53:31 -0400
Date: Sun, 11 Aug 2002 02:57:17 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre1
Message-ID: <20020811085717.GA17738@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0208051938380.6811-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208051938380.6811-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Aug 05, 2002 at 07:40:56PM -0300, Marcelo Tosatti wrote:
> 
> So here goes -pre1, with a big -ac and x86-64 merges, plus other smaller
> stuff.
[------------snip------------]
> <alan@irongate.swansea.linux.org.uk> (02/08/05 1.629)
> 	[PATCH] PATCH: Add EFI partition support

Needs this to compile....

--- linux/include/asm-ia64/efi.h.orig	Sun Aug 11 01:41:10 2002
+++ linux/include/asm-ia64/efi.h	Sun Aug 11 01:43:38 2002
@@ -166,6 +166,9 @@
  *  EFI Configuration Table and GUID definitions
  */
 
+#define NULL_GUID    \
+    ((efi_guid_t) { 0x00000000, 0x0000, 0x0000, { 0x00, 0x00, 0x0, 0x00, 0x00, 0x00, 0x00, 0x00 }})
+
 #define MPS_TABLE_GUID    \
     ((efi_guid_t) { 0xeb9d2d2f, 0x2d88, 0x11d3, { 0x9a, 0x16, 0x0, 0x90, 0x27, 0x3f, 0xc1, 0x4d }})
 

> <rusty@rustcorp.com.au> (02/08/02 1.582.2.91)
> 	[PATCH] namespace.c - compiler warning

This patch is wrong....

--- linux/fs/namespace.c.orig	Sun Aug 11 01:50:52 2002
+++ linux/fs/namespace.c	Sun Aug 11 01:51:04 2002
@@ -29,8 +29,6 @@
 static int hash_mask, hash_bits;
 static kmem_cache_t *mnt_cache; 
 
-extern void init_rootfs(void);
-
 static inline unsigned long hash(struct vfsmount *mnt, struct dentry *dentry)
 {
 	unsigned long tmp = ((unsigned long) mnt / L1_CACHE_BYTES);
--- linux/include/linux/namespace.h.orig	Sat Aug  3 17:14:31 2002
+++ linux/include/linux/namespace.h	Sat Aug  3 18:46:43 2002
@@ -38,5 +38,6 @@
 	atomic_inc(&namespace->count);
 }
 
+int __init init_rootfs(void);
 #endif
 #endif


 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
