Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262823AbTIEVqT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 17:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265100AbTIEVnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 17:43:52 -0400
Received: from palrel10.hp.com ([156.153.255.245]:58815 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262823AbTIEVlX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 17:41:23 -0400
Date: Fri, 5 Sep 2003 14:41:22 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] IrCOMM mod refcount
Message-ID: <20030905214122.GB14233@bougret.hpl.hp.com>
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

ir2604_ircomm_owner-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [FEATURE] Finish removing traces of old module refcount stuff


diff -u -p linux/net/irda/ircomm/ircomm_tty.d2.c linux/net/irda/ircomm/ircomm_tty.c
--- linux/net/irda/ircomm/ircomm_tty.d2.c	Wed Sep  3 18:16:39 2003
+++ linux/net/irda/ircomm/ircomm_tty.c	Wed Sep  3 18:18:01 2003
@@ -441,7 +441,6 @@ static int ircomm_tty_open(struct tty_st
 			return -ERESTARTSYS;
 		}
 
-		/* MOD_DEC_USE_COUNT; "info->tty" will cause this? */
 #ifdef SERIAL_DO_RESTART
 		return ((self->flags & ASYNC_HUP_NOTIFY) ?
 			-EAGAIN : -ERESTARTSYS);
@@ -469,7 +468,6 @@ static int ircomm_tty_open(struct tty_st
 
 	ret = ircomm_tty_block_til_ready(self, filp);
 	if (ret) {
-		/* MOD_DEC_USE_COUNT; "info->tty" will cause this? */
 		IRDA_DEBUG(2, 
 		      "%s(), returning after block_til_ready with %d\n", __FUNCTION__ ,
 		      ret);
