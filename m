Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271357AbTG2JdJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 05:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271356AbTG2Jbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 05:31:45 -0400
Received: from mail.convergence.de ([212.84.236.4]:41438 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S271359AbTG2Jam convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 05:30:42 -0400
Subject: [PATCH 2/6] [DVB] DVB core update
In-Reply-To: <10594710302828@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Tue, 29 Jul 2003 11:30:30 +0200
Message-Id: <10594710303674@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, torvalds@osdl.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) 
	<hunold@convergence.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[DVB] - if there are multiple adapters, bend the tuning frequency only if the adapters differ
diff -uNrwB --new-file linux-2.6.0-test2.work/drivers/media/dvb/dvb-core/dvb_frontend.c linux-2.6.0-test2.patch/drivers/media/dvb/dvb-core/dvb_frontend.c
--- linux-2.6.0-test2.work/drivers/media/dvb/dvb-core/dvb_frontend.c	2003-07-29 09:10:18.000000000 +0200
+++ linux-2.6.0-test2.patch/drivers/media/dvb/dvb-core/dvb_frontend.c	2003-07-29 09:17:52.000000000 +0200
@@ -134,6 +134,7 @@
 {
 	struct list_head *entry;
 	int stepsize = this_fe->info->frequency_stepsize;
+	int this_fe_adap_num = this_fe->frontend.i2c->adapter->num;
 	int frequency;
 
 	if (!stepsize || recursive > 10) {
@@ -157,6 +158,9 @@
 
 		fe = list_entry (entry, struct dvb_frontend_data, list_head);
 
+		if (fe->frontend.i2c->adapter->num != this_fe_adap_num)
+			continue;
+
 		f = fe->parameters.frequency;
 		f += fe->lnb_drift;
 		f += fe->bending;

