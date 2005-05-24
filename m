Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262087AbVEXKnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbVEXKnX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 06:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVEXKnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 06:43:11 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:384 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262063AbVEXKlS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 06:41:18 -0400
Date: Tue, 24 May 2005 12:42:07 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Message-ID: <20050524104207.GB32020@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Patrick Boettcher <pb@linuxtv.org>
References: <20050522235233.190143000@abc> <20050522235336.731021000@abc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050522235336.731021000@abc>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: 84.189.230.54
Subject: Re: [DVB patch 5/5] flexcop: add BCM3510 ATSC frontend support for Air2PC card
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

here's an incremental patch which fixes the following warning
when compiling with gcc-3.4.4:

drivers/media/dvb/frontends/bcm3510.c: In function `bcm3510_read_signal_strength':
drivers/media/dvb/frontends/bcm3510.c:322: warning: ISO C90 forbids mixed declarations and code


Johannes

---
Fix compilation with gcc-2.95 (warning with gcc-3.4.4) by
not mixing code and declarations.

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/frontends/bcm3510.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6.12-rc4-git3/drivers/media/dvb/frontends/bcm3510.c
===================================================================
--- linux-2.6.12-rc4-git3.orig/drivers/media/dvb/frontends/bcm3510.c	2005-05-23 01:27:27.000000000 +0200
+++ linux-2.6.12-rc4-git3/drivers/media/dvb/frontends/bcm3510.c	2005-05-24 12:33:50.000000000 +0200
@@ -318,8 +318,10 @@ static int bcm3510_read_unc(struct dvb_f
 static int bcm3510_read_signal_strength(struct dvb_frontend* fe, u16* strength)
 {
 	struct bcm3510_state* st = fe->demodulator_priv;
+	s32 t;
+
 	bcm3510_refresh_state(st);
-	s32 t = st->status2.SIGNAL;
+	t = st->status2.SIGNAL;
 
 	if (t > 190)
 		t = 190;
