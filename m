Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266003AbUITEiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266003AbUITEiA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 00:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266009AbUITEiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 00:38:00 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:23518 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266003AbUITEh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 00:37:58 -0400
Date: Sun, 19 Sep 2004 21:37:06 -0700
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: akpm@osdl.org, len.brown@intel.com, tony.luck@intel.com,
       jbarnes@engr.sgi.com, jes@wildopensource.com,
       linux-kernel@vger.kernel.org, andrew.vasquez@qlogic.com
Subject: Re: 2.6.9-rc2-mm1
Message-Id: <20040919213706.4b8083e8.pj@sgi.com>
In-Reply-To: <20040920011231.GP9106@holomorphy.com>
References: <20040916024020.0c88586d.akpm@osdl.org>
	<20040920011231.GP9106@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wli wrote:
> Fails to boot on my Altix.

See a couple of patches on this linux-scsi thread, mostly between Jesse
Barnes and Andrew Vasquez:

	SCSI QLA not working on latest *-mm SN2
	http://marc.theaimsgroup.com/?l=linux-scsi&m=109537406715003&w=2

Or I got it working (I think - memory fuzzy know) without this patch, by
(1) disabling the CONFIG_SCSI_QLA2[123]?? options, and (2) applying the
following workaround patch:

--- 2.6.9-rc2-mm1.orig/arch/ia64/pci/pci.c	2004-09-16 07:45:58.000000000 -0700
+++ 2.6.9-rc2-mm1/arch/ia64/pci/pci.c	2004-09-16 12:02:34.000000000 -0700
@@ -445,7 +445,7 @@ pcibios_enable_device (struct pci_dev *d
 	if (ret < 0)
 		return ret;
 
-	return acpi_pci_irq_enable(dev);
+	return ia64_platform_is("sn2") ? 0 : acpi_pci_irq_enable(dev);
 }
 
 void

===

Jesse - could you post on lkml the definitive guide to getting
2.6.9-rc2-mm1 working on Altix?

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
