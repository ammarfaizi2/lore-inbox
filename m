Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbWGQQiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWGQQiT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbWGQQdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:33:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:2748 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750973AbWGQQdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:33:13 -0400
Date: Mon, 17 Jul 2006 09:26:05 -0700
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
Subject: [patch 06/45] v4l/dvb: Fix budget-av frontend detection
Message-ID: <20060717162605.GG4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="dvb-fix-budget-av-frontend-detection.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Andrew de Quincey <adq_dvb@lidskialf.net>

The budget-av needs this GPIO set low for most cards to work.

Signed-off-by: Andrew de Quincey <adq_dvb@lidskialf.net>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/media/dvb/ttpci/budget-av.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.17.3.orig/drivers/media/dvb/ttpci/budget-av.c
+++ linux-2.6.17.3/drivers/media/dvb/ttpci/budget-av.c
@@ -1017,12 +1017,13 @@ static void frontend_init(struct budget_
 	struct saa7146_dev * saa = budget_av->budget.dev;
 	struct dvb_frontend * fe = NULL;
 
+	/* Enable / PowerON Frontend */
+	saa7146_setgpio(saa, 0, SAA7146_GPIO_OUTLO);
+
 	switch (saa->pci->subsystem_device) {
 		case SUBID_DVBS_KNC1_PLUS:
 		case SUBID_DVBC_KNC1_PLUS:
 		case SUBID_DVBT_KNC1_PLUS:
-			// Enable / PowerON Frontend
-			saa7146_setgpio(saa, 0, SAA7146_GPIO_OUTLO);
 			saa7146_setgpio(saa, 3, SAA7146_GPIO_OUTHI);
 			break;
 	}

--
