Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932864AbVIHBc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932864AbVIHBc0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 21:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbVIHBbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 21:31:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52890 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932854AbVIHB3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 21:29:47 -0400
Message-Id: <20050908012903.190305000@localhost.localdomain>
References: <20050908012842.299637000@localhost.localdomain>
Date: Wed, 07 Sep 2005 18:28:49 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "David S. Miller" <davem@davemloft.net>, Chris Wright <chrisw@osdl.org>
Subject: [PATCH 7/9] [RTC]: Use SA_SHIRQ in sparc specific code.
Content-Disposition: inline; filename=sparc-request_irq-in-RTC-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any  objections, please let us know.
------------------

Based upon a report from Jason Wever.

Signed-off-by: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 drivers/char/rtc.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

Index: linux-2.6.13.y/drivers/char/rtc.c
===================================================================
--- linux-2.6.13.y.orig/drivers/char/rtc.c
+++ linux-2.6.13.y/drivers/char/rtc.c
@@ -938,10 +938,9 @@ found:
 
 	/*
 	 * XXX Interrupt pin #7 in Espresso is shared between RTC and
-	 * PCI Slot 2 INTA# (and some INTx# in Slot 1). SA_INTERRUPT here
-	 * is asking for trouble with add-on boards. Change to SA_SHIRQ.
+	 * PCI Slot 2 INTA# (and some INTx# in Slot 1).
 	 */
-	if (request_irq(rtc_irq, rtc_interrupt, SA_INTERRUPT, "rtc", (void *)&rtc_port)) {
+	if (request_irq(rtc_irq, rtc_interrupt, SA_SHIRQ, "rtc", (void *)&rtc_port)) {
 		/*
 		 * Standard way for sparc to print irq's is to use
 		 * __irq_itoa(). I think for EBus it's ok to use %d.

--
