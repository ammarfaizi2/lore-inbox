Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319381AbSIKXNw>; Wed, 11 Sep 2002 19:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319382AbSIKXNw>; Wed, 11 Sep 2002 19:13:52 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:54478 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S319381AbSIKXNv>;
	Wed, 11 Sep 2002 19:13:51 -0400
Date: Wed, 11 Sep 2002 16:18:38 -0700
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4.20] Fix stupid compile error in wavelan_cs
Message-ID: <20020911231838.GA32265@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	This fix the stupid compile error introduce by some careless
hacker in the wavelan_cs driver.
	This is the *right* fix that avoid header duplication, do not
accept substitutes ;-)

	Alan told me that he was going to send you the fix for the
irtty compile error.

	Have fun...

	Jean

------------------------------------------------------------

diff -u -p linux/drivers/net/pcmcia/wavelan_cs.b1.h linux/drivers/net/pcmcia/wavelan_cs.h
--- linux/drivers/net/pcmcia/wavelan_cs.b1.h	Wed Sep 11 16:01:58 2002
+++ linux/drivers/net/pcmcia/wavelan_cs.h	Wed Sep 11 16:11:14 2002
@@ -432,6 +432,7 @@
 #include <linux/if_arp.h>
 #include <linux/ioport.h>
 #include <linux/fcntl.h>
+#include <linux/ethtool.h>
 
 #ifdef CONFIG_NET_PCMCIA_RADIO
 #include <linux/wireless.h>		/* Wireless extensions */
diff -u -p linux/drivers/net/pcmcia/wavelan_cs.b1.c linux/drivers/net/pcmcia/wavelan_cs.c
--- linux/drivers/net/pcmcia/wavelan_cs.b1.c	Wed Sep 11 16:01:52 2002
+++ linux/drivers/net/pcmcia/wavelan_cs.c	Wed Sep 11 16:11:11 2002
@@ -63,8 +63,7 @@
  *
  */
 
-#include <linux/ethtool.h>
-#include <asm/uaccess.h>
+/* Do *NOT* add other headers here, you are guaranteed to be wrong - Jean II */
 #include "wavelan_cs.h"		/* Private header */
 
 /************************* MISC SUBROUTINES **************************/
