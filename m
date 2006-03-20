Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965011AbWCTPeB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbWCTPeB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965306AbWCTPdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:33:38 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41400 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965296AbWCTP0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:26:47 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Ian Pickworth <ian@pickworth.me.uk>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 121/141] V4L/DVB (3393): Cx88: reduce excessive logging
Date: Mon, 20 Mar 2006 12:08:57 -0300
Message-id: <20060320150857.PS258130000121@infradead.org>
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

From: Ian Pickworth <ian@pickworth.me.uk>
Date: 1141009785 -0300

- fix temporary debug code by changing printk to dprintk at level 1.
- move CORE_IOCTL messages from level 1 to level 2.
- this should help with selective debugging,
  while not filling people's logs up during normal use.

Signed-off-by: Ian Pickworth <ian@pickworth.me.uk>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/dvb/bt8xx/dvb-bt8xx.c b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
diff --git a/drivers/media/dvb/bt8xx/dvb-bt8xx.c b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
index b8eab69..baa8227 100644
--- a/drivers/media/dvb/bt8xx/dvb-bt8xx.c
+++ b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
@@ -243,7 +243,7 @@ static int pinnsat_pll_init(struct dvb_f
 
 	bttv_gpio_enable(card->bttv_nr, 1, 1);  /* output */
 	bttv_write_gpio(card->bttv_nr, 1, 1);   /* relay on */
-	
+
 	return 0;
 }
 
diff --git a/drivers/media/video/cx88/cx88-video.c b/drivers/media/video/cx88/cx88-video.c
diff --git a/drivers/media/video/cx88/cx88-video.c b/drivers/media/video/cx88/cx88-video.c
index d15ef15..7bbc81f 100644
--- a/drivers/media/video/cx88/cx88-video.c
+++ b/drivers/media/video/cx88/cx88-video.c
@@ -918,9 +918,9 @@ static int get_control(struct cx88_core 
 		ctl->value = ((value + (c->off << c->shift)) & c->mask) >> c->shift;
 		break;
 	}
-	printk("get_control id=0x%X reg=0x%02x val=0x%02x (mask 0x%02x)%s\n",
-					ctl->id, c->reg, ctl->value,
-					c->mask, c->sreg ? " [shadowed]" : "");
+	dprintk(1,"get_control id=0x%X(%s) ctrl=0x%02x, reg=0x%02x val=0x%02x (mask 0x%02x)%s\n",
+				ctl->id, c->v.name, ctl->value, c->reg,
+				value,c->mask, c->sreg ? " [shadowed]" : "");
 	return 0;
 }
 
@@ -969,9 +969,9 @@ static int set_control(struct cx88_core 
 		value = ((ctl->value - c->off) << c->shift) & c->mask;
 		break;
 	}
-	printk("set_control id=0x%X reg=0x%02x val=0x%02x (mask 0x%02x)%s\n",
-					ctl->id, c->reg, value,
-					mask, c->sreg ? " [shadowed]" : "");
+	dprintk(1,"set_control id=0x%X(%s) ctrl=0x%02x, reg=0x%02x val=0x%02x (mask 0x%02x)%s\n",
+				ctl->id, c->v.name, ctl->value, c->reg, value,
+				mask, c->sreg ? " [shadowed]" : "");
 	if (c->sreg) {
 		cx_sandor(c->sreg, c->reg, mask, value);
 	} else {
@@ -1252,7 +1252,7 @@ int cx88_do_ioctl(struct inode *inode, s
 {
 	int err;
 
-	dprintk( 1, "CORE IOCTL: 0x%x\n", cmd );
+	dprintk(2, "CORE IOCTL: 0x%x\n", cmd );
 	if (video_debug > 1)
 		v4l_print_ioctl(core->name,cmd);
 

