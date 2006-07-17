Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbWGQQd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWGQQd3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbWGQQc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:32:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:62138 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750939AbWGQQc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:32:27 -0400
Date: Mon, 17 Jul 2006 09:27:24 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Oliver Endriss <o.endriss@gmx.de>,
       Andrew de Quincey <adq_dvb@lidskialf.net>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Chris Wright <chrisw@sous-sol.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 19/45] v4l/dvb: Backport the budget driver DISEQC instability fix
Message-ID: <20060717162724.GT4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="v4l-dvb-backport-the-budget-driver-diseqc-instability-fix.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Oliver Endriss <o.endriss@gmx.de>

Backport the budget driver DISEQC instability fix.

Signed-off-by: Oliver Endriss <o.endriss@gmx.de>
Signed-off-by: Andrew de Quincey <adq_dvb@lidskialf.net>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/media/dvb/ttpci/budget.c |    6 ------
 1 file changed, 6 deletions(-)

--- linux-2.6.17.3.orig/drivers/media/dvb/ttpci/budget.c
+++ linux-2.6.17.3/drivers/media/dvb/ttpci/budget.c
@@ -367,12 +367,6 @@ static void frontend_init(struct budget 
 
 		// try the ALPS BSRU6 now
 		budget->dvb_frontend = stv0299_attach(&alps_bsru6_config, &budget->i2c_adap);
-		if (budget->dvb_frontend) {
-			budget->dvb_frontend->ops->diseqc_send_master_cmd = budget_diseqc_send_master_cmd;
-			budget->dvb_frontend->ops->diseqc_send_burst = budget_diseqc_send_burst;
-			budget->dvb_frontend->ops->set_tone = budget_set_tone;
-			break;
-		}
 		break;
 
 	case 0x1004: // Hauppauge/TT DVB-C budget (ves1820/ALPS TDBE2(sp5659))

--
