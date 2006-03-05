Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbWCEO4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWCEO4t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 09:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWCEO4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 09:56:49 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11744 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751358AbWCEO4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 09:56:48 -0500
Date: Sun, 5 Mar 2006 15:04:08 +0100
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>, linux-mtd@lists.infradead.org
Subject: [patch] collie: add flash type to jedec_probe
Message-ID: <20060305140408.GA17192@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for flash chip used in collie (sharp zaurus sl-5500)
to jedec_probe.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/drivers/mtd/chips/jedec_probe.c b/drivers/mtd/chips/jedec_probe.c
index edb306c..6c27bff 100644
--- a/drivers/mtd/chips/jedec_probe.c
+++ b/drivers/mtd/chips/jedec_probe.c
@@ -34,6 +34,7 @@
 #define MANUFACTURER_MACRONIX	0x00C2
 #define MANUFACTURER_NEC	0x0010
 #define MANUFACTURER_PMC	0x009D
+#define MANUFACTURER_SHARP	0x00b0
 #define MANUFACTURER_SST	0x00BF
 #define MANUFACTURER_ST		0x0020
 #define MANUFACTURER_TOSHIBA	0x0098
@@ -124,6 +125,9 @@
 #define PM49FL004	0x006E
 #define PM49FL008	0x006A
 
+/* Sharp */
+#define LH28F640BF	0x00b0
+
 /* ST - www.st.com */
 #define M29W800DT	0x00D7
 #define M29W800DB	0x005B
@@ -1267,6 +1271,19 @@ static const struct amd_flash_info jedec
 		.regions	= {
 			ERASEINFO( 0x01000, 256 )
 		}
+	}, {
+		.mfr_id		= MANUFACTURER_SHARP,
+		.dev_id		= LH28F640BF,
+		.name		= "LH28F640BF",
+		.uaddr		= {
+			[0] = MTD_UADDR_UNNECESSARY,    /* x8 */
+		},
+		.DevSize	= SIZE_4MiB,
+		.CmdSet         = P_ID_INTEL_STD,
+		.NumEraseRegions= 1,
+		.regions        = {
+			ERASEINFO(0x40000,16),
+		}
         }, {
 		.mfr_id		= MANUFACTURER_SST,
 		.dev_id		= SST39LF512,

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
