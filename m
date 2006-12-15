Return-Path: <linux-kernel-owner+w=401wt.eu-S964919AbWLOBdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbWLOBdi (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 20:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbWLOBdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 20:33:38 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:46015 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964947AbWLOBdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 20:33:37 -0500
Message-Id: <20061215013622.956024000@sous-sol.org>
References: <20061215013337.823935000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Thu, 14 Dec 2006 17:33:47 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Miller <davem@davemloft.net>,
       Jurij Smakov <jurij@wooyd.org>
Subject: [patch 10/24] SUNHME: Fix for sunhme failures on x86
Content-Disposition: inline; filename=sunhme-fix-for-sunhme-failures-on-x86.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.18-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Jurij Smakov <jurij@wooyd.org>

The following patch fixes the failure of sunhme drivers on x86 hosts
due to missing pci_enable_device() and pci_set_master() calls, lost
during code refactoring. It has been filed as bugzilla bug #7502 [0]
and Debian bug #397460 [1].

[0] http://bugzilla.kernel.org/show_bug.cgi?id=7502
[1] http://bugs.debian.org/397460

Signed-off-by: Jurij Smakov <jurij@wooyd.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 drivers/net/sunhme.c |    5 +++++
 1 file changed, 5 insertions(+)

--- linux-2.6.18.5.orig/drivers/net/sunhme.c
+++ linux-2.6.18.5/drivers/net/sunhme.c
@@ -3012,6 +3012,11 @@ static int __devinit happy_meal_pci_prob
 #endif
 
 	err = -ENODEV;
+
+	if (pci_enable_device(pdev))
+		goto err_out;
+	pci_set_master(pdev);
+
 	if (!strcmp(prom_name, "SUNW,qfe") || !strcmp(prom_name, "qfe")) {
 		qp = quattro_pci_find(pdev);
 		if (qp == NULL)

--
