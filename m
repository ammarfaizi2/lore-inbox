Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266506AbUA3BtN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 20:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266505AbUA3Beg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 20:34:36 -0500
Received: from mail.kroah.org ([65.200.24.183]:7644 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266506AbUA3Bb7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 20:31:59 -0500
Subject: Re: [PATCH] PCI Update for 2.6.2-rc2
In-Reply-To: <10754263082060@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 29 Jan 2004 17:31:49 -0800
Message-Id: <10754263092718@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1515, 2004/01/29 14:46:48-08:00, willy@debian.org

[PATCH] PCI: fix pci_get_slot() bug

On Wed, Dec 17, 2003 at 04:24:44PM -0800, Greg KH wrote:
> I've applied the pci portions of this patch to my trees and will send it
> on after 2.6.0 is out.

James Bottomley found a bug in it; could you also apply:


 drivers/pci/search.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/pci/search.c b/drivers/pci/search.c
--- a/drivers/pci/search.c	Thu Jan 29 17:24:22 2004
+++ b/drivers/pci/search.c	Thu Jan 29 17:24:22 2004
@@ -125,7 +125,7 @@
 	WARN_ON(in_interrupt());
 	spin_lock(&pci_bus_lock);
 
-	list_for_each(tmp, &bus->children) {
+	list_for_each(tmp, &bus->devices) {
 		dev = pci_dev_b(tmp);
 		if (dev->devfn == devfn)
 			goto out;

