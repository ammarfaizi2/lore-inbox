Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWJIGKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWJIGKm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 02:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWJIGKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 02:10:42 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:61637 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932211AbWJIGKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 02:10:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=al5L22SA/xw4X4IDngiQ5MGYwaZ2EkRfBWE5EihQa7KX2tFA08sfRrFAyOfWCTWFdahVed914yL7TUCbauOROqIl2LW/j6WRfSHRyLEzA1GkWbwBqKxBF1TaQ7ofxQ7IK7EI/9p6M9o3qWv9OE5FxBPyTMo5rXg4UIe4PxhHbus=
Date: Sun, 8 Oct 2006 23:10:34 -0700
From: Amit Choudhary <amit2030@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.19-rc1] drivers/media/dvb/bt8xx/dvb-bt8xx.c: check
 kmalloc() return value.
Message-Id: <20061008231034.e50118df.amit2030@gmail.com>
Organization: X
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.15; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Check the return value of kmalloc() in function frontend_init(), in file drivers/media/dvb/bt8xx/dvb-bt8xx.c.

Signed-off-by: Amit Choudhary <amit2030@gmail.com>

diff --git a/drivers/media/dvb/bt8xx/dvb-bt8xx.c b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
index fb6c4cc..14e69a7 100644
--- a/drivers/media/dvb/bt8xx/dvb-bt8xx.c
+++ b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
@@ -665,6 +665,10 @@ static void frontend_init(struct dvb_bt8
 	case BTTV_BOARD_TWINHAN_DST:
 		/*	DST is not a frontend driver !!!		*/
 		state = (struct dst_state *) kmalloc(sizeof (struct dst_state), GFP_KERNEL);
+		if (!state) {
+			printk("dvb_bt8xx: No memory\n");
+			break;
+		}
 		/*	Setup the Card					*/
 		state->config = &dst_config;
 		state->i2c = card->i2c_adapter;
