Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbWARAeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWARAeb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbWARAeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:34:31 -0500
Received: from mx.pathscale.com ([64.160.42.68]:34770 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S964838AbWARAea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:34:30 -0500
Subject: [PATCH] Fix sparse parse error in lppaca.h
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Andrew Morton <akpm@osdl.org>, arnd@arndb.de, david@gibson.dropbear.id.au
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 17 Jan 2006 16:34:25 -0800
Message-Id: <1137544465.4757.13.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sparse can't parse a struct definition in include/asm-powerpc/lppaca.h,
even though gcc can accept it.  The form looks like this:

        struct __attribute__((whatever)) foo { };

An equivalent that both gcc and sparse can handle is

        struct foo { } __attribute__((whatever));

This is the only definition of this type in the tree, and fixing it is
easier than fixing sparse.

Signed-off-by: Bryan O'Sullivan <bos@serpentine.com>

diff -r 89be36ca2767 include/asm-powerpc/lppaca.h
--- a/include/asm-powerpc/lppaca.h	Wed Jan 18 04:00:05 2006 +0000
+++ b/include/asm-powerpc/lppaca.h	Tue Jan 17 16:27:27 2006 -0800
@@ -31,7 +31,7 @@
 
 /* The Hypervisor barfs if the lppaca crosses a page boundary.  A 1k
  * alignment is sufficient to prevent this */
-struct __attribute__((__aligned__(0x400))) lppaca {
+struct lppaca {
 //=============================================================================
 // CACHE_LINE_1 0x0000 - 0x007F Contains read-only data
 // NOTE: The xDynXyz fields are fields that will be dynamically changed by
@@ -129,7 +129,7 @@
 // CACHE_LINE_4-5 0x0100 - 0x01FF Contains PMC interrupt data
 //=============================================================================
 	u8	pmc_save_area[256];	// PMC interrupt Area           x00-xFF
-};
+} __attribute__((__aligned__(0x400)));
 
 extern struct lppaca lppaca[];
 



