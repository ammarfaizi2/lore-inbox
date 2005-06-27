Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVF0Nhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVF0Nhh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 09:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbVF0Ndz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 09:33:55 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:27365 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262078AbVF0MQy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:54 -0400
Message-Id: <20050627121410.558481000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:05 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Peter Beutner <p.beutner@gmx.net>
Content-Disposition: inline; filename=dvb-core-demux-error-handling-fix.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 05/51] core: demux error handling fix
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Beutner <p.beutner@gmx.net>

In dvb_dmxdev_filter_start if we go out because of an error, release
previously allocated demux_feed.

Signed-off-by: Peter Beutner <p.beutner@gmx.net>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-core/dmxdev.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6.12-git8/drivers/media/dvb/dvb-core/dmxdev.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/dvb-core/dmxdev.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-core/dmxdev.c	2005-06-27 13:22:59.000000000 +0200
@@ -669,8 +669,10 @@ static int dvb_dmxdev_filter_start(struc
 
 		ret = filter->feed.ts->start_filtering(filter->feed.ts);
 
-		if (ret < 0)
+		if (ret < 0) {
+			dmxdev->demux->release_ts_feed(dmxdev->demux, *tsfeed);
 			return ret;
+		}
 
 		break;
 	}

--

