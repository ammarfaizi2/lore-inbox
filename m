Return-Path: <linux-kernel-owner+w=401wt.eu-S936331AbWLIIkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936331AbWLIIkg (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 03:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936332AbWLIIkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 03:40:36 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:51650 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936331AbWLIIkf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 03:40:35 -0500
Date: Sat, 9 Dec 2006 00:36:35 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, dmitry.torokhov@gmail.com
Subject: [PATCH] ucb1400_ts depends SND_AC97_BUS
Message-Id: <20061209003635.e778ff76.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

This driver is an AC97 codec according to its help text.
However, if SOUND is disabled, the "select SND_AC97_BUS"
still inserts that into the .config file:

#
# Sound
#
# CONFIG_SOUND is not set
CONFIG_SND_AC97_BUS=m

Even if the config software followed dependency chains on selects,
we should try to limit usage of "select" to library-type
code that is needed (e.g., CRC functions) instead of bus-type
support.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/input/touchscreen/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19-git13.orig/drivers/input/touchscreen/Kconfig
+++ linux-2.6.19-git13/drivers/input/touchscreen/Kconfig
@@ -146,7 +146,7 @@ config TOUCHSCREEN_TOUCHWIN
 
 config TOUCHSCREEN_UCB1400
 	tristate "Philips UCB1400 touchscreen"
-	select SND_AC97_BUS
+	depends on SND_AC97_BUS
 	help
 	  This enables support for the Philips UCB1400 touchscreen interface.
 	  The UCB1400 is an AC97 audio codec.  The touchscreen interface


---
