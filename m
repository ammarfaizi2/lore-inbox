Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030920AbWKUM65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030920AbWKUM65 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 07:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030923AbWKUM65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 07:58:57 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:23238 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030920AbWKUM64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 07:58:56 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Andrew de Quincey <adq_dvb@lidskialf.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 1/5] V4L/DVB (4831): Fix tuning on older budget DVBS cards.
Date: Tue, 21 Nov 2006 10:38:50 -0200
Message-id: <20061121123850.PS2194390001@infradead.org>
In-Reply-To: <20061121123202.PS8610150000@infradead.org>
References: <20061121123202.PS8610150000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Andrew de Quincey <adq_dvb@lidskialf.net>

Fixes to DISEQC on these cards inadvertently broke normal tone/voltage
signalling. This restores the necessary function.

Signed-off-by: Andrew de Quincey <adq_dvb@lidskialf.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/ttpci/budget.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/media/dvb/ttpci/budget.c b/drivers/media/dvb/ttpci/budget.c
index e58f039..e28617b 100644
--- a/drivers/media/dvb/ttpci/budget.c
+++ b/drivers/media/dvb/ttpci/budget.c
@@ -382,6 +382,7 @@ static void frontend_init(struct budget 
 		if (budget->dvb_frontend) {
 			budget->dvb_frontend->ops.tuner_ops.set_params = alps_bsru6_tuner_set_params;
 			budget->dvb_frontend->tuner_priv = &budget->i2c_adap;
+			budget->dvb_frontend->ops.set_tone = budget_set_tone;
 			break;
 		}
 		break;

