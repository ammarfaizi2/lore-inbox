Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270711AbTHFL3h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 07:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270715AbTHFL3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 07:29:37 -0400
Received: from [203.145.184.221] ([203.145.184.221]:34831 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S270711AbTHFL3f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 07:29:35 -0400
From: "Krishnakumar. R" <krishnakumar@naturesoft.net>
Reply-To: krishnakumar@naturesoft.net
Organization: Naturesoft
To: john@larvalstage.com
Subject: [PATCH - 2.6.0-test2][BUG #568]compile failure in drivers/isdn/hisax/diva.c 
Date: Wed, 6 Aug 2003 17:01:47 +0530
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, antonio_floresta@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308061701.47675.krishnakumar@naturesoft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

Here is the patch which will enable the compilation of the diva.c file.

I succeded in compiling the diva.c with this patch.
But could not do any run time test,  as I dont have the 
hardware.

So could you please apply this and try out.

The patch is against 2.6.0-test2.

Regards
KK


===========================================================
diffstat output:

diva.c |   22 +++++++++++-----------
1 files changed, 11 insertions(+), 11 deletions(-)

===========================================================

The following is the patch.




--- linux-2.6.0-test2/drivers/isdn/hisax/diva.orig.c	2003-08-05 22:22:04.000000000 +0530
+++ linux-2.6.0-test2/drivers/isdn/hisax/diva.c	2003-08-05 22:41:42.000000000 +0530
@@ -751,24 +751,24 @@
 					card->para[1] = pnp_port_start(pd, 0);
 					card->para[0] = pnp_irq(pd, 0);
 					if (pdev->function == ISAPNP_FUNCTION(0xA1)) {
-						if (diva_ipac_isa_probe(cs->card, cs))
+						if (diva_ipac_isa_probe(card->cs, card))
 							return 0;
 						return 1;
 					} else {
-						if (diva_isac_isa_probe(cs->card, cs))
+						if (diva_isac_isa_probe(card->cs, card))
 							return 0;
 						return 1;
-					} else {
-						printk(KERN_ERR "Diva PnP: PnP error card found, no device\n");
-						return(0);
-					}
+					} 
+				}else {
+					printk(KERN_ERR "Diva PnP: PnP error card found, no device\n");
+					return(0);
 				}
-				pdev++;
-				pnp_c=NULL;
-			} 
-			if (!pdev->card_vendor) {
-				printk(KERN_INFO "Diva PnP: no ISAPnP card found\n");
 			}
+			pdev++;
+			pnp_c=NULL;
+		}
+		if (!pdev->card_vendor) {
+			printk(KERN_INFO "Diva PnP: no ISAPnP card found\n");
 		}
 	}
 #endif







