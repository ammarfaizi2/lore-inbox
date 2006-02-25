Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932499AbWBYHn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbWBYHn1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 02:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWBYHn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 02:43:27 -0500
Received: from liaag2ac.mx.compuserve.com ([149.174.40.152]:43167 "EHLO
	liaag2ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932499AbWBYHn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 02:43:27 -0500
Date: Sat, 25 Feb 2006 02:41:07 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [-mm patch] x86: start early_printk at sensible screen row
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Stas Sergeev <stsp@aknet.ru>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200602250243_MC3-1-B93E-1384@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use boot info to start early_printk() at the proper row on VGA console.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.16-rc4-mm2-64.orig/arch/x86_64/kernel/early_printk.c
+++ 2.6.16-rc4-mm2-64/arch/x86_64/kernel/early_printk.c
@@ -244,7 +244,7 @@ int __init setup_early_printk(char *opt)
 	           && SCREEN_INFO.orig_video_isVGA == 1) {
 		max_xpos = SCREEN_INFO.orig_video_cols;
 		max_ypos = SCREEN_INFO.orig_video_lines;
-		current_ypos = max_ypos;
+		current_ypos = SCREEN_INFO.orig_y;
 		early_console = &early_vga_console; 
  	} else if (!strncmp(buf, "simnow", 6)) {
  		simnow_init(buf + 6);
-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert
