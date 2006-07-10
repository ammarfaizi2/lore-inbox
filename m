Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422724AbWGJRch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422724AbWGJRch (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 13:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422729AbWGJRch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 13:32:37 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13456 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1422724AbWGJRcH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 13:32:07 -0400
Date: Mon, 10 Jul 2006 17:20:32 +0200
From: Pavel Machek <pavel@ucw.cz>
To: yi.zhu@intel.com, jketreno@linux.intel.com,
       Netdev list <netdev@vger.kernel.org>, linville@tuxdriver.com,
       kernel list <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Subject: [patch] do not allow IPW_2100=Y or IPW_2200=Y
Message-ID: <20060710152032.GA8540@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kconfig currently allows compiling IPW_2100 and IPW_2200 into kernel
(not as a module). Unfortunately, such configuration does not work,
because these drivers need a firmware, and it can't be loaded by
userspace loader when userspace is not running.

Is there better way of creating N/m config option?

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
index fa9d2c4..050febb 100644
--- a/drivers/net/wireless/Kconfig
+++ b/drivers/net/wireless/Kconfig
@@ -144,9 +144,14 @@ config PCMCIA_RAYCS
 comment "Wireless 802.11b ISA/PCI cards support"
 	depends on NET_RADIO && (ISA || PCI || PPC_PMAC || PCMCIA)
 
+
+config MODULE_ONLY
+	tristate
+	default m
+
 config IPW2100
 	tristate "Intel PRO/Wireless 2100 Network Connection"
-	depends on NET_RADIO && PCI
+	depends on NET_RADIO && PCI && MODULE_ONLY
 	select FW_LOADER
 	select IEEE80211
 	---help---
@@ -200,7 +205,7 @@ config IPW2100_DEBUG
 
 config IPW2200
 	tristate "Intel PRO/Wireless 2200BG and 2915ABG Network Connection"
-	depends on NET_RADIO && PCI
+	depends on NET_RADIO && PCI && MODULE_ONLY
 	select FW_LOADER
 	select IEEE80211
 	---help---

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
