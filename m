Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWJNMId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWJNMId (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 08:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWJNMIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 08:08:11 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62924 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932180AbWJNMHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 08:07:11 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 08/18] V4L/DVB (4734): Tda826x: fix frontend selection for
	dvb_attach
Date: Sat, 14 Oct 2006 09:00:50 -0300
Message-id: <20061014120050.PS78628900008@infradead.org>
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

 drivers/media/dvb/frontends/tda826x.h |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/media/dvb/frontends/tda826x.h b/drivers/media/dvb/frontends/tda826x.h
index 3307607..83998c0 100644
--- a/drivers/media/dvb/frontends/tda826x.h
+++ b/drivers/media/dvb/frontends/tda826x.h
@@ -35,6 +35,19 @@ #include "dvb_frontend.h"
  * @param has_loopthrough Set to 1 if the card has a loopthrough RF connector.
  * @return FE pointer on success, NULL on failure.
  */
-extern struct dvb_frontend *tda826x_attach(struct dvb_frontend *fe, int addr, struct i2c_adapter *i2c, int has_loopthrough);
-
-#endif
+#if defined(CONFIG_DVB_TDA826X) || defined(CONFIG_DVB_TDA826X_MODULE)
+extern struct dvb_frontend* tda826x_attach(struct dvb_frontend *fe, int addr,
+					   struct i2c_adapter *i2c,
+					   int has_loopthrough);
+#else
+static inline struct dvb_frontend* tda826x_attach(struct dvb_frontend *fe,
+						  int addr,
+						  struct i2c_adapter *i2c,
+						  int has_loopthrough)
+{
+	printk(KERN_WARNING "%s: driver disabled by Kconfig\n", __FUNCTION__);
+	return NULL;
+}
+#endif // CONFIG_DVB_TDA826X
+
+#endif // __DVB_TDA826X_H__

