Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261742AbSKCLlh>; Sun, 3 Nov 2002 06:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261745AbSKCLlh>; Sun, 3 Nov 2002 06:41:37 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:40974 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261742AbSKCLlg>; Sun, 3 Nov 2002 06:41:36 -0500
Message-Id: <200211031142.gA3Bgxp27886@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
Subject: [PATCH] drivers/net/smc9194.h: add do {...} while(0) as appropriate
Date: Sun, 3 Nov 2002 14:34:57 -0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --recursive linux-2.5.40org/drivers/net/smc9194.h linux-2.5.40/drivers/net/smc9194.h
--- linux-2.5.40org/drivers/net/smc9194.h	Tue Oct  1 05:07:46 2002
+++ linux-2.5.40/drivers/net/smc9194.h	Wed Oct  9 08:17:59 2002
@@ -201,31 +201,32 @@

 /* select a register bank, 0 to 3  */

-#define SMC_SELECT_BANK(x)  { outw( x, ioaddr + BANK_SELECT ); }
+#define SMC_SELECT_BANK(x) outw( x, ioaddr + BANK_SELECT )

 /* define a small delay for the reset */
-#define SMC_DELAY() { inw( ioaddr + RCR );\
-			inw( ioaddr + RCR );\
-			inw( ioaddr + RCR );  }
+#define SMC_DELAY() do { inw( ioaddr + RCR );\
+		inw( ioaddr + RCR );\
+		inw( ioaddr + RCR );\
+} while(0)

 /* this enables an interrupt in the interrupt mask register */
-#define SMC_ENABLE_INT(x) {\
+#define SMC_ENABLE_INT(x) do {\
 		unsigned char mask;\
 		SMC_SELECT_BANK(2);\
 		mask = inb( ioaddr + INT_MASK );\
 		mask |= (x);\
-		outb( mask, ioaddr + INT_MASK ); \
-}
+		outb( mask, ioaddr + INT_MASK );\
+} while(0)

 /* this disables an interrupt from the interrupt mask register */

-#define SMC_DISABLE_INT(x) {\
+#define SMC_DISABLE_INT(x) do {\
 		unsigned char mask;\
 		SMC_SELECT_BANK(2);\
 		mask = inb( ioaddr + INT_MASK );\
 		mask &= ~(x);\
-		outb( mask, ioaddr + INT_MASK ); \
-}
+		outb( mask, ioaddr + INT_MASK );\
+} while(0)

 /*----------------------------------------------------------------------
  . Define the interrupts that I want to receive from the card
