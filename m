Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265402AbTBFEHN>; Wed, 5 Feb 2003 23:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265414AbTBFEGX>; Wed, 5 Feb 2003 23:06:23 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:58640 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265446AbTBFEDA>;
	Wed, 5 Feb 2003 23:03:00 -0500
Subject: Re: [PATCH] PCI Hotplug changes for 2.5.59
In-reply-to: <10445044923469@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Wed, 5 Feb 2003 20:08 -0800
Message-id: <1044504492793@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.947.23.14, 2003/02/06 11:23:20+11:00, greg@kroah.com

[PATCH] IBM PCI Hotplug: fix memory leak found by checker project.


diff -Nru a/drivers/hotplug/ibmphp_pci.c b/drivers/hotplug/ibmphp_pci.c
--- a/drivers/hotplug/ibmphp_pci.c	Thu Feb  6 14:51:12 2003
+++ b/drivers/hotplug/ibmphp_pci.c	Thu Feb  6 14:51:12 2003
@@ -951,6 +951,7 @@
 		if (rc) {
 			if (rc == -ENOMEM) {
 				ibmphp_remove_bus (bus, func->busno);
+				kfree (amount_needed);
 				return rc;
 			}
 			retval = rc;

