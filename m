Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbUJZSWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbUJZSWk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 14:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbUJZSWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 14:22:40 -0400
Received: from 67-121-164-6.ded.pacbell.net ([67.121.164.6]:2690 "EHLO
	mailserver.sunrisetelecom.com") by vger.kernel.org with ESMTP
	id S261384AbUJZSW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 14:22:26 -0400
Message-ID: <417E9546.7090505@sunrisetelecom.com>
Date: Tue, 26 Oct 2004 14:19:50 -0400
From: Karl Lessard <klessard@sunrisetelecom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Small fix in fbmem
Content-Type: multipart/mixed;
 boundary="------------090702030201030305080904"
X-OriginalArrivalTime: 26 Oct 2004 18:22:24.0607 (UTC) FILETIME=[BDB74EF0:01C4BB88]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090702030201030305080904
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi, this small patch may avoid terrific crashes in case that a fb driver
don't implements the fb_blank method and do use the generic one.

Thanks,
Karl


--------------090702030201030305080904
Content-Type: text/plain;
 name="fbmem.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fbmem.patch"

--- linux/drivers/video/fbmem.c	Tue Oct 26 14:09:42 2004
+++ linux/drivers/video/fbmem.c.patched	Tue Oct 26 14:13:37 2004
@@ -862,7 +862,7 @@
 		return 0;
 	if (blank) { 
 		black = kmalloc(sizeof(u16) * info->cmap.len, GFP_KERNEL);
-		if (!black) {
+		if (black) {
 			memset(black, 0, info->cmap.len * sizeof(u16));
 			cmap.red = cmap.green = cmap.blue = black;
 			cmap.transp = info->cmap.transp ? black : NULL;


--------------090702030201030305080904--

