Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262094AbULLTqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbULLTqO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 14:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbULLTqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 14:46:13 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:44049 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262094AbULLTqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 14:46:04 -0500
Date: Sun, 12 Dec 2004 20:45:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: "Petri T. Koistinen" <petri.koistinen@iki.fi>,
       linux-kernel@vger.kernel.org, vojtech@suse.cz,
       linux-input@atrey.karlin.mff.cuni.cz
Subject: [2.6 patch] fm801_gp_probe: fix use after free
Message-ID: <20041212194555.GE22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below by "Petri T. Koistinen" <petri.koistinen@iki.fi> in 
Rusty's trivial patches is IMHO a candidate for 2.6.10 .


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc3/drivers/input/gameport/fm801-gp.c	2004-10-19 14:34:00.000000000 +1000
+++ .27568.trivial/drivers/input/gameport/fm801-gp.c	2004-12-05 11:06:01.000000000 +1100
@@ -98,8 +98,8 @@ static int __devinit fm801_gp_probe(stru
 	pci_enable_device(pci);
 	gp->gameport.io = pci_resource_start(pci, 0);
 	if ((gp->res_port = request_region(gp->gameport.io, 0x10, "FM801 GP")) == NULL) {
-		kfree(gp);
 		printk("unable to grab region 0x%x-0x%x\n", gp->gameport.io, gp->gameport.io + 0x0f);
+		kfree(gp);
 		return -1;
 	}
 

