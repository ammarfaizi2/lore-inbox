Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbWFATrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbWFATrz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 15:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbWFATrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 15:47:55 -0400
Received: from mailhub.hp.com ([192.151.27.10]:6289 "EHLO mailhub.hp.com")
	by vger.kernel.org with ESMTP id S1030238AbWFATry (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 15:47:54 -0400
From: "Bob Picco" <bob.picco@hp.com>
Date: Thu, 1 Jun 2006 15:47:51 -0400
To: hpa@zytor.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, bob.picco@hp.com
Subject: [PATCH] klibc
Message-ID: <20060601194751.GD17809@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This change enabled me to boot on OpenPower 710. Otherwise klibc's statfs is 
built for 32 bit and not for 64 bit. The failure was in kinit when
calling run_init. run_init would attempt to validate ramfs and
failed calling statfs of "/".


Signed-off-by: Bob Picco <bob.picco@hp.com>

 usr/include/sys/vfs.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6.17-rc5-mm2/usr/include/sys/vfs.h
===================================================================
--- linux-2.6.17-rc5-mm2.orig/usr/include/sys/vfs.h	2006-06-01 14:51:11.000000000 -0400
+++ linux-2.6.17-rc5-mm2/usr/include/sys/vfs.h	2006-06-01 14:52:20.000000000 -0400
@@ -13,7 +13,8 @@
 /* struct statfs64 -- there seems to be two standards -
    one for 32 and one for 64 bits, and they're incompatible... */
 
-#if !defined(__x86_64__) && !defined(__ia64__) && !defined(__sparc_v9__)
+#if !defined(__x86_64__) && !defined(__ia64__) && !defined(__sparc_v9__) && \
+	!defined(__powerpc64__)
 
 struct statfs {
 	uint32_t f_type;

