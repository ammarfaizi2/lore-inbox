Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbVACRac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVACRac (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 12:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVACR3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 12:29:39 -0500
Received: from holomorphy.com ([207.189.100.168]:37020 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261533AbVACR2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 12:28:41 -0500
Date: Mon, 3 Jan 2005 09:28:39 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [3/8] kill gen_init_cpio.c printk() of size_t warning
Message-ID: <20050103172839.GE29332@holomorphy.com>
References: <20050103172013.GA29332@holomorphy.com> <20050103172303.GB29332@holomorphy.com> <20050103172615.GD29332@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103172615.GD29332@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The rest of gen_init_cpio.c seems to cast the result of strlen() to
handle this situation, so this patch follows suit while killing off
size_t -related printk() warnings.

Signed-off-by: William Irwin <wli@holomorphy.com>

Index: mm1-2.6.10/usr/gen_init_cpio.c
===================================================================
--- mm1-2.6.10.orig/usr/gen_init_cpio.c	2005-01-03 06:45:53.000000000 -0800
+++ mm1-2.6.10/usr/gen_init_cpio.c	2005-01-03 08:11:18.000000000 -0800
@@ -86,7 +86,7 @@
 		0,			/* minor */
 		0,			/* rmajor */
 		0,			/* rminor */
-		(unsigned)strlen(name) + 1, /* namesize */
+		(unsigned)strlen(name)+1, /* namesize */
 		0);			/* chksum */
 	push_hdr(s);
 	push_rest(name);
@@ -112,7 +112,7 @@
 		(long) gid,		/* gid */
 		1,			/* nlink */
 		(long) mtime,		/* mtime */
-		strlen(target) + 1,	/* filesize */
+		(unsigned)strlen(target)+1, /* filesize */
 		3,			/* major */
 		1,			/* minor */
 		0,			/* rmajor */
