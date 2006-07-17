Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbWGQQd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWGQQd3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbWGQQc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:32:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:36795 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750963AbWGQQcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:32:52 -0400
Date: Mon, 17 Jul 2006 09:26:17 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Andrew de Quincey <adq_dvb@lidskialf.net>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Chris Wright <chrisw@sous-sol.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 07/45] v4l/dvb: Fix CI on old KNC1 DVBC cards
Message-ID: <20060717162617.GH4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="dvb-fix-ci-on-old-knc1-dvbc-cards.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Andrew de Quincey <adq_dvb@lidskialf.net>

These cards do not need the tda10021 configuration change when data is
streamed through a CAM module. This disables it for these ones.

Signed-off-by: Andrew de Quincey <adq_dvb@lidskialf.net>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/media/dvb/ttpci/budget-av.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- linux-2.6.17.3.orig/drivers/media/dvb/ttpci/budget-av.c
+++ linux-2.6.17.3/drivers/media/dvb/ttpci/budget-av.c
@@ -1060,6 +1060,15 @@ static void frontend_init(struct budget_
 		break;
 
 	case SUBID_DVBC_KNC1:
+		budget_av->reinitialise_demod = 1;
+		fe = tda10021_attach(&philips_cu1216_config,
+				     &budget_av->budget.i2c_adap,
+				     read_pwm(budget_av));
+		if (fe) {
+			fe->ops.tuner_ops.set_params = philips_cu1216_tuner_set_params;
+		}
+		break;
+
 	case SUBID_DVBC_KNC1_PLUS:
 		fe = tda10021_attach(&philips_cu1216_config,
 				     &budget_av->budget.i2c_adap,

--
