Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWFRMFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWFRMFv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 08:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWFRMFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 08:05:51 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32531 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932189AbWFRMFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 08:05:51 -0400
Date: Sun, 18 Jun 2006 13:05:43 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17: CONFIG_PARPORT_SERIAL should require CONFIG_SERIAL_8250_PCI?
Message-ID: <20060618120542.GA4833@flint.arm.linux.org.uk>
Mail-Followup-To: Andrey Borzenkov <arvidjaar@mail.ru>,
	linux-kernel@vger.kernel.org
References: <200606181423.17884.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606181423.17884.arvidjaar@mail.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 18, 2006 at 02:23:07PM +0400, Andrey Borzenkov wrote:
> Just rebuilt 2.6.17 from older config and disabling 8250 PCI (I do not have 
> any on notebook) and got:

Thanks for reporting this.  The patch below should fix this - please
test so it can be submitted for the stable branch, thanks.

# Base git commit: 427abfa28afedffadfca9dd8b067eb6d36bac53f
#	(Linux v2.6.17)
#
# Author:    Russell King (Sun Jun 18 13:00:48 BST 2006)
# Committer: Russell King (Sun Jun 18 13:00:48 BST 2006)
#	
#	[SERIAL] PARPORT_SERIAL should depend on SERIAL_8250_PCI
#	
#	Since parport_serial uses symbols from 8250_pci, there should
#	be a dependency between the configuration symbols for these
#	two modules.  Problem reported by Andrey Borzenkov
#	
#	Signed-off-by: Russell King
#
#	 drivers/parport/Kconfig |    2 +-
#	 1 files changed, 1 insertions(+), 1 deletions(-)
#
diff --git a/drivers/parport/Kconfig b/drivers/parport/Kconfig
--- a/drivers/parport/Kconfig
+++ b/drivers/parport/Kconfig
@@ -48,7 +48,7 @@ config PARPORT_PC
 
 config PARPORT_SERIAL
 	tristate "Multi-IO cards (parallel and serial)"
-	depends on SERIAL_8250 && PARPORT_PC && PCI
+	depends on SERIAL_8250_PCI && PARPORT_PC && PCI
 	help
 	  This adds support for multi-IO PCI cards that have parallel and
 	  serial ports.  You should say Y or M here.  If you say M, the module


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
