Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVC1JtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVC1JtV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 04:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVC1JtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 04:49:21 -0500
Received: from colino.net ([213.41.131.56]:32238 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S261443AbVC1JtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 04:49:16 -0500
Date: Mon, 28 Mar 2005 11:49:04 +0200
From: Colin Leroy <colin@colino.net>
To: linux-usb-devel@lists.sf.net
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: [PATCH] fix shared key auth in zd1201
Message-ID: <20050328114904.09291da8@jack.colino.net>
X-Mailer: Sylpheed-Claws 1.9.6cvs9 (GTK+ 2.6.1; powerpc-unknown-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is a resend of a patch that Andrew put in -mm, but that I think is
ok and should go into mainline. I did not get any feedback (positive or
negative) about it. Please either apply it or explain why not...

It's currently impossible to associate with a shared-key-only access
point using the zd1201 driver. The attached patch fixes it. The reason
was (probably) a typo in the definitions of the authentification types.
I found that they should be (1,2) instead of (0,1) by looking at the
old linux-wlan-ng driver by Zydas.

Signed-off-by: Colin Leroy <colin@colino.net>
--- a/drivers/usb/net/zd1201.h	2005-03-25 09:14:49.000000000 +0100
+++ b/drivers/usb/net/zd1201.h	2005-03-25 09:11:59.000000000 +0100
@@ -141,7 +141,7 @@
 #define ZD1201_RATEB5	4	/* 5.5 really, but 5 is shorter :) */
 #define ZD1201_RATEB11	8
 
-#define ZD1201_CNFAUTHENTICATION_OPENSYSTEM	0
-#define ZD1201_CNFAUTHENTICATION_SHAREDKEY	1
+#define ZD1201_CNFAUTHENTICATION_OPENSYSTEM	0x0001
+#define ZD1201_CNFAUTHENTICATION_SHAREDKEY	0x0002
 
 #endif /* _INCLUDE_ZD1201_H_ */
