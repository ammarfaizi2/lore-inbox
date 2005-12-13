Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932577AbVLMIbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932577AbVLMIbN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbVLMIbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:31:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:52611 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932555AbVLMIYy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:24:54 -0500
Date: Tue, 13 Dec 2005 00:22:55 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       dsd@gentoo.org, trenn@suse.de, len.brown@intel.com
Subject: [patch 11/26] ACPI: fix HP nx8220 boot hang regression
Message-ID: <20051213082255.GL5823@kroah.com>
References: <20051213073430.558435000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="acpi-fix-hp-nx8220-boot-hang-regression.patch"
In-Reply-To: <20051213082143.GA5823@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Thomas Renninger <trenn@suse.de>

[ACPI] fix HP nx8220 boot hang regression

This patch reverts the acpi_bus_find_driver() return value check
that came in via the PCI tree via 3fb02738b0fd36f47710a2bf207129efd2f5daa2

        [PATCH] acpi bridge hotadd: Allow ACPI .add and .start
	operations to be done independently

This particular change broke booting of some HP/Compaq laptops unless
acpi=noirq is used.

http://bugzilla.kernel.org/show_bug.cgi?id=5221
https://bugzilla.novell.com/show_bug.cgi?id=116763

Signed-off-by: Thomas Renninger <trenn@suse.de>
Cc: Rajesh Shah <rajesh.shah@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/acpi/scan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.14.3.orig/drivers/acpi/scan.c
+++ linux-2.6.14.3/drivers/acpi/scan.c
@@ -1111,7 +1111,7 @@ acpi_add_single_object(struct acpi_devic
 	 *
 	 * TBD: Assumes LDM provides driver hot-plug capability.
 	 */
-	result = acpi_bus_find_driver(device);
+	acpi_bus_find_driver(device);
 
       end:
 	if (!result)

--
