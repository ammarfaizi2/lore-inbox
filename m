Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbUCaUiK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 15:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbUCaUiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 15:38:10 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:14589 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262459AbUCaUiG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 15:38:06 -0500
Subject: [PATCH] RPA PCI Hotplug - redundant free
From: John Rose <johnrose@austin.ibm.com>
To: Greg KH <gregkh@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1080765544.1889.13.camel@verve.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 31 Mar 2004 14:39:04 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg-

Apologies for the resend, messed up the lkml address.  Please commit the
following patch, which removes a redundant call to a
cleanup function from an error path of the module init code.

Thanks-
John

diff -Nru a/drivers/pci/hotplug/rpaphp_pci.c b/drivers/pci/hotplug/rpaphp_pci.c
--- a/drivers/pci/hotplug/rpaphp_pci.c	Tue Mar 30 18:50:32 2004
+++ b/drivers/pci/hotplug/rpaphp_pci.c	Tue Mar 30 18:50:32 2004
@@ -304,7 +304,6 @@
 	if (slot->hotplug_slot->info->adapter_status == NOT_VALID) {
 		dbg("%s: NOT_VALID: skip dn->full_name=%s\n",
 		    __FUNCTION__, slot->dn->full_name);
-		dealloc_slot_struct(slot);
 		return (-1);
 	}
 	return (0);




