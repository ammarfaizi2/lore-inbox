Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965664AbWCTQBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965664AbWCTQBL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966508AbWCTPRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:17:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49048 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965204AbWCTPRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:17:13 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Manu Abraham <manu@linxtv.org>,
       Manu Abraham <manu@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 115/141] V4L/DVB (3388): Ignore DiSEqC messages > 6 and < 3
Date: Mon, 20 Mar 2006 12:08:56 -0300
Message-id: <20060320150856.PS274255000115@infradead.org>
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

From: Manu Abraham <manu@linxtv.org>
Date: 1141009765 -0300

Ignore invalid messages on cx24110 frontend.
Thanks to Edgar Toernig

Signed-off-by: Manu Abraham <manu@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/dvb/frontends/cx24110.c b/drivers/media/dvb/frontends/cx24110.c
diff --git a/drivers/media/dvb/frontends/cx24110.c b/drivers/media/dvb/frontends/cx24110.c
index d15d32c..cc68b7e 100644
--- a/drivers/media/dvb/frontends/cx24110.c
+++ b/drivers/media/dvb/frontends/cx24110.c
@@ -418,6 +418,9 @@ static int cx24110_send_diseqc_msg(struc
 	struct cx24110_state *state = fe->demodulator_priv;
 	unsigned long timeout;
 
+	if (cmd->msg_len < 3 || cmd->msg_len > 6)
+		return -EINVAL;  /* not implemented */
+
 	for (i = 0; i < cmd->msg_len; i++)
 		cx24110_writereg(state, 0x79 + i, cmd->msg[i]);
 

