Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262201AbVGGCfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbVGGCfi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 22:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262218AbVGFT60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:58:26 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:30477 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S262247AbVGFQLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 12:11:48 -0400
Date: Wed, 6 Jul 2005 09:11:50 -0700
From: Greg KH <gregkh@suse.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13-rc2] pci: fix PCI && !HOTPLUG compile error
Message-ID: <20050706161150.GA13518@suse.de>
References: <200507061502.j66F2f5b010528@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507061502.j66F2f5b010528@harpo.it.uu.se>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 05:02:41PM +0200, Mikael Pettersson wrote:
> 2.6.13-rc2 triggers compile errors in pci-driver.c
> when hotplug is disabled:
> 
> drivers/pci/pci-driver.c: In function 'pci_match_device':
> drivers/pci/pci-driver.c:156: error: dereferencing pointer to incomplete type
> drivers/pci/pci-driver.c:156: warning: type defaults to 'int' in declaration of 'type name'
> drivers/pci/pci-driver.c:156: error: request for member 'node' in something not a structure or union
> drivers/pci/pci-driver.c:156: warning: type defaults to 'int' in declaration of '__mptr'
> drivers/pci/pci-driver.c:156: warning: initialization from incompatible pointer type
> etc
> 
> This is because 2.6.13-rc2 added a code block to this function which references
> hotplug-only stuff. Fixed crudely by #ifdef CONFIG_HOTPLUG around it.

No, use this patch instead, it's smaller and cleaner, and is what I ment
the code to look like in the first place :)

thanks,

greg k-h

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/pci/pci-driver.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- gregkh-2.6.orig/drivers/pci/pci-driver.c	2005-07-06 01:03:26.000000000 -0700
+++ gregkh-2.6/drivers/pci/pci-driver.c	2005-07-06 09:07:09.000000000 -0700
@@ -17,13 +17,13 @@
  * Dynamic device IDs are disabled for !CONFIG_HOTPLUG
  */
 
-#ifdef CONFIG_HOTPLUG
-
 struct pci_dynid {
 	struct list_head node;
 	struct pci_device_id id;
 };
 
+#ifdef CONFIG_HOTPLUG
+
 /**
  * store_new_id
  *


