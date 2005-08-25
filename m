Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbVHYWA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbVHYWA3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 18:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbVHYWA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 18:00:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50629 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S964894AbVHYWA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 18:00:28 -0400
Date: Thu, 25 Aug 2005 23:03:35 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] bogus function type in qdio
Message-ID: <20050825220335.GX9322@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In qdio_get_micros() volatile in return type is plain noise (even with old
gccisms it would make no sense - noreturn function returning __u64 is a
bit odd ;-)

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc7-emac-iounmap/drivers/s390/cio/qdio.c RC13-rc7-attr-misc/drivers/s390/cio/qdio.c
--- RC13-rc7-emac-iounmap/drivers/s390/cio/qdio.c	2005-08-24 01:58:29.000000000 -0400
+++ RC13-rc7-attr-misc/drivers/s390/cio/qdio.c	2005-08-25 00:54:22.000000000 -0400
@@ -112,7 +112,7 @@
 
 /***************** SCRUBBER HELPER ROUTINES **********************/
 
-static inline volatile __u64 
+static inline __u64 
 qdio_get_micros(void)
 {
         return (get_clock() >> 10); /* time>>12 is microseconds */
