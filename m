Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263155AbTKETl4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 14:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263157AbTKETl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 14:41:56 -0500
Received: from palrel10.hp.com ([156.153.255.245]:60815 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263155AbTKETl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 14:41:26 -0500
Date: Wed, 5 Nov 2003 11:41:25 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] IrLMP open leak
Message-ID: <20031105194125.GD24323@bougret.hpl.hp.com>
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

ir2609_irlmp_open_leak.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Original patch from Chris Wright>
	o [CORRECT] Prevent 'self' leak on error in irlmp_open.
		ASSERT is compiled in only with DEBUG option => risk = 0.


diff -u -p linux/net/irda/irlmp.d4.c linux/net/irda/irlmp.c
--- linux/net/irda/irlmp.d4.c	Tue Nov  4 10:52:38 2003
+++ linux/net/irda/irlmp.c	Tue Nov  4 10:53:46 2003
@@ -146,6 +146,7 @@ struct lsap_cb *irlmp_open_lsap(__u8 sls
 	ASSERT(notify != NULL, return NULL;);
 	ASSERT(irlmp != NULL, return NULL;);
 	ASSERT(irlmp->magic == LMP_MAGIC, return NULL;);
+	ASSERT(notify->instance != NULL, return NULL;);
 
 	/*  Does the client care which Source LSAP selector it gets?  */
 	if (slsap_sel == LSAP_ANY) {
@@ -178,7 +179,6 @@ struct lsap_cb *irlmp_open_lsap(__u8 sls
 
 	init_timer(&self->watchdog_timer);
 
-	ASSERT(notify->instance != NULL, return NULL;);
 	self->notify = *notify;
 
 	self->lsap_state = LSAP_DISCONNECTED;
