Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbUDNWWO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 18:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbUDNWVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 18:21:55 -0400
Received: from palrel11.hp.com ([156.153.255.246]:26040 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261925AbUDNWVP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 18:21:15 -0400
Date: Wed, 14 Apr 2004 15:20:59 -0700
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] irlan -- replace sleep_on with wait_event
Message-ID: <20040414222059.GI5434@bougret.hpl.hp.com>
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

irXXX_irlan_sleep.diff :
~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [CORRECT] gets rid of interruptible_sleep_on.


diff -Nru a/net/irda/irlan/irlan_eth.c b/net/irda/irlan/irlan_eth.c
--- a/net/irda/irlan/irlan_eth.c	Fri Mar 19 11:43:53 2004
+++ b/net/irda/irlan/irlan_eth.c	Fri Mar 19 11:43:53 2004
@@ -104,10 +104,10 @@
 	self->disconnect_reason = 0;
 	irlan_client_wakeup(self, self->saddr, self->daddr);
 
-	/* Make sure we have a hardware address before we return, so DHCP clients gets happy */
-	interruptible_sleep_on(&self->open_wait);
-	
-	return 0;
+	/* Make sure we have a hardware address before we return, 
+	   so DHCP clients gets happy */
+	return wait_event_interruptible(self->open_wait,
+					!self->tsap_data->connected);
 }
 
 /*
