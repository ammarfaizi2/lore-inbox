Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVBFSoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVBFSoj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 13:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVBFSoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 13:44:38 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:44560 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261274AbVBFSo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 13:44:28 -0500
Date: Sun, 6 Feb 2005 19:44:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org,
       "emmanuel.colbus@ensimag.imag.fr" <colbuse@ensisun.imag.fr>,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix sound/isa/gus/interwave.c compile with PNP=n
Message-ID: <20050206184421.GR3129@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emmanuel Colbus sent this patch one month ago with the following 
description:

There is a trivial bug in the file sound/isa/gus/interwave.c .
The variable isapnp is defined only if CONFIG_PNP is enabled, but it is
always used few lines after.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- a/sound/isa/gus/interwave.c	Fri Dec 24 22:34:58 2004
+++ b/sound/isa/gus/interwave.c	Wed Jan  5 14:06:53 2005
@@ -79,8 +79,10 @@
 MODULE_PARM_DESC(id, "ID string for InterWave soundcard.");
 module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "Enable InterWave soundcard.");
+#ifdef CONFIG_PNP
 module_param_array(isapnp, bool, NULL, 0444);
 MODULE_PARM_DESC(isapnp, "ISA PnP detection for specified soundcard.");
+#endif
 module_param_array(port, long, NULL, 0444);
 MODULE_PARM_DESC(port, "Port # for InterWave driver.");
 #ifdef SNDRV_STB
