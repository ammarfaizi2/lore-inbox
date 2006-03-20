Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965275AbWCTPYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965275AbWCTPYS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965285AbWCTPYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:24:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:58850 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965274AbWCTPXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:23:04 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Markus Rechberger <mrechberger@gmail.com>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 051/141] V4L/DVB (3281): Added signal detection support to
	tvp5150
Date: Mon, 20 Mar 2006 12:08:45 -0300
Message-id: <20060320150845.PS487094000051@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Rechberger <mrechberger@gmail.com>
Date: 1139301504 -0200

- added signal detection support to tvp5150

Signed-off-by: Markus Rechberger <mrechberger@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/tvp5150.c b/drivers/media/video/tvp5150.c
diff --git a/drivers/media/video/tvp5150.c b/drivers/media/video/tvp5150.c
index 20e6359..3ae8a9f 100644
--- a/drivers/media/video/tvp5150.c
+++ b/drivers/media/video/tvp5150.c
@@ -967,6 +967,17 @@ static int tvp5150_command(struct i2c_cl
 		}
 	case DECODER_GET_STATUS:
 		{
+			int *iarg = arg;
+			int status;
+			int res=0;
+			status = tvp5150_read(c, 0x88);
+			if(status&0x08){
+				res |= DECODER_STATUS_COLOR;
+			}
+			if(status&0x04 && status&0x02){
+				res |= DECODER_STATUS_GOOD;
+			}
+			*iarg=res;
 			break;
 		}
 

