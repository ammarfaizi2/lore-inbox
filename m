Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbWGQQqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbWGQQqh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbWGQQpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:45:01 -0400
Received: from mail.kroah.org ([69.55.234.183]:52666 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750936AbWGQQcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:32:21 -0400
Date: Mon, 17 Jul 2006 09:26:35 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, len.brown@intel.com,
       robert.moore@intel.com, Daniel Drake <dsd@gentoo.org>,
       Chris Wright <chrisw@sous-sol.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 10/45] Reduce ACPI verbosity on null handle condition
Message-ID: <20060717162635.GK4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="reduce-acpi-verbosity-on-null-handle-condition.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Bob Moore <robert.moore@intel.com>

As detailed at http://bugs.gentoo.org/131534 :

2.6.16 converted many ACPI debug messages into error or warning 
messages. One extraneous message was incorrectly converted, resulting in 
logs being flooded by "Handle is NULL and Pathname is relative" messages 
on some systems.

This patch (part of a larger ACPICA commit) converts the message back to 
debug level.

Signed-off-by: Daniel Drake <dsd@gentoo.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/acpi/namespace/nsxfeval.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.17.3.orig/drivers/acpi/namespace/nsxfeval.c
+++ linux-2.6.17.3/drivers/acpi/namespace/nsxfeval.c
@@ -238,8 +238,9 @@ acpi_evaluate_object(acpi_handle handle,
 			ACPI_ERROR((AE_INFO,
 				    "Both Handle and Pathname are NULL"));
 		} else {
-			ACPI_ERROR((AE_INFO,
-				    "Handle is NULL and Pathname is relative"));
+			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+					  "Null Handle with relative pathname [%s]",
+					  pathname));
 		}
 
 		status = AE_BAD_PARAMETER;

--
