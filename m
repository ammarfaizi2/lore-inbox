Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264082AbTFDVSl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 17:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264087AbTFDVSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 17:18:41 -0400
Received: from air-2.osdl.org ([65.172.181.6]:39845 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264082AbTFDVSk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 17:18:40 -0400
Date: Wed, 4 Jun 2003 14:32:34 -0700
From: Dave Olien <dmo@osdl.org>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH} DAC960 fix for fibre channel transfer rate
Message-ID: <20030604213233.GA15900@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew, could you push this into 2.5 for me?  I got the patch originally
from Michael Griffith <grif@michaelgriffith.com>.  I've looked it over
and tested it on the equipment I have.  The change makes the transfer
rate numbers come out right for the fibre channel version of this controller.

For 1G FC, the NegotiatedSynchronousMegaTransfers is 1000, and the
NegotiatedDataWidthBIts is 1.  The old code assumed NegotiatedDataWidthBits
was always either 8 or 16.  The new code is simpler, and does the calculation
correctly for all cases.

Thanks!
Dave Olien


--- linux-2.5.70/drivers/block/DAC960.c	Mon May 26 18:00:45 2003
+++ linux-grif/drivers/block/DAC960.c	Fri May 30 23:46:23 2003
@@ -2309,8 +2309,7 @@
 		    (PhysicalDeviceInfo->NegotiatedDataWidthBits == 16
 		     ? "Wide " :""),
 		    (PhysicalDeviceInfo->NegotiatedSynchronousMegaTransfers
-		     * (PhysicalDeviceInfo->NegotiatedDataWidthBits == 16
-			? 2 : 1)));
+		     * PhysicalDeviceInfo->NegotiatedDataWidthBits/8));
       if (InquiryUnitSerialNumber->PeripheralDeviceType != 0x1F)
 	DAC960_Info("         Serial Number: %s\n", Controller, SerialNumber);
       if (PhysicalDeviceInfo->PhysicalDeviceState ==


