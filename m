Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbRFFKaT>; Wed, 6 Jun 2001 06:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261594AbRFFKaJ>; Wed, 6 Jun 2001 06:30:09 -0400
Received: from i2260.vwr.wanadoo.nl ([194.134.216.221]:26752 "HELO
	localhost.localdomain") by vger.kernel.org with SMTP
	id <S261561AbRFFKaA>; Wed, 6 Jun 2001 06:30:00 -0400
Date: Wed, 6 Jun 2001 12:24:34 +0200
From: Remi Turk <remi@a2zis.com>
To: linux-kernel@vger.kernel.org
Cc: Axel Boldt <axel@uni-paderborn.de>,
        Phil Blundell <Philip.Blundell@pobox.com>
Subject: [PATCH] Configure.help: 
Message-ID: <20010606122434.B859@localhost.localdomain>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Axel Boldt <axel@uni-paderborn.de>,
	Phil Blundell <Philip.Blundell@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
it seems the Configure.help text for CONFIG_LP_CONSOLE
is incorrect: The default is to stall until the printer
is ready while the help text says the opposite.
(vi +540 drivers/char/lp.c)

Attached is a patch for 2.4.6-pre1 which fixes the help text.

Also, shouldn't CONFIG_LP_CONSOLE depend on CONFIG_PRINTER=y?
(it doesn't work when CONFIG_PRINTER=m, at least for me)

-- 
Linux 2.4.5-ac9 #3 Wed Jun 6 11:15:40 CEST 2001

--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="Configure.help.patch"

diff -ur --new-file linux-2.4.6-pre1/Documentation/Configure.help linux-2.4.6-pre1.new/Documentation/Configure.help
--- linux-2.4.6-pre1/Documentation/Configure.help	Wed Jun  6 11:54:24 2001
+++ linux-2.4.6-pre1.new/Documentation/Configure.help	Wed Jun  6 11:54:32 2001
@@ -13014,10 +13014,12 @@
   doing that; to actually get it to happen you need to pass the
   option "console=lp0" to the kernel at boot time.
 
-  Note that kernel messages can get lost if the printer is out of
-  paper (or off, or unplugged, or too busy..), but this behaviour
-  can be changed. See drivers/char/lp.c (do this at your own risk).
-
+  If the printer is out of paper (or off, or unplugged, or too
+  busy..) the kernel will stall until the printer is ready again.
+  By defining CONSOLE_LP_STRICT to 0 (at your own risk) you
+  can make the kernel continue when this happens,
+  but it'll lose the kernel messages.
+  
   If unsure, say N.
 
 Support for user-space parallel port device drivers

--6sX45UoQRIJXqkqR--
