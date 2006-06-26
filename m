Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbWFZKfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWFZKfM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 06:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWFZKfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 06:35:12 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43527 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932460AbWFZKfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 06:35:10 -0400
Date: Mon, 26 Jun 2006 12:35:09 +0200
From: Adrian Bunk <bunk@stusta.de>
To: mitr@volny.cz
Cc: dtor_core@ameritech.net, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/input/misc/wistron_btns.c: section fixes
Message-ID: <20060626103509.GQ23314@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following fixes:
- it doesn't make sense to mark a variable on the stack as __initdata
- struct dmi_ids is using the __init dmi_matched()
  since the only user of struct dmi_ids is the __init select_keymap(),
  the solution is to make struct dmi_ids __initdata

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/input/misc/wistron_btns.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.17-mm2-full/drivers/input/misc/wistron_btns.c.old	2006-06-26 02:03:20.000000000 +0200
+++ linux-2.6.17-mm2-full/drivers/input/misc/wistron_btns.c	2006-06-26 02:07:58.000000000 +0200
@@ -94,7 +94,7 @@
 
 static ssize_t __init locate_wistron_bios(void __iomem *base)
 {
-	static const unsigned char __initdata signature[] =
+	static const unsigned char signature[] =
 		{ 0x42, 0x21, 0x55, 0x30 };
 	ssize_t offset;
 
@@ -333,7 +333,7 @@
  * a list of buttons and their key codes (reported when loading this module
  * with force=1) and the output of dmidecode to $MODULE_AUTHOR.
  */
-static struct dmi_system_id dmi_ids[] = {
+static struct dmi_system_id __initdata dmi_ids[] = {
 	{
 		.callback = dmi_matched,
 		.ident = "Fujitsu-Siemens Amilo Pro V2000",

