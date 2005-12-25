Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbVLYSIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbVLYSIA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 13:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbVLYSIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 13:08:00 -0500
Received: from mylar.outflux.net ([69.93.193.226]:35737 "EHLO
	mylar.outflux.net") by vger.kernel.org with ESMTP id S1750874AbVLYSIA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 13:08:00 -0500
Date: Sun, 25 Dec 2005 10:07:58 -0800
From: Kees Cook <kees@outflux.net>
To: trivial@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] lib: zlib_inflate "r.base" uninitialized compile warnings
Message-ID: <20051225180758.GM18040@outflux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-HELO: ghostship.outflux.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminates compile-time warnings from "r" being uninitialized.

Signed-of-by: Kees Cook <kees@outflux.net>

---

--- linux-2.6.15-rc7/lib/zlib_inflate/inftrees.c.orig	2005-12-25 09:51:01.000000000 -0800
+++ linux-2.6.15-rc7/lib/zlib_inflate/inftrees.c	2005-12-25 09:46:06.000000000 -0800
@@ -196,6 +196,7 @@ static int huft_build(
   u[0] = NULL;                  /* just to keep compilers happy */
   q = NULL;                     /* ditto */
   z = 0;                        /* ditto */
+  r.word.pad = r.base = 0;      /* ditto */
 
   /* go through the bit lengths (k already is bits in shortest code) */
   for (; k <= g; k++)


-- 
Kees Cook                                            @outflux.net
