Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946534AbWKAF4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946534AbWKAF4Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946223AbWKAFgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:36:10 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:16327 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946149AbWKAFf1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:35:27 -0500
Message-Id: <20061101053541.928017000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:33:46 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Stephen Hemminger <shemminger@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 06/61] sky2: pause parameter adjustment
Content-Disposition: inline; filename=sky2-pause-parameter-adjustment.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Stephen Hemminger <shemminger@osdl.org>

The lower pause threshold set by the driver is too large and causes FIFO overruns.
Especially on laptops running at slower clock rates.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>


---
 drivers/net/sky2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.18.1.orig/drivers/net/sky2.c
+++ linux-2.6.18.1/drivers/net/sky2.c
@@ -678,7 +678,7 @@ static void sky2_mac_init(struct sky2_hw
 	sky2_write16(hw, SK_REG(port, TX_GMF_CTRL_T), GMF_OPER_ON);
 
 	if (hw->chip_id == CHIP_ID_YUKON_EC_U) {
-		sky2_write8(hw, SK_REG(port, RX_GMF_LP_THR), 768/8);
+		sky2_write8(hw, SK_REG(port, RX_GMF_LP_THR), 512/8);
 		sky2_write8(hw, SK_REG(port, RX_GMF_UP_THR), 1024/8);
 		if (hw->dev[port]->mtu > ETH_DATA_LEN) {
 			/* set Tx GMAC FIFO Almost Empty Threshold */

--
