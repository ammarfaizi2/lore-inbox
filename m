Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbVJAHAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbVJAHAp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 03:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbVJAHAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 03:00:45 -0400
Received: from rwcrmhc14.comcast.net ([204.127.198.54]:25083 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750756AbVJAHAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 03:00:45 -0400
Date: Sat, 1 Oct 2005 00:00:47 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [drivers/dio] kmalloc + memset -> kzalloc conversion
Message-ID: <20051001070047.GF25424@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Deepak Saxena <dsaxena@plexity.net>


diff --git a/drivers/dio/dio.c b/drivers/dio/dio.c
--- a/drivers/dio/dio.c
+++ b/drivers/dio/dio.c
@@ -224,11 +224,10 @@ static int __init dio_init(void)
 		set_fs(fs);
 
                 /* Found a board, allocate it an entry in the list */
-		dev = kmalloc(sizeof(struct dio_dev), GFP_KERNEL);
+		dev = kzalloc(sizeof(struct dio_dev), GFP_KERNEL);
 		if (!dev)
 			return 0;
 
-		memset(dev, 0, sizeof(struct dio_dev));
 		dev->bus = &dio_bus;
 		dev->dev.parent = &dio_bus.dev;
 		dev->dev.bus = &dio_bus_type;
-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.
