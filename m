Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262359AbVAJR1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbVAJR1A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 12:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbVAJRYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:24:31 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:24711 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262358AbVAJRVF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:21:05 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI patches for 2.6.10
User-Agent: Mutt/1.5.6i
In-Reply-To: <11053776562095@kroah.com>
Date: Mon, 10 Jan 2005 09:20:56 -0800
Message-Id: <11053776562882@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.439.47, 2005/01/07 10:33:57-08:00, eike-hotplug@sf-tec.de

[PATCH] PCI Hotplug: don't check pointer before kalling kfree in ibmphp_pci.c

Calling kfree() with a NULL pointer is no error so we don't need this check.

Signed-off-by: Rolf Eike Beer <eike-hotplug@sf-tec.de>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/ibmphp_pci.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)


diff -Nru a/drivers/pci/hotplug/ibmphp_pci.c b/drivers/pci/hotplug/ibmphp_pci.c
--- a/drivers/pci/hotplug/ibmphp_pci.c	2005-01-10 08:58:38 -08:00
+++ b/drivers/pci/hotplug/ibmphp_pci.c	2005-01-10 08:58:38 -08:00
@@ -1062,8 +1062,7 @@
 	}
 
 error:
-	if (amount_needed)
-		kfree (amount_needed);
+	kfree(amount_needed);
 	if (pfmem)
 		ibmphp_remove_resource (pfmem);
 	if (io)

