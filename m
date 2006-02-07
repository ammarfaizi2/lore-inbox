Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965121AbWBGPns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121AbWBGPns (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 10:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965132AbWBGPnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 10:43:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:22466 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932455AbWBGPlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 10:41:07 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Markus Rechberger <mrechberger@gmail.com>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 03/16] Added signal detection support to tvp5150
Date: Tue, 07 Feb 2006 13:33:30 -0200
Message-id: <20060207153330.PS04754300003@infradead.org>
In-Reply-To: <20060207153248.PS50860900000@infradead.org>
References: <20060207153248.PS50860900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Rechberger <mrechberger@gmail.com>

- added signal detection support to tvp5150

Signed-off-by: Markus Rechberger <mrechberger@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/tvp5150.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/tvp5150.c b/drivers/media/video/tvp5150.c
index a6330a3..1864423 100644
--- a/drivers/media/video/tvp5150.c
+++ b/drivers/media/video/tvp5150.c
@@ -896,6 +896,17 @@ static int tvp5150_command(struct i2c_cl
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
 

