Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262931AbUKRTUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbUKRTUc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 14:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262929AbUKRTTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 14:19:14 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:57864 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S262928AbUKRTSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 14:18:15 -0500
Date: Thu, 18 Nov 2004 14:14:35 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Cc: cgoos@syskonnect.de, mlindner@syskonnect.de, jgarzik@pobox.com
Subject: [patch netdev-2.6] skge: return 0 on success from SkGeChangeMtu
Message-ID: <20041118141435.B16007@tuxdriver.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
	cgoos@syskonnect.de, mlindner@syskonnect.de, jgarzik@pobox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The SKGE driver needs to return 0 from SkGeChangeMtu() on success.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
The proper sucessful return code for the change_mtu() method is zero.
For some reason, SkGeChangeMtu() is returning the new mtu value
instead.  The comments would seem to indicate past problems, but the
current correct behaviour is clear.

 drivers/net/sk98lin/skge.c |   14 +-------------
 1 files changed, 1 insertion(+), 13 deletions(-)

--- 1.54/drivers/net/sk98lin/skge.c	2004-11-03 17:31:05 -05:00
+++ 1.55/drivers/net/sk98lin/skge.c	2004-11-18 11:12:36 -05:00
@@ -2849,19 +2849,7 @@
 	SkEventDispatcher(pAC, pAC->IoBase);
 	spin_unlock_irqrestore(&pAC->SlowPathLock, Flags);
 	
-	/*
-	** While testing this driver with latest kernel 2.5 (2.5.70), it 
-	** seems as if upper layers have a problem to handle a successful
-	** return value of '0'. If such a zero is returned, the complete 
-	** system hangs for several minutes (!), which is in acceptable.
-	**
-	** Currently it is not clear, what the exact reason for this problem
-	** is. The implemented workaround for 2.5 is to return the desired 
-	** new MTU size if all needed changes for the new MTU size where 
-	** performed. In kernels 2.2 and 2.4, a zero value is returned,
-	** which indicates the successful change of the mtu-size.
-	*/
-	return NewMtu;
+	return 0;
 
 } /* SkGeChangeMtu */
 
