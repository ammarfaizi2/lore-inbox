Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWCJVO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWCJVO1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 16:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWCJVO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 16:14:26 -0500
Received: from silver.veritas.com ([143.127.12.111]:27037 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932268AbWCJVOX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 16:14:23 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.02,181,1139212800"; 
   d="scan'208"; a="35716382:sNHT21599736"
Date: Fri, 10 Mar 2006 21:15:19 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Dominik Brodowski <linux@dominikbrodowski.net>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] fix pcmcia_device_remove oops
Message-ID: <Pine.LNX.4.61.0603102113490.4517@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Mar 2006 21:14:22.0289 (UTC) FILETIME=[9A13A410:01C64487]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix pcmcia_device_remove NULL pointer dereference at shutdown.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---
Unlike its older brother, this oops has not yet graduated from -mm to
mainline.  I've not yet seen my cards working in -mm (maybe intermittent
anomaly at my end), and saw oops when removing and inserting card; but
follow those issues up another time, this is a good start just for
closing down the box.

 drivers/pcmcia/ds.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- 2.6.16-rc5-mm3/drivers/pcmcia/ds.c	2006-03-07 11:43:21.000000000 +0000
+++ linux/drivers/pcmcia/ds.c	2006-03-10 17:40:04.000000000 +0000
@@ -464,7 +464,7 @@ static int pcmcia_device_remove(struct d
 	 * all devices
 	 */
 	did = (struct pcmcia_device_id *) p_dev->dev.driver_data;
-	if ((did->match_flags & PCMCIA_DEV_ID_MATCH_DEVICE_NO) &&
+	if (did && (did->match_flags & PCMCIA_DEV_ID_MATCH_DEVICE_NO) &&
 	    (p_dev->socket->device_count != 0) &&
 	    (p_dev->device_no == 0))
 		pcmcia_card_remove(p_dev->socket, p_dev);
