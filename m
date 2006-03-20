Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965299AbWCTP0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965299AbWCTP0Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965304AbWCTP0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:26:24 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:36280 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965302AbWCTP0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:26:18 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mattias Nordstrom <nordstrom@realnode.com>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 112/141] V4L/DVB (3382): Fix stv0297 for qam128 on tt c1500
	(saa7146)
Date: Mon, 20 Mar 2006 12:08:55 -0300
Message-id: <20060320150855.PS676698000112@infradead.org>
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

From: Mattias Nordstrom <nordstrom@realnode.com>
Date: 1141009757 -0300

I have a TT C1500 card (saa7146, STV0297) which had problems tuning
channels at QAM128 (like the ones in the Finnish HTV / Welho network).
A fix which seems to work perfectly so far is to change the delay for
QAM128 to the same values as for QAM256 in stv0297_set_frontend(),

Signed-off-by: Mattias Nordstrom <nordstrom@realnode.com>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/dvb/frontends/stv0297.c b/drivers/media/dvb/frontends/stv0297.c
diff --git a/drivers/media/dvb/frontends/stv0297.c b/drivers/media/dvb/frontends/stv0297.c
index 6122ba7..eb15676 100644
--- a/drivers/media/dvb/frontends/stv0297.c
+++ b/drivers/media/dvb/frontends/stv0297.c
@@ -393,10 +393,6 @@ static int stv0297_set_frontend(struct d
 		break;
 
 	case QAM_128:
-		delay = 150;
-		sweeprate = 1000;
-		break;
-
 	case QAM_256:
 		delay = 200;
 		sweeprate = 500;

