Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266842AbSL3K3g>; Mon, 30 Dec 2002 05:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266844AbSL3K3f>; Mon, 30 Dec 2002 05:29:35 -0500
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:3543 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S266842AbSL3K3e>; Mon, 30 Dec 2002 05:29:34 -0500
Subject: [PATCH] 2.5 fix link with fbcon built-in
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, James Simmons <jsimmons@infradead.org>
Content-Type: text/plain
Organization: 
Message-Id: <1041244796.4330.14.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 30 Dec 2002 11:39:56 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In current bk 2.5, drivers/video/console/fonts.c exports an
init_module() symbol when built-in, which prevents the kernel from
linking. Here's a quick fix.

Ben.

--- 1.10/drivers/video/console/fonts.c  Fri Nov 29 18:37:57 2002
+++ edited/drivers/video/console/fonts.c        Mon Dec 30 11:36:42 2002
@@ -130,8 +130,10 @@
     return g;
 }
  
+#ifdef MODULE
 int init_module(void) { return 0; };
 void cleanup_module(void) {};
+#endif
  
 EXPORT_SYMBOL(fonts);
 EXPORT_SYMBOL(find_font);

-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

