Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbWJNMLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWJNMLt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 08:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWJNMH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 08:07:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:1229 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932186AbWJNMHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 08:07:23 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Amit Choudhary <amit2030@gmail.com>,
       Manu Abraham <manu@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 09/18] V4L/DVB (4738): Bt8xx/dvb-bt8xx.c: check kmalloc()
	return value.
Date: Sat, 14 Oct 2006 09:00:50 -0300
Message-id: <20061014120050.PS89462600009@infradead.org>
In-Reply-To: <20061014115356.PS36551000000@infradead.org>
References: <20061014115356.PS36551000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Amit Choudhary <amit2030@gmail.com>

Check the return value of kmalloc() in function frontend_init(), 
in file drivers/media/dvb/bt8xx/dvb-bt8xx.c.

Signed-off-by: Amit Choudhary <amit2030@gmail.com>
Signed-off-by: Manu Abraham <manu@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/bt8xx/dvb-bt8xx.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

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

