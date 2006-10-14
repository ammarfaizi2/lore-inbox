Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWJNMId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWJNMId (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 08:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWJNMIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 08:08:13 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:6349 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932197AbWJNMHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 08:07:51 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 07/18] V4L/DVB (4733): Tda10086: fix frontend selection for
	dvb_attach
Date: Sat, 14 Oct 2006 09:00:50 -0300
Message-id: <20061014120050.PS67662400007@infradead.org>
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


From: Michael Krufky <mkrufky@linuxtv.org>

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/frontends/tda10086.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/media/dvb/frontends/tda10086.h b/drivers/media/dvb/frontends/tda10086.h
index e8061db..18457ad 100644
--- a/drivers/media/dvb/frontends/tda10086.h
+++ b/drivers/media/dvb/frontends/tda10086.h
@@ -35,7 +35,16 @@ struct tda10086_config
 	u8 invert;
 };
 
+#if defined(CONFIG_DVB_TDA10086) || defined(CONFIG_DVB_TDA10086_MODULE)
 extern struct dvb_frontend* tda10086_attach(const struct tda10086_config* config,
 					    struct i2c_adapter* i2c);
+#else
+static inline struct dvb_frontend* tda10086_attach(const struct tda10086_config* config,
+						   struct i2c_adapter* i2c)
+{
+	printk(KERN_WARNING "%s: driver disabled by Kconfig\n", __FUNCTION__);
+	return NULL;
+}
+#endif // CONFIG_DVB_TDA10086
 
 #endif // TDA10086_H

