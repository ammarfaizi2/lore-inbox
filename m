Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbUKPVrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbUKPVrL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 16:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbUKPVpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 16:45:35 -0500
Received: from smtp-out.hotpop.com ([38.113.3.71]:29650 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S261839AbUKPVnO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 16:43:14 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Subject: Re: Linux 2.6.10-rc2 SAVAGEFB startup crash
Date: Wed, 17 Nov 2004 05:43:02 +0800
User-Agent: KMail/1.5.4
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org> <200411162043.23585.adaplas@hotpop.com> <20041116172748.GA2499@titan.lahn.de>
In-Reply-To: <20041116172748.GA2499@titan.lahn.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411170543.04360.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 November 2004 01:27, Philipp Matthias Hahn wrote:
> Hello Antonio, LKML!
>
> On Tue, Nov 16, 2004 at 08:43:22PM +0800, Antonino A. Daplas wrote:
> > On Tuesday 16 November 2004 15:55, Philipp Matthias Hahn wrote:

> after boot. Switching between XFree86 and SavageFB also locked up the

As for the lockup between X and the console, can you try this patch?

Tony

diff -Nru a/drivers/video/savage/savagefb.c b/drivers/video/savage/savagefb.c
--- a/drivers/video/savage/savagefb.c	2004-11-11 07:58:25 +08:00
+++ b/drivers/video/savage/savagefb.c	2004-11-17 05:40:47 +08:00
@@ -1797,23 +1797,23 @@
 	switch (info->fix.accel) {
 	case FB_ACCEL_SUPERSAVAGE:
 		par->chip = S3_SUPERSAVAGE;
-		snprintf (info->fix.id, 16, "S3 SuperSavage");
+		snprintf (info->fix.id, 16, "SuperSavage");
 		break;
 	case FB_ACCEL_SAVAGE4:
 		par->chip = S3_SAVAGE4;
-		snprintf (info->fix.id, 16, "S3 Savage4");
+		snprintf (info->fix.id, 16, "Savage4");
 		break;
 	case FB_ACCEL_SAVAGE3D:
 		par->chip = S3_SAVAGE3D;
-		snprintf (info->fix.id, 16, "S3 Savage3D");
+		snprintf (info->fix.id, 16, "Savage3D");
 		break;
 	case FB_ACCEL_SAVAGE3D_MV:
 		par->chip = S3_SAVAGE3D;
-		snprintf (info->fix.id, 16, "S3 Savage3D-MV");
+		snprintf (info->fix.id, 16, "Savage3D-MV");
 		break;
 	case FB_ACCEL_SAVAGE2000:
 		par->chip = S3_SAVAGE2000;
-		snprintf (info->fix.id, 16, "S3 Savage2000");
+		snprintf (info->fix.id, 16, "Savage2000");
 		break;
 	case FB_ACCEL_SAVAGE_MX_MV:
 		par->chip = S3_SAVAGE_MX;
@@ -1878,7 +1878,8 @@
 	info->fbops          = &savagefb_ops;
 	info->flags          = FBINFO_DEFAULT |
 		               FBINFO_HWACCEL_YPAN |
-		               FBINFO_HWACCEL_XPAN;
+		               FBINFO_HWACCEL_XPAN |
+	                       FBINFO_MISC_MODESWITCHLATE;
 
 	info->pseudo_palette = par->pseudo_palette;
 


