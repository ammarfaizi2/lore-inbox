Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318044AbSGLWjs>; Fri, 12 Jul 2002 18:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318050AbSGLWjE>; Fri, 12 Jul 2002 18:39:04 -0400
Received: from holomorphy.com ([66.224.33.161]:37791 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318047AbSGLWiU>;
	Fri, 12 Jul 2002 18:38:20 -0400
Date: Fri, 12 Jul 2002 15:40:09 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@kernel.org, akpm@zip.com.au
Subject: NUMA-Q breakage 6/7 lack of bio splitting workaround
Message-ID: <20020712224009.GD25360@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, axboe@kernel.org, akpm@zip.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NUMA-Q's have qlogicisp adapters for their boot bays. Until the block
I/O issue is resolved, they can't boot. I've bugged you about this
before, but for completeness' sake, here it is.


Workaround (due to akpm) below.


Cheers,
Bill


===== fs/mpage.c 1.10 vs edited =====
--- 1.10/fs/mpage.c	Thu Jul  4 09:17:30 2002
+++ edited/fs/mpage.c	Fri Jul 12 01:03:03 2002
@@ -24,7 +24,7 @@
  * The largest-sized BIO which this code will assemble, in bytes.  Set this
  * to PAGE_CACHE_SIZE if your drivers are broken.
  */
-#define MPAGE_BIO_MAX_SIZE BIO_MAX_SIZE
+#define MPAGE_BIO_MAX_SIZE PAGE_CACHE_SIZE
 
 /*
  * I/O completion handler for multipage BIOs.
