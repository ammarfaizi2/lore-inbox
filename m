Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030251AbVINW1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbVINW1L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbVINW1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:27:11 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:60933 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S965070AbVINW1H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:27:07 -0400
Message-Id: <200509142156.j8ELuDAv012169@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 9/10] UML - return a real error code
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 14 Sep 2005 17:56:13 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

do_aio used to return -1 on error instead of errno.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: test/arch/um/os-Linux/aio.c
===================================================================
--- test.orig/arch/um/os-Linux/aio.c	2005-09-14 15:47:30.000000000 -0400
+++ test/arch/um/os-Linux/aio.c	2005-09-14 15:48:04.000000000 -0400
@@ -117,6 +117,7 @@
         err = io_submit(ctx, 1, &iocbp);
         if(err > 0)
                 err = 0;
+	else err = -errno;
 
  out:
         return err;

