Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265377AbUAZWmf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 17:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265384AbUAZWmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 17:42:35 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:45067 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265377AbUAZWme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 17:42:34 -0500
Date: Mon, 26 Jan 2004 22:42:32 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: fbdev booting fix.
Message-ID: <Pine.LNX.4.44.0401262238340.5445-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

  This is very critical bug fix. This bug was causing the problem with 
people builing more than one driver with vesa and they where getting blank 
screens. The reason was befor ethe api change each driver was loaded and 
set as the default driver. Then you ended up with the last driver being 
the default driver. Now this is the not the case so this patch makes the
first driver the default driver.


[FBCON] Fixed the order of which driver is used for the console. Before 
the api change the last driver loaded became the default one. Now this is 
not the case.

--- linus-2.6/drivers/video/console/fbcon.c	2004-01-26 13:38:23.000000000 -0800
+++ fbdev-2.6/drivers/video/console/fbcon.c	2004-01-26 17:14:00.000000000 -0800
@@ -545,7 +545,7 @@
 		return display_desc;
 	done = 1;
 
-	info = registered_fb[num_registered_fb-1];	
+	info = registered_fb[0];	
 	if (!info)	return NULL;
 	info->currcon = -1;
 	

