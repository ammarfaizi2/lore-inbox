Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279784AbRJ0G1P>; Sat, 27 Oct 2001 02:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279785AbRJ0G0z>; Sat, 27 Oct 2001 02:26:55 -0400
Received: from zero.tech9.net ([209.61.188.187]:60426 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S279784AbRJ0G0u>;
	Sat, 27 Oct 2001 02:26:50 -0400
Subject: [PATCH] 2.4.13-ac2: Appletalk Config Screwed
From: Robert Love <rml@tech9.net>
To: Alan Cox <laughing@shared-source.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.25.15.53 (Preview Release)
Date: 27 Oct 2001 02:27:26 -0400
Message-Id: <1004164050.3272.7.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Appletalk configure file is butchered, resulting in various
problems: `make oldconfig' always prompts on CONFIG_ATALK, `make
[*]config' returns "ERROR - Attempting to write value for unconfigured
variable (CONFIG_ATALK).", etc etc.

The fix is trivial.  Attached is against 2.4.13-ac2.  Alan, please
apply.

diff -u linux-2.4.13-ac2/drivers/net/appletalk/Config.in linux/drivers/net/appletalk/Config.in 
--- linux-2.4.13-ac2/drivers/net/appletalk/Config.in	Fri Oct 26 15:47:50 2001
+++ linux/drivers/net/appletalk/Config.in	Sat Oct 27 02:18:55 2001
@@ -1,9 +1,7 @@
 #
 # Appletalk driver configuration
 #
-
-if [ "$CONFIG_ATALK" != "n" ]; then
-   mainmenu_option next_comment
+mainmenu_option next_comment
    comment 'Appletalk devices'
    bool 'Appletalk interfaces support' CONFIG_ATALK
    if [ "$CONFIG_ATALK" != "n" ]; then
@@ -19,5 +17,4 @@
 	 bool '    Appletalk-IP to IP Decapsulation support' CONFIG_IPDDP_DECAP
       fi
    fi
-   endmenu
-fi
+endmenu

	Robert Love

