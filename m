Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbVALWZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVALWZd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 17:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVALWVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:21:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42398 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261532AbVALWUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 17:20:43 -0500
Date: Wed, 12 Jan 2005 17:20:03 -0500
From: Dave Jones <davej@redhat.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: matroxfb driver broken on non-x86.
Message-ID: <20050112222003.GP24518@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This broke since the recent MODULE_PARAM conversion on
architectures that don't have CONFIG_MTRR

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.10/drivers/video/matrox/matroxfb_base.c~	2005-01-12 16:46:23.000000000 -0500
+++ linux-2.6.10/drivers/video/matrox/matroxfb_base.c	2005-01-12 16:48:54.000000000 -0500
@@ -2477,8 +2477,10 @@ module_param(noinit, int, 0);
 MODULE_PARM_DESC(noinit, "Disables W/SG/SD-RAM and bus interface initialization (0 or 1=do not initialize) (default=0)");
 module_param(memtype, int, 0);
 MODULE_PARM_DESC(memtype, "Memory type for G200/G400 (see Documentation/fb/matroxfb.txt for explanation) (default=3 for G200, 0 for G400)");
+#ifdef CONFIG_MTRR
 module_param(mtrr, int, 0);
 MODULE_PARM_DESC(mtrr, "This speeds up video memory accesses (0=disabled or 1) (default=1)");
+#endif
 module_param(sgram, int, 0);
 MODULE_PARM_DESC(sgram, "Indicates that G100/G200/G400 has SGRAM memory (0=SDRAM, 1=SGRAM) (default=0)");
 module_param(inv24, int, 0);
