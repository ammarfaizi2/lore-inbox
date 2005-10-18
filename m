Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbVJRVGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbVJRVGe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 17:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbVJRVGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 17:06:34 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:6794 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932146AbVJRVGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 17:06:33 -0400
To: Greg KH <gregkh@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: What is struct pci_driver.owner for?
X-Message-Flag: Warning: May contain useful information
References: <52sluymu26.fsf@cisco.com> <435560D0.8050205@pobox.com>
	<20051018205908.GA32435@suse.de>
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 18 Oct 2005 14:06:26 -0700
In-Reply-To: <20051018205908.GA32435@suse.de> (Greg KH's message of "Tue, 18
 Oct 2005 13:59:08 -0700")
Message-ID: <52oe5mmt65.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 18 Oct 2005 21:06:28.0878 (UTC) FILETIME=[CED49AE0:01C5D427]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> But what it really does today is create the symlink from the
    Greg> driver to the module that is contained in it, in sysfs.
    Greg> Which is very invaluable for people who want to know these
    Greg> things (installer programs, etc.)

    Greg> That "module" symlink is created only if the .owner field is
    Greg> set.  That's why people are going through and adding it to
    Greg> all of the drivers in the system.

OK, I'll make my own small contribution and push this for 2.6.15:

diff --git a/drivers/infiniband/hw/mthca/mthca_main.c b/drivers/infiniband/hw/mthca/mthca_main.c
--- a/drivers/infiniband/hw/mthca/mthca_main.c
+++ b/drivers/infiniband/hw/mthca/mthca_main.c
@@ -1196,6 +1196,7 @@ MODULE_DEVICE_TABLE(pci, mthca_pci_table
 
 static struct pci_driver mthca_driver = {
 	.name		= DRV_NAME,
+	.owner		= THIS_MODULE,
 	.id_table	= mthca_pci_table,
 	.probe		= mthca_init_one,
 	.remove		= __devexit_p(mthca_remove_one)
