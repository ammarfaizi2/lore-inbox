Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270263AbUJTBUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270263AbUJTBUo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 21:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270264AbUJTBEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 21:04:08 -0400
Received: from palrel10.hp.com ([156.153.255.245]:30619 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S270248AbUJTBC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 21:02:28 -0400
Date: Tue, 19 Oct 2004 18:02:27 -0700
To: "David S. Miller" <davem@davemloft.net>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] Fix nsc-ircc dongle_id input
Message-ID: <20041020010227.GC12932@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir269_nsc_dongle-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~
		<Original patch from Maik Broemme>
	o [CRITICA] Don't Oops on invalid dongle-id in nsc-ircc driver
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>


diff -u -p linux/drivers/net/irda/nsc-ircc.d0.c linux/drivers/net/irda/nsc-ircc.c
--- linux/drivers/net/irda/nsc-ircc.d0.c	Fri Oct 15 15:30:40 2004
+++ linux/drivers/net/irda/nsc-ircc.c	Fri Oct 15 15:32:20 2004
@@ -351,8 +351,9 @@ static int __init nsc_ircc_open(int i, c
 	}
 	MESSAGE("IrDA: Registered device %s\n", dev->name);
 
-	/* Check if user has supplied the dongle id or not */
-	if (!dongle_id) {
+	/* Check if user has supplied a valid dongle id or not */
+	if ((dongle_id <= 0) ||
+	    (dongle_id >= (sizeof(dongle_types) / sizeof(dongle_types[0]))) ) {
 		dongle_id = nsc_ircc_read_dongle_id(self->io.fir_base);
 		
 		MESSAGE("%s, Found dongle: %s\n", driver_name,
