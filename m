Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbWAWTzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbWAWTzs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 14:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWAWTzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 14:55:48 -0500
Received: from gate.crashing.org ([63.228.1.57]:9891 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932466AbWAWTzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 14:55:47 -0500
Date: Mon, 23 Jan 2006 13:48:21 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: dbrownell@users.sourceforge.net
cc: Randy Vinson <rvinson@mvista.com>, <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: [PATCH] USB: Fix masking bug initialization of Freescale EHCI
 controller  
Message-ID: <Pine.LNX.4.44.0601231346470.16800-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In setting up the of PHY we masked off too many bits, instead just
initialize PORTSC for the type of PHY we are using.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 2497a5e4242d500178d6d0f0ce4ee9249a38f5dc
tree 71f036ecd23dffb224963b4aabe4f857ba99845b
parent fe49a3f53c2572bf26a9dfd77e54fda1aa853887
author Kumar Gala <galak@kernel.crashing.org> Mon, 23 Jan 2006 13:53:09 -0600
committer Kumar Gala <galak@kernel.crashing.org> Mon, 23 Jan 2006 13:53:09 -0600

 drivers/usb/host/ehci-fsl.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 6d82054..f40ee41 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -160,8 +160,7 @@ static void mpc83xx_setup_phy(struct ehc
 			      enum fsl_usb2_phy_modes phy_mode,
 			      unsigned int port_offset)
 {
-	u32 portsc = readl(&ehci->regs->port_status[port_offset]);
-	portsc &= ~PORT_PTS_MSK;
+	u32 portsc = 0;
 	switch (phy_mode) {
 	case FSL_USB2_PHY_ULPI:
 		portsc |= PORT_PTS_ULPI;

