Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280740AbRKOEmu>; Wed, 14 Nov 2001 23:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280743AbRKOEml>; Wed, 14 Nov 2001 23:42:41 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:6406 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S280740AbRKOEm1>;
	Wed, 14 Nov 2001 23:42:27 -0500
Date: Thu, 15 Nov 2001 15:36:54 +1100
From: Anton Blanchard <anton@samba.org>
To: groudier@free.fr
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] small sym-2 fix
Message-ID: <20011115153654.E22552@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I tested the sym-2 driver on ppc64 and found that hcb_p can be > 1 page
but __sym_malloc fails for allocations over 1 page. This means we
die in sym_attach.

With this patch the sym-2 works on ppc64. BTW so far it looks solid :)

Anton

diff -urN 2.4.15-pre4/drivers/scsi/sym53c8xx_2/sym_glue.h linuxppc_2_4_devel_work/drivers/scsi/sym53c8xx_2/sym_glue.h
--- 2.4.15-pre4/drivers/scsi/sym53c8xx_2/sym_glue.h	Thu Nov 15 13:38:02 2001
+++ linuxppc_2_4_devel_work/drivers/scsi/sym53c8xx_2/sym_glue.h	Tue Nov 13 18:03:07 2001
@@ -526,7 +526,7 @@
  *  couple of things related to the memory allocator.
  */
 typedef u_long m_addr_t;	/* Enough bits to represent any address */
-#define SYM_MEM_PAGE_ORDER 0	/* 1 PAGE  maximum */
+#define SYM_MEM_PAGE_ORDER 1	/* 2 PAGE  maximum */
 #define SYM_MEM_CLUSTER_SHIFT	(PAGE_SHIFT+SYM_MEM_PAGE_ORDER)
 #ifdef	MODULE
 #define SYM_MEM_FREE_UNUSED	/* Free unused pages immediately */
