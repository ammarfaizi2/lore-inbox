Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268893AbTGJAH4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 20:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268709AbTGIXfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 19:35:22 -0400
Received: from palrel11.hp.com ([156.153.255.246]:17817 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S268741AbTGIXfI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 19:35:08 -0400
Date: Wed, 9 Jul 2003 16:49:44 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5 IrDA] struct check
Message-ID: <20030709234944.GC12747@bougret.hpl.hp.com>
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

ir250_struct_check.diff :
~~~~~~~~~~~~~~~~~~~~~~~
		<Suggested by Russell King>
	o [FEATURE] Add struct size check for buggy compilers


diff -u -p linux/net/irda/irlap.d2.c linux/net/irda/irlap.c
--- linux/net/irda/irlap.d2.c	Wed Jun  4 15:17:05 2003
+++ linux/net/irda/irlap.c	Wed Jun  4 15:21:29 2003
@@ -79,6 +79,13 @@ int irlap_proc_read(char *, char **, off
 
 int __init irlap_init(void)
 {
+	/* Check if the compiler did its job properly.
+	 * May happen on some ARM configuration, check with Russell King. */
+	ASSERT(sizeof(struct xid_frame) == 14, ;);
+	ASSERT(sizeof(struct test_frame) == 10, ;);
+	ASSERT(sizeof(struct ua_frame) == 10, ;);
+	ASSERT(sizeof(struct snrm_frame) == 11, ;);
+
 	/* Allocate master array */
 	irlap = hashbin_new(HB_LOCK);
 	if (irlap == NULL) {
