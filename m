Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265440AbTHOQEw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 12:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbTHOQEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 12:04:52 -0400
Received: from [203.145.184.221] ([203.145.184.221]:35590 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S265440AbTHOQDf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 12:03:35 -0400
From: "Krishnakumar. R" <krishnakumar@naturesoft.net>
Reply-To: krishnakumar@naturesoft.net
Organization: Naturesoft
To: trivial@rustcorp.com.au
Subject: [BUG #568][PATCH-2.6.0-test3] compile failure in drivers/isdn/hisax/diva.c
Date: Fri, 15 Aug 2003 21:36:50 +0530
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308152136.50213.krishnakumar@naturesoft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch is against 2.6.0-test3.
The patch enables the compilation of the diva.c.
This is a probable solution to [BUG #568] -  compile failure in drivers/isdn/hisax/diva.c

Regards
KK

Compilation errors.
=====================================================
drivers/isdn/hisax/diva.c: In function `setup_diva':
drivers/isdn/hisax/diva.c:754: `cs' undeclared (first use in this function)
drivers/isdn/hisax/diva.c:754: (Each undeclared identifier is reported only once
drivers/isdn/hisax/diva.c:754: for each function it appears in.)
drivers/isdn/hisax/diva.c:761: parse error before "else"
drivers/isdn/hisax/diva.c: At top level:
drivers/isdn/hisax/diva.c:776: parse error before "if"
drivers/isdn/hisax/diva.c:795: parse error before string constant
drivers/isdn/hisax/diva.c:795: warning: type defaults to `int' in declaration of `printk'
drivers/isdn/hisax/diva.c:795: warning: function declaration isn't a prototype
drivers/isdn/hisax/diva.c:795: warning: data definition has no type or storage class
drivers/isdn/hisax/diva.c:602: warning: `diva_pci_probe' defined but not used
drivers/isdn/hisax/diva.c:629: warning: `diva_ipac_pci_probe' defined but not used
drivers/isdn/hisax/diva.c:656: warning: `diva_ipacx_pci_probe' defined but not used
drivers/isdn/hisax/diva.c:677: warning: `dev_diva' defined but not used
drivers/isdn/hisax/diva.c:678: warning: `dev_diva_u' defined but not used
drivers/isdn/hisax/diva.c:679: warning: `dev_diva201' defined but not used

=======================================================

diffstat output:

 diva.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

================================================================

The following is the patch which fixes the compilation error.


--- linux-2.6.0-test3/drivers/isdn/hisax/diva.orig.c	2003-08-09 10:11:36.000000000 +0530
+++ linux-2.6.0-test3/drivers/isdn/hisax/diva.c	2003-08-15 21:24:44.000000000 +0530
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




