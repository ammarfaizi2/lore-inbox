Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbWC3UzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbWC3UzR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 15:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbWC3UzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 15:55:16 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:48709 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1750876AbWC3UzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 15:55:15 -0500
X-IronPort-AV: i="4.03,147,1141632000"; 
   d="scan'208"; a="318518752:sNHT29850624"
To: greg@kroah.com
Cc: mst@mellanox.co.il, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: fix sparse warning about pci_bus_flags
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 30 Mar 2006 12:55:10 -0800
Message-ID: <adamzf71wlt.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 30 Mar 2006 20:55:11.0128 (UTC) FILETIME=[3C316980:01C6543C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse warns about casting to a __bitwise type.  However, it's correct
to do when defining the enum for pci_bus_flags_t, so add a __force to
quiet the warnings.  This will fix getting

    include/linux/pci.h:100:26: warning: cast to restricted type

from sparse all over the build.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0aad5a3..09ff282 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -97,7 +97,7 @@ enum pci_channel_state {
 
 typedef unsigned short __bitwise pci_bus_flags_t;
 enum pci_bus_flags {
-	PCI_BUS_FLAGS_NO_MSI = (pci_bus_flags_t) 1,
+	PCI_BUS_FLAGS_NO_MSI = (__force pci_bus_flags_t) 1,
 };
 
 /*
