Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWJANdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWJANdf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 09:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWJANdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 09:33:35 -0400
Received: from havoc.gtf.org ([69.61.125.42]:11240 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932157AbWJANde (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 09:33:34 -0400
Date: Sun, 1 Oct 2006 09:33:32 -0400
From: Jeff Garzik <jeff@garzik.org>
To: chas@cmf.nrl.navy.mil, netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] atm/ambassador: fix return code bug
Message-ID: <20061001133332.GA32354@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While auditing a 'may be used uninitialized' warning, I found a minor
bug:  make_rate() has the standard error code convention -- zero for
success, negative errno on error -- but its return type is defined as
unsigned.

Change the return type to reflect reality.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

diff --git a/drivers/atm/ambassador.c b/drivers/atm/ambassador.c
index 4521a24..da599e6 100644
--- a/drivers/atm/ambassador.c
+++ b/drivers/atm/ambassador.c
@@ -915,8 +915,8 @@ #endif
 
 /********** make rate (not quite as much fun as Horizon) **********/
 
-static unsigned int make_rate (unsigned int rate, rounding r,
-			       u16 * bits, unsigned int * actual) {
+static int make_rate (unsigned int rate, rounding r,
+		      u16 * bits, unsigned int * actual) {
   unsigned char exp = -1; // hush gcc
   unsigned int man = -1;  // hush gcc
   
