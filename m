Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbVJDMn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbVJDMn1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 08:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbVJDMnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 08:43:08 -0400
Received: from mailgate2.urz.uni-halle.de ([141.48.3.8]:31459 "EHLO
	mailgate2.uni-halle.de") by vger.kernel.org with ESMTP
	id S932407AbVJDMm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 08:42:58 -0400
Date: Tue, 04 Oct 2005 14:41:48 +0200 (MEST)
From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 4/7] HPET: fix uninitialized variable in hpet_register()
In-reply-to: <20051004124126.23057.75614.schnuffi@turing>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Bob Picco <bob.picco@hp.com>,
       Clemens Ladisch <clemens@ladisch.de>
Message-id: <20051004124148.23057.31736.schnuffi@turing>
Content-transfer-encoding: 7BIT
References: <20051004124126.23057.75614.schnuffi@turing>
X-Scan-Signature: 8a46a9913181300b63c8a1b6a7c824fb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clemens Ladisch <clemens@ladisch.de>

Clear the ht_opaque field in the hpet_register() function before
searching for a free timer to prevent the function from incorrectly
assuming that the search succeeded afterwards.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

Index: linux-2.6.13/drivers/char/hpet.c
===================================================================
--- linux-2.6.13.orig/drivers/char/hpet.c	2005-10-03 22:53:15.000000000 +0200
+++ linux-2.6.13/drivers/char/hpet.c	2005-10-03 22:53:18.000000000 +0200
@@ -587,6 +587,8 @@ int hpet_register(struct hpet_task *tp, 
 		return -EINVAL;
 	}
 
+	tp->ht_opaque = NULL;
+
 	spin_lock_irq(&hpet_task_lock);
 	spin_lock(&hpet_lock);
 
