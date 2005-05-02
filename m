Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbVEBB6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVEBB6j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 21:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVEBB5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 21:57:19 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:33808 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261647AbVEBBqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 21:46:54 -0400
Date: Mon, 2 May 2005 03:46:52 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux@syskonnect.de, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [2.6 patch] drivers/net/skfp/: fix LITTLE_ENDIAN
Message-ID: <20050502014652.GU3592@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the LITTLE_ENDIAN #define and a function prototype.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 20 Apr 2005

 drivers/net/skfp/h/osdef1st.h |    2 ++
 drivers/net/skfp/smt.c        |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.12-rc2-mm3-full/drivers/net/skfp/h/osdef1st.h.old	2005-04-20 01:22:21.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/skfp/h/osdef1st.h	2005-04-20 01:23:55.000000000 +0200
@@ -20,6 +20,8 @@
 // HWM (HardWare Module) Definitions
 // -----------------------
 
+#include <asm/byteorder.h>
+
 #ifdef __LITTLE_ENDIAN
 #define LITTLE_ENDIAN
 #else
--- linux-2.6.12-rc2-mm3-full/drivers/net/skfp/smt.c.old	2005-04-20 01:26:34.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/skfp/smt.c	2005-04-20 01:26:22.000000000 +0200
@@ -86,7 +86,7 @@
 static void smt_send_sif_operation(struct s_smc *smc, struct fddi_addr *dest,
 				   u_long tid, int local);
 #ifdef LITTLE_ENDIAN
-static void smt_string_swap(void);
+static void smt_string_swap(char *data, const char *format, int len);
 #endif
 static void smt_add_frame_len(SMbuf *mb, int len);
 static void smt_fill_una(struct s_smc *smc, struct smt_p_una *una);

