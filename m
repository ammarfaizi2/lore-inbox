Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270648AbTHQTyU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 15:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270681AbTHQTyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 15:54:20 -0400
Received: from egeo.unipg.it ([141.250.1.4]:52112 "EHLO egeo.unipg.it")
	by vger.kernel.org with ESMTP id S270648AbTHQTyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 15:54:18 -0400
From: Francesco Sportolari <francesco@unipg.it>
To: linux-kernel@vger.kernel.org
Subject: [bug 1080] [PATCH] 2.6.0-t3: alsa driver snd-powermac doesn't work with tumbler chip on ibook2
Date: Sun, 17 Aug 2003 23:54:06 +0200
User-Agent: KMail/1.5.3
Cc: DiegoCG@teleline.es, alsa-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308172354.06944.francesco@unipg.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During the insmod of the snd-powermac module this msg is printed to the 
console:

tumbler: cannot initialize the MCS

After that, even if the module is loaded correctly, the sound doesn't work at 
all.

I've noticed that removing and inserting again the 'i2c-keywest' module solves 
the problem. The following patch fixes this issue related to early 
initialization of the i2c client in the driver.

Bye,
-- Francesco

--- orig/sound/ppc/tumbler.c    2003-08-16 17:18:35.000000000 +0200
+++ linux-2.6.0-test3/sound/ppc/tumbler.c       2003-08-16 17:18:55.000000000 
+0200
@@ -996,9 +996,6 @@
                chipname = "Snapper";
        }

-       if ((err = snd_pmac_keywest_init(&mix->i2c)) < 0)
-               return err;
-
        /*
         * build mixers
         */
@@ -1025,6 +1022,9 @@
        if ((err = tumbler_init(chip)) < 0)
                return err;

+       if ((err = snd_pmac_keywest_init(&mix->i2c)) < 0)
+               return err;
+
 #ifdef CONFIG_PMAC_PBOOK
        chip->resume = tumbler_resume;
 #endif


