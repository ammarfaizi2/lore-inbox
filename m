Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbVIUQuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbVIUQuy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 12:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbVIUQux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 12:50:53 -0400
Received: from ns.firmix.at ([62.141.48.66]:27785 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1751155AbVIUQud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 12:50:33 -0400
Subject: Re: Patch: Rename vprintk define in bttpvp.h
From: Bernd Petrovitsch <bernd@firmix.at>
To: mchehab@brturbo.com.br
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1127298914.26231.46.camel@tara.firmix.at>
References: <1127298914.26231.46.camel@tara.firmix.at>
Content-Type: multipart/mixed; boundary="=-McQuF+3du0qLNdMnjc2H"
Organization: Firmix Software GmbH
Date: Wed, 21 Sep 2005 18:50:17 +0200
Message-Id: <1127321417.3112.24.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-McQuF+3du0qLNdMnjc2H
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-09-21 at 12:35 +0200, Bernd Petrovitsch wrote:
> The attached patched againt 2.6.13 renames the (apparently) bttv intern 
> #define vprintk to verbprintk to resolve a name clash.
> 
> Reason: vprintk() is defined in include/linux/kernel.h similar to printk
> but with a va_list argument.

Sorry for the noise, -EWRONGPATCH. Now with the correct one.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

--=-McQuF+3du0qLNdMnjc2H
Content-Disposition: attachment; filename=bttv.patch
Content-Type: text/x-patch; name=bttv.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -uprN -X linux-2.6.13/Documentation/dontdiff linux-2.6.13/drivers/media/video/bttv-driver.c linux-2.6.13-patched/drivers/media/video/bttv-driver.c
--- linux-2.6.13/drivers/media/video/bttv-driver.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13-patched/drivers/media/video/bttv-driver.c	2005-09-21 12:19:42.000000000 +0200
@@ -761,21 +761,21 @@ static void set_pll(struct bttv *btv)
                 /* no PLL needed */
                 if (btv->pll.pll_current == 0)
                         return;
-		vprintk(KERN_INFO "bttv%d: PLL can sleep, using XTAL (%d).\n",
-			btv->c.nr,btv->pll.pll_ifreq);
+		verbprintk(KERN_INFO "bttv%d: PLL can sleep, using XTAL (%d).\n",
+                           btv->c.nr,btv->pll.pll_ifreq);
                 btwrite(0x00,BT848_TGCTRL);
                 btwrite(0x00,BT848_PLL_XCI);
                 btv->pll.pll_current = 0;
                 return;
         }
 
-	vprintk(KERN_INFO "bttv%d: PLL: %d => %d ",btv->c.nr,
-		btv->pll.pll_ifreq, btv->pll.pll_ofreq);
+	verbprintk(KERN_INFO "bttv%d: PLL: %d => %d ",btv->c.nr,
+                   btv->pll.pll_ifreq, btv->pll.pll_ofreq);
 	set_pll_freq(btv, btv->pll.pll_ifreq, btv->pll.pll_ofreq);
 
         for (i=0; i<10; i++) {
 		/*  Let other people run while the PLL stabilizes */
-		vprintk(".");
+		verbprintk(".");
 		msleep(10);
 
                 if (btread(BT848_DSTATUS) & BT848_DSTATUS_PLOCK) {
@@ -783,12 +783,12 @@ static void set_pll(struct bttv *btv)
                 } else {
                         btwrite(0x08,BT848_TGCTRL);
                         btv->pll.pll_current = btv->pll.pll_ofreq;
-			vprintk(" ok\n");
+			verbprintk(" ok\n");
                         return;
                 }
         }
         btv->pll.pll_current = -1;
-	vprintk("failed\n");
+	verbprintk("failed\n");
         return;
 }
 
diff -uprN -X linux-2.6.13/Documentation/dontdiff linux-2.6.13/drivers/media/video/bttvp.h linux-2.6.13-patched/drivers/media/video/bttvp.h
--- linux-2.6.13/drivers/media/video/bttvp.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13-patched/drivers/media/video/bttvp.h	2005-09-21 12:19:59.000000000 +0200
@@ -222,7 +222,7 @@ extern void bttv_gpio_tracking(struct bt
 extern int init_bttv_i2c(struct bttv *btv);
 extern int fini_bttv_i2c(struct bttv *btv);
 
-#define vprintk  if (bttv_verbose) printk
+#define verbprintk if (bttv_verbose) printk
 #define dprintk  if (bttv_debug >= 1) printk
 #define d2printk if (bttv_debug >= 2) printk
 

--=-McQuF+3du0qLNdMnjc2H--

