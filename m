Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264057AbTEOOpP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 10:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264060AbTEOOpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 10:45:11 -0400
Received: from zero.aec.at ([193.170.194.10]:59404 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264057AbTEOOoZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 10:44:25 -0400
Date: Thu, 15 May 2003 16:56:40 +0200
From: Andi Kleen <ak@muc.de>
To: kraxel@suse.de, jsimmons@infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Use MTRRs by default for vesafb on x86-64
Message-ID: <20030515145640.GA19152@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


x86-64 cannot call the 32bit VESA BIOS. This means when vesafb is active
it does software copying in the vesa frame buffer. This is insanely slow
when the frame buffer is not marked for write combining. 

Some discussion showed that the use_mtrr flag was only off for some 
old broken ET4000 ISA card. x86-64 has no ISA, so this is no concern.
Make the default depend on CONFIG_ISA. 

Patch for 2.5.69.  Originally suggested by Gerd Knorr.

-Andi

--- linux/drivers/video/vesafb.c	2003-05-08 04:52:58.000000000 +0200
+++ linux-2.5.69-amd64/drivers/video/vesafb.c	2003-05-15 16:55:51.000000000 +0200
@@ -51,7 +51,11 @@
 static u32 pseudo_palette[17];
 
 static int             inverse   = 0;
+#ifndef CONFIG_ISA 
+static int 	      mtrr	 = 1;
+#else
 static int             mtrr      = 0;
+#endif
 
 static int             pmi_setpal = 0;	/* pmi for palette changes ??? */
 static int             ypan       = 0;  /* 0..nothing, 1..ypan, 2..ywrap */




