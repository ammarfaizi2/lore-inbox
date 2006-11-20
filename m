Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030535AbWKTXgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030535AbWKTXgW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 18:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030536AbWKTXgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 18:36:22 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:55533 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030535AbWKTXgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 18:36:21 -0500
Date: Tue, 21 Nov 2006 00:36:10 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Phil Oester <kernel@linuxace.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: make menuconfig regression in 2.6.19-rc
In-Reply-To: <20061114003752.GA15295@linuxace.com>
Message-ID: <Pine.LNX.4.64.0611210035150.6243@scrub.home>
References: <20061114003752.GA15295@linuxace.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 13 Nov 2006, Phil Oester wrote:

> In commit 350b5b76384e77bcc58217f00455fdbec5cac594, the default menuconfig
> color scheme was changed to bluetitle.  This breaks the highlighting
> of the selected item for me with TERM=vt100.  The only way I can see
> which item is selected is via:
> 
>     make MENUCONFIG_COLOR=mono menuconfig
> 
> Which restores the pre-2.6.19 white on black highlighting.  

Could you try the patch below?

bye, Roman

---
 scripts/kconfig/lxdialog/util.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

Index: linux-2.6-mm/scripts/kconfig/lxdialog/util.c
===================================================================
--- linux-2.6-mm.orig/scripts/kconfig/lxdialog/util.c
+++ linux-2.6-mm/scripts/kconfig/lxdialog/util.c
@@ -221,16 +221,14 @@ static void init_dialog_colors(void)
  */
 static void color_setup(const char *theme)
 {
-	if (set_theme(theme)) {
-		if (has_colors()) {	/* Terminal supports color? */
-			start_color();
-			init_dialog_colors();
-		}
-	}
-	else
-	{
+	int use_color;
+
+	use_color = set_theme(theme);
+	if (use_color && has_colors()) {
+		start_color();
+		init_dialog_colors();
+	} else
 		set_mono_theme();
-	}
 }
 
 /*
