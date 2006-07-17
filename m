Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWGQQeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWGQQeJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbWGQQdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:33:50 -0400
Received: from mail.kroah.org ([69.55.234.183]:51899 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750968AbWGQQdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:33:02 -0400
Date: Mon, 17 Jul 2006 09:26:23 -0700
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
Subject: [patch 08/45] v4l/dvb: Fix CI interface on PRO KNC1 cards
Message-ID: <20060717162623.GI4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="dvb-fix-ci-interface-on-pro-knc1-cards.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Andrew de Quincey <adq_dvb@lidskialf.net>

The original driver had a restriction that if a card as an saa7113 chip,
then it cannot have a CI interface. This is not the case.

Signed-off-by: Andrew de Quincey <adq_dvb@lidskialf.net>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/media/dvb/ttpci/budget-av.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- linux-2.6.17.3.orig/drivers/media/dvb/ttpci/budget-av.c
+++ linux-2.6.17.3/drivers/media/dvb/ttpci/budget-av.c
@@ -1218,11 +1218,7 @@ static int budget_av_attach(struct saa71
 
 	budget_av->budget.dvb_adapter.priv = budget_av;
 	frontend_init(budget_av);
-
-	if (!budget_av->has_saa7113) {
-		ciintf_init(budget_av);
-	}
-
+	ciintf_init(budget_av);
 	return 0;
 }
 

--
