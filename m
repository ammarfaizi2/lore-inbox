Return-Path: <linux-kernel-owner+w=401wt.eu-S932428AbXAGGz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbXAGGz5 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 01:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbXAGGz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 01:55:56 -0500
Received: from ns1.suse.de ([195.135.220.2]:41855 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932428AbXAGGz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 01:55:56 -0500
Subject: patch pci-increment-pos-before-looking-for-the-next-cap-in-__pci_find_next_ht_cap.patch added to gregkh-2.6 tree
To: brice@myri.com, gallatin@myri.com, gregkh@suse.de,
       linux-kernel@vger.kernel.org, michael@ellerman.id.au
From: <gregkh@suse.de>
Date: Sat, 06 Jan 2007 22:54:58 -0800
In-Reply-To: <459ED69E.4060801@myri.com>
Message-Id: <20070107065539.29D69A5BABF@imap.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: PCI: increment pos before looking for the next cap in __pci_find_next_ht_cap

to my gregkh-2.6 tree.  Its filename is

     pci-increment-pos-before-looking-for-the-next-cap-in-__pci_find_next_ht_cap.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From brice@myri.com  Fri Jan  5 15:01:21 2007
From: Brice Goglin <brice@myri.com>
Date: Fri, 05 Jan 2007 23:52:14 +0100
Subject: PCI: increment pos before looking for the next cap in __pci_find_next_ht_cap
To: Greg KH <gregkh@suse.de>, Michael Ellerman <michael@ellerman.id.au>
Cc: LKML <linux-kernel@vger.kernel.org>
Message-ID: <459ED69E.4060801@myri.com>

While testing 2.6.20-rc3 on a machine with some CK804 chipsets, we
noticed that quirk_nvidia_ck804_msi_ht_cap() was not detecting HT
MSI capabilities anymore. It is actually caused by the MSI mapping
on the root chipset being the 2nd HT capability in the chain.
pci_find_ht_capability() does not seem to find anything but the
first HT cap correctly, because it forgets to increment the position
before looking for the next cap. The following patch seems to fix it.

At least, this prooves that having a ttl is good idea since the
machine would have been stucked in an infinite loop if we didn't
have a ttl :)

Signed-off-by: Brice Goglin <brice@myri.com>
Signed-off-by: Andrew J. Gallatin <gallatin@myri.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/pci/pci.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- gregkh-2.6.orig/drivers/pci/pci.c
+++ gregkh-2.6/drivers/pci/pci.c
@@ -254,7 +254,8 @@ static int __pci_find_next_ht_cap(struct
 		if ((cap & mask) == ht_cap)
 			return pos;
 
-		pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn, pos,
+		pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn,
+					      pos + PCI_CAP_LIST_NEXT,
 					      PCI_CAP_ID_HT, &ttl);
 	}
 


Patches currently in gregkh-2.6 which might be from brice@myri.com are

