Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbWADUTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWADUTH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 15:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965252AbWADUTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 15:19:07 -0500
Received: from bay103-f10.bay103.hotmail.com ([65.54.174.20]:37526 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S964845AbWADUTF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 15:19:05 -0500
Message-ID: <BAY103-F10EB5B13C8450F312A495ADF2F0@phx.gbl>
X-Originating-IP: [69.222.161.84]
X-Originating-Email: [dravet@hotmail.com]
In-Reply-To: <200511170235.jAH2Z9Da003186@shell0.pdx.osdl.net>
From: "Jason Dravet" <dravet@hotmail.com>
To: samuel.thibault@ens-lyon.org, 7eggert@gmx.de, adaplas@gmail.com,
       torvalds@osdl.org, akpm@osdl.org, davej@redhat.com,
       linux-kernel@vger.kernel.org
Subject: RE: + vgacon-fix-doublescan-mode.patch added to -mm tree
Date: Wed, 04 Jan 2006 14:19:05 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 04 Jan 2006 20:19:05.0351 (UTC) FILETIME=[1C2D5170:01C6116C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you please include this patch from the mm tree?  It would be nice to 
have a functioning CLI again (without having to patch and recompile every 
kernel).

Thanks,
Jason

>From: akpm@osdl.org
>To: samuel.thibault@ens-lyon.org, dravet@hotmail.com,   
>mm-commits@vger.kernel.org
>Subject: + vgacon-fix-doublescan-mode.patch added to -mm tree
>Date: Wed, 16 Nov 2005 18:34:51 -0800
>
>The patch titled
>
>      vgacon: fix doublescan mode
>
>has been added to the -mm tree.  Its filename is
>
>      vgacon-fix-doublescan-mode.patch
>
>
>From: Samuel Thibault <samuel.thibault@ens-lyon.org>
>
>When doublescan mode is in use, scanlines must be doubled.
>
>Thanks to Jason Dravet <dravet@hotmail.com> for reporting and testing.
>
>Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
>  drivers/video/console/vgacon.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletion(-)
>
>diff -puN drivers/video/console/vgacon.c~vgacon-fix-doublescan-mode 
>drivers/video/console/vgacon.c
>--- 
>devel/drivers/video/console/vgacon.c~vgacon-fix-doublescan-mode	2005-11-16 
>18:34:47.000000000 -0800
>+++ devel-akpm/drivers/video/console/vgacon.c	2005-11-16 18:34:47.000000000 
>-0800
>@@ -503,10 +503,16 @@ static int vgacon_doresize(struct vc_dat
>  {
>  	unsigned long flags;
>  	unsigned int scanlines = height * c->vc_font.height;
>-	u8 scanlines_lo, r7, vsync_end, mode;
>+	u8 scanlines_lo, r7, vsync_end, mode, max_scan;
>
>  	spin_lock_irqsave(&vga_lock, flags);
>
>+	outb_p(VGA_CRTC_MAX_SCAN, vga_video_port_reg);
>+	max_scan = inb_p(vga_video_port_val);
>+
>+	if (max_scan & 0x80)
>+		scanlines <<= 1;
>+
>  	outb_p(VGA_CRTC_MODE, vga_video_port_reg);
>  	mode = inb_p(vga_video_port_val);
>
>_
>
>Patches currently in -mm which might be from samuel.thibault@ens-lyon.org 
>are
>
>vgacon-fix-doublescan-mode.patch
>


