Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270811AbTG0PE4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 11:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270815AbTG0PE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 11:04:56 -0400
Received: from smtp02.web.de ([217.72.192.151]:62232 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S270811AbTG0PEz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 11:04:55 -0400
Date: Sun, 27 Jul 2003 17:21:50 +0200
From: =?ISO-8859-1?B?UmVu?= <l.s.r@web.de>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Inline vfat_strnicmp()
Message-Id: <20030727172150.15f8df7f.l.s.r@web.de>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the function vfat_strnicmp() has just one callsite. Inlining it
actually shrinks vfat.o slightly.

René



diff -u ./fs/vfat/namei.c~ ./fs/vfat/namei.c
--- ./fs/vfat/namei.c~	2003-07-27 16:41:36.000000000 +0200
+++ ./fs/vfat/namei.c	2003-07-27 17:12:12.000000000 +0200
@@ -103,7 +103,7 @@
 	return nc ? nc : c;
 }
 
-static int
+static inline int
 vfat_strnicmp(struct nls_table *t, const unsigned char *s1,
 					const unsigned char *s2, int len)
 {
