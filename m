Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030496AbVKQBhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030496AbVKQBhE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 20:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030547AbVKQBhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 20:37:03 -0500
Received: from bay103-f28.bay103.hotmail.com ([65.54.174.38]:50151 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1030496AbVKQBhA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 20:37:00 -0500
Message-ID: <BAY103-F28EE011A9ED5BBFB3F5D4FDF5F0@phx.gbl>
X-Originating-IP: [70.131.134.203]
X-Originating-Email: [dravet@hotmail.com]
In-Reply-To: <20051116235216.GB7573@bouh.residence.ens-lyon.fr>
From: "Jason Dravet" <dravet@hotmail.com>
To: samuel.thibault@ens-lyon.org
Cc: 7eggert@gmx.de, adaplas@gmail.com, torvalds@osdl.org, akpm@osdl.org,
       davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vgacon: Workaround for resize bug in some chipsets
Date: Wed, 16 Nov 2005 19:37:00 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 17 Nov 2005 01:37:00.0408 (UTC) FILETIME=[678E4780:01C5EB17]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Samuel Thibault <samuel.thibault@ens-lyon.org>
>To: Jason Dravet <dravet@hotmail.com>
>CC: 7eggert@gmx.de, adaplas@gmail.com, torvalds@osdl.org, 
>akpm@osdl.org,davej@redhat.com, linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] vgacon: Workaround for resize bug in some chipsets
>Date: Thu, 17 Nov 2005 00:52:16 +0100
>
>Hi,
>
>The following patch should correct the issue:
>
>When doublescan mode is in use, scanlines must be doubled.
>
>Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
>
>--- drivers/video/console/vgacon.c.orig	2005-11-17 00:40:02.000000000 +0100
>+++ drivers/video/console/vgacon.c	2005-11-17 00:42:27.000000000 +0100
>@@ -502,10 +502,16 @@
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

The patch does fix my problem.  Thank you Samuel.  I really appreciate the 
work you and Antonino have done on this issue.  I look forward to seeing 
this patch in the mainline.

Thanks again,
Jason Dravet


