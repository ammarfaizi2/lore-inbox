Return-Path: <linux-kernel-owner+w=401wt.eu-S1751139AbXAFCdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbXAFCdg (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbXAFCdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:33:16 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36881 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136AbXAFCcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:32:55 -0500
Message-Id: <20070106023649.065310000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:39 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Hollis <dhollis@davehollis.com>
Subject: [patch 46/50] asix: Fix typo for AX88772 PHY Selection
Content-Disposition: inline; filename=asix-fix-typo-for-ax88772-phy-selection.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: David Hollis <dhollis@davehollis.com>

The attached patch fixes a PHY selection problem that prevents AX88772
based devices (Linksys USB200Mv2, etc) devices from working.  The
interface comes up and everything seems fine except the device doesn't
send/receive any packets.  The one-liner attached fixes this issue and
makes the devices usable again.

Signed-off-by: David Hollis <dhollis@davehollis.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
Patch has already been applied for 2.6.20+ kernels but it would be very
helpful for end-users/distributions to have this fixed in the 2.6.19
series as well.

 drivers/usb/net/asix.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19.1.orig/drivers/usb/net/asix.c
+++ linux-2.6.19.1/drivers/usb/net/asix.c
@@ -920,7 +920,7 @@ static int ax88772_bind(struct usbnet *d
 		goto out2;
 
 	if ((ret = asix_write_cmd(dev, AX_CMD_SW_PHY_SELECT,
-				0x0000, 0, 0, buf)) < 0) {
+				1, 0, 0, buf)) < 0) {
 		dbg("Select PHY #1 failed: %d", ret);
 		goto out2;
 	}

--
