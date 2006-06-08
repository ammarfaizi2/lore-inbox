Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbWFHETb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbWFHETb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 00:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWFHETb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 00:19:31 -0400
Received: from xenotime.net ([66.160.160.81]:31877 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932491AbWFHETb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 00:19:31 -0400
Date: Wed, 7 Jun 2006 21:22:17 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, tiwai@suse.de
Subject: [PATCH] sound/vxpocket: fix printk warning
Message-Id: <20060607212217.911bd60a.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix printk format warning:
sound/pcmcia/vx/vxp_ops.c:205: warning: format '%x' expects type 'unsigned int', but argument 5 has type 'size_t'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 sound/pcmcia/vx/vxp_ops.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2617-rc6.orig/sound/pcmcia/vx/vxp_ops.c
+++ linux-2617-rc6/sound/pcmcia/vx/vxp_ops.c
@@ -202,7 +202,7 @@ static int vxp_load_xilinx_binary(struct
 	c |= (int)vx_inb(chip, RXM) << 8;
 	c |= vx_inb(chip, RXL);
 
-	snd_printdd(KERN_DEBUG "xilinx: dsp size received 0x%x, orig 0x%x\n", c, fw->size);
+	snd_printdd(KERN_DEBUG "xilinx: dsp size received 0x%x, orig 0x%Zx\n", c, fw->size);
 
 	vx_outb(chip, ICR, ICR_HF0);
 

---
