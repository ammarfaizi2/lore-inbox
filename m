Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935410AbWKZOax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935410AbWKZOax (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 09:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935412AbWKZOax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 09:30:53 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38806 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S935410AbWKZOag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 09:30:36 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Andrew de Quincey <adq_dvb@lidskialf.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 2/2] V4L/DVB (4874): Fix oops on symbol rate==0
Date: Sun, 26 Nov 2006 12:26:51 -0200
Message-id: <20061126142651.PS2457560007@infradead.org>
In-Reply-To: <20061126141928.PS6336290000@infradead.org>
References: <20061126141928.PS6336290000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Andrew de Quincey <adq_dvb@lidskialf.net>

The tda10086 causes an oops (divide by zero) if a zero symbol rate is used;
this prevents this.

Signed-off-by: Andrew de Quincey <adq_dvb@lidskialf.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/frontends/tda10086.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/media/dvb/frontends/tda10086.c b/drivers/media/dvb/frontends/tda10086.c
index 7456b0b..4c27a2d 100644
--- a/drivers/media/dvb/frontends/tda10086.c
+++ b/drivers/media/dvb/frontends/tda10086.c
@@ -441,6 +441,10 @@ static int tda10086_get_frontend(struct 
 
 	dprintk ("%s\n", __FUNCTION__);
 
+	// check for invalid symbol rate
+	if (fe_params->u.qpsk.symbol_rate < 500000)
+		return -EINVAL;
+
 	// calculate the updated frequency (note: we convert from Hz->kHz)
 	tmp64 = tda10086_read_byte(state, 0x52);
 	tmp64 |= (tda10086_read_byte(state, 0x51) << 8);

