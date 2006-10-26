Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423481AbWJZNEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423481AbWJZNEJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 09:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423479AbWJZNEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 09:04:09 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:54497 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1423481AbWJZNEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 09:04:07 -0400
Date: Thu, 26 Oct 2006 15:04:02 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [patch 4/5] profile: fix uaccess handling
Message-ID: <20061026130402.GE7127@osiris.boeblingen.de.ibm.com>
References: <20061026130010.GA7127@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061026130010.GA7127@osiris.boeblingen.de.ibm.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 kernel/profile.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6/kernel/profile.c
===================================================================
--- linux-2.6.orig/kernel/profile.c	2006-10-26 14:40:57.000000000 +0200
+++ linux-2.6/kernel/profile.c	2006-10-26 14:42:07.000000000 +0200
@@ -442,7 +442,8 @@
 	read = 0;
 
 	while (p < sizeof(unsigned int) && count > 0) {
-		put_user(*((char *)(&sample_step)+p),buf);
+		if (put_user(*((char *)(&sample_step)+p),buf))
+			return -EFAULT;
 		buf++; p++; count--; read++;
 	}
 	pnt = (char *)prof_buffer + p - sizeof(atomic_t);
