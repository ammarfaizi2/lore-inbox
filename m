Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWIWPpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWIWPpA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 11:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWIWPo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 11:44:59 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:15070 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751252AbWIWPo7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 11:44:59 -0400
Date: Sat, 23 Sep 2006 16:44:58 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] more fallout from get_property returning pointer to const
Message-ID: <20060923154458.GI29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/powerpc/platforms/powermac/feature.c |    4 ++--
 arch/powerpc/platforms/powermac/smp.c     |    2 +-
 drivers/char/briq_panel.c                 |    2 +-
 drivers/video/riva/fbdev.c                |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
index 13fcaf5..e49621b 100644
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -1058,8 +1058,8 @@ core99_reset_cpu(struct device_node *nod
 	if (np == NULL)
 		return -ENODEV;
 	for (np = np->child; np != NULL; np = np->sibling) {
-		u32 *num = get_property(np, "reg", NULL);
-		u32 *rst = get_property(np, "soft-reset", NULL);
+		const u32 *num = get_property(np, "reg", NULL);
+		const u32 *rst = get_property(np, "soft-reset", NULL);
 		if (num == NULL || rst == NULL)
 			continue;
 		if (param == *num) {
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index 653eeb6..1949b65 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -702,7 +702,7 @@ #else /* CONFIG_PPC64 */
 	/* GPIO based HW sync on ppc32 Core99 */
 	if (pmac_tb_freeze == NULL && !machine_is_compatible("MacRISC4")) {
 		struct device_node *cpu;
-		u32 *tbprop = NULL;
+		const u32 *tbprop = NULL;
 
 		core99_tb_gpio = KL_GPIO_TB_ENABLE;	/* default value */
 		cpu = of_find_node_by_type(NULL, "cpu");
diff --git a/drivers/char/briq_panel.c b/drivers/char/briq_panel.c
index a0e5eac..caae795 100644
--- a/drivers/char/briq_panel.c
+++ b/drivers/char/briq_panel.c
@@ -202,7 +202,7 @@ static struct miscdevice briq_panel_misc
 static int __init briq_panel_init(void)
 {
 	struct device_node *root = find_path_device("/");
-	char *machine;
+	const char *machine;
 	int i;
 
 	machine = get_property(root, "model", NULL);
diff --git a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
index 67d1e1c..61a4665 100644
--- a/drivers/video/riva/fbdev.c
+++ b/drivers/video/riva/fbdev.c
@@ -1827,7 +1827,7 @@ static int __devinit riva_get_EDID_OF(st
 	struct riva_par *par = info->par;
 	struct device_node *dp;
 	unsigned char *pedid = NULL;
-	unsigned char *disptype = NULL;
+	const unsigned char *disptype = NULL;
 	static char *propnames[] = {
 		"DFP,EDID", "LCD,EDID", "EDID", "EDID1", "EDID,B", "EDID,A", NULL };
 	int i;
-- 
1.4.2.GIT

