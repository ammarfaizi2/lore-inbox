Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269669AbUJHIFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269669AbUJHIFr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 04:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269738AbUJHIFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 04:05:46 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:46934 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269669AbUJHIFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 04:05:22 -0400
Message-ID: <288dbef704100801055d151079@mail.gmail.com>
Date: Fri, 8 Oct 2004 16:05:21 +0800
From: shaohua li <shaoh.li@gmail.com>
Reply-To: shaohua li <shaoh.li@gmail.com>
To: akpm@osdl.org
Subject: [patch]pc110pad.c small fix
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
'request_region' returns NULL if failed. The driver does the contrary. 

Thanks,
Shaohua

Signed-off-by: Li Shaohua <shaoh.li@gmail.com>
===== drivers/input/mouse/pc110pad.c 1.9 vs edited =====
--- 1.9/drivers/input/mouse/pc110pad.c	2004-07-27 05:27:05 +08:00
+++ edited/drivers/input/mouse/pc110pad.c	2004-08-04 16:56:17 +08:00
@@ -109,7 +109,7 @@ static int pc110pad_open(struct input_de
 
 static int __init pc110pad_init(void)
 {
-	if (request_region(pc110pad_io, 4, "pc110pad"))
+	if (!request_region(pc110pad_io, 4, "pc110pad"))
 	{
 		printk(KERN_ERR "pc110pad: I/O area %#x-%#x in use.\n",
pc110pad_io, pc110pad_io + 4);
 		return -EBUSY;
