Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbWCTOtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWCTOtX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 09:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbWCTOtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 09:49:23 -0500
Received: from fachschaft.cup.uni-muenchen.de ([141.84.250.61]:42407 "EHLO
	fachschaft.cup.uni-muenchen.de") by vger.kernel.org with ESMTP
	id S964821AbWCTOtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 09:49:23 -0500
Date: Mon, 20 Mar 2006 15:45:23 +0100 (CET)
From: Oliver Neukum <neukum@fachschaft.cup.uni-muenchen.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH]micro optimization of kcalloc
Message-ID: <Pine.LNX.4.58.0603201542250.17461@fachschaft.cup.uni-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this optimises away a division in kcalloc by letting the compiler
do it. It is redone to allow size==0.

	Regards
		Oliver

Signed-off-by: Oliver Neukum <oliver@neukum.name>

--- linux-2.6.16-rc6-vanilla/include/linux/slab.h	2006-03-11 23:12:55.000000000 +0100
+++ linux-2.6.16-rc6/include/linux/slab.h	2006-03-20 14:39:36.000000000 +0100
@@ -118,7 +118,7 @@
  */
 static inline void *kcalloc(size_t n, size_t size, gfp_t flags)
 {
-	if (n != 0 && size > INT_MAX / n)
+	if (unlikely(size != 0 && n > INT_MAX / size ))
 		return NULL;
 	return kzalloc(n * size, flags);
 }
