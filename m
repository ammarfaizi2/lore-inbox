Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbUCGVCS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 16:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbUCGVCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 16:02:18 -0500
Received: from cv150.neoplus.adsl.tpnet.pl ([80.54.218.150]:46096 "EHLO
	satan.blackhosts") by vger.kernel.org with ESMTP id S262335AbUCGVCQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 16:02:16 -0500
Date: Sun, 7 Mar 2004 22:07:01 +0100
From: Jakub Bogusz <qboosh@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: (2.6 IDE) why PDC202XX_FORCE not allowed with BLK_DEV_PDC202XX_NEW=m?
Message-ID: <20040307210701.GA23440@satan.blackhosts>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Organization: Black Hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PDC202XX_FORCE option is needed to override controller disable by BIOS
when RAID is used. Or maybe there is another way to do this in 2.6.x?

This option has "depends on BLK_DEV_PDC202XX_NEW=y" flag in
drivers/ide/Kconfig, thus is not available with pdc202xx_new in
module - why?
I saw success report with modular pdc202xx_new after this simple change
(without PDC202XX_FORCE controller ports were not detected):

--- linux/drivers/ide/Kconfig.orig        2004-03-04 07:16:45.000000000 +0100
+++ linux/drivers/ide/Kconfig     2004-03-07 17:37:25.000000000 +0100
@@ -720,7 +720,7 @@
 # FIXME - probably wants to be one for old and for new
 config PDC202XX_FORCE
        bool "Enable controller even if disabled by BIOS"
-       depends on BLK_DEV_PDC202XX_NEW=y
+       depends on BLK_DEV_PDC202XX_NEW
        help
          Enable the PDC202xx controller even if it has been disabled in the BIOS setup.


The same may apply to PDC202XX_BURST for pdc202xx_old module...
(but not tested)


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
PLD Team        http://www.pld-linux.org/
