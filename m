Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269936AbUJWB6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269936AbUJWB6q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 21:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269852AbUJWBue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 21:50:34 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:12044 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S269805AbUJWBs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 21:48:29 -0400
Date: Fri, 22 Oct 2004 21:49:24 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: [patch netdev-2.6 3/3] r8169: simplify trick if() expression
Message-ID: <20041023014923.GB32031@tuxdriver.com>
Mail-Followup-To: Francois Romieu <romieu@fr.zoreil.com>,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com
References: <20041022005737.GA1945@tuxdriver.com> <20041022202851.GB4216@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022202851.GB4216@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify tricky if() expression in rtl8169_vlan_rx_register().

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
You're probably right -- the "if ((tp->vlgrp = grp))" line is probably
a little TOO clever... :-)

 drivers/net/r8169.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

--- ./drivers/net/r8169.c.orig	2004-10-22 21:44:06.050154952 -0400
+++ ./drivers/net/r8169.c	2004-10-22 21:44:26.228087440 -0400
@@ -703,7 +703,8 @@ static void rtl8169_vlan_rx_register(str
 	unsigned long flags;
 
 	spin_lock_irqsave(&tp->lock, flags);
-	if ((tp->vlgrp = grp))
+	tp->vlgrp = grp;
+	if (tp->vlgrp)
 		tp->cp_cmd |= RxVlan;
 	else
 		tp->cp_cmd &= ~RxVlan;
