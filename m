Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932763AbWCQU6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932763AbWCQU6l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 15:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932769AbWCQU6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 15:58:09 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:3755 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932763AbWCQU51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 15:57:27 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Markus Rechberger <mrechberger@gmail.com>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 14/21] Cinergy T2 dmx cleanup on disconnect
Date: Fri, 17 Mar 2006 17:54:36 -0300
Message-id: <20060317205436.PS76282600014@infradead.org>
In-Reply-To: <20060317205359.PS65198900000@infradead.org>
References: <20060317205359.PS65198900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Markus Rechberger <mrechberger@gmail.com>
Date: 1142425891 \-0300

Detaching the device didn't clean up several device files in /dev/dvb,
after applying that patch all dvb devices disappeared as expected.

Signed-off-by: Markus Rechberger <mrechberger@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/cinergyT2/cinergyT2.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/media/dvb/cinergyT2/cinergyT2.c b/drivers/media/dvb/cinergyT2/cinergyT2.c
index c4b4c5b..4ef54c7 100644
--- a/drivers/media/dvb/cinergyT2/cinergyT2.c
+++ b/drivers/media/dvb/cinergyT2/cinergyT2.c
@@ -505,6 +505,9 @@ static int cinergyt2_open (struct inode 
 
 static void cinergyt2_unregister(struct cinergyt2 *cinergyt2)
 {
+	dvb_net_release(&cinergyt2->dvbnet);
+	dvb_dmxdev_release(&cinergyt2->dmxdev);
+	dvb_dmx_release(&cinergyt2->demux);
 	dvb_unregister_device(cinergyt2->fedev);
 	dvb_unregister_adapter(&cinergyt2->adapter);
 
@@ -937,6 +940,7 @@ static int cinergyt2_probe (struct usb_i
 	return 0;
 
 bailout:
+	dvb_net_release(&cinergyt2->dvbnet);
 	dvb_dmxdev_release(&cinergyt2->dmxdev);
 	dvb_dmx_release(&cinergyt2->demux);
 	dvb_unregister_adapter(&cinergyt2->adapter);

