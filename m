Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265316AbTLRUAj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 15:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265317AbTLRUAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 15:00:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58785 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265316AbTLRUAe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 15:00:34 -0500
Date: Thu, 18 Dec 2003 20:00:31 +0000
From: Matthew Wilcox <willy@debian.org>
To: Greg KH <greg@kroah.com>
Cc: Matthew Wilcox <willy@debian.org>, "David S. Miller" <davem@redhat.com>,
       Jeff Garzik <jgarzik@pobox.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci_get_slot()
Message-ID: <20031218200031.GK15674@parcelfarce.linux.theplanet.co.uk>
References: <20031015183213.GG16535@parcelfarce.linux.theplanet.co.uk> <20031218002444.GI6258@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031218002444.GI6258@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 17, 2003 at 04:24:44PM -0800, Greg KH wrote:
> I've applied the pci portions of this patch to my trees and will send it
> on after 2.6.0 is out.

James Bottomley found a bug in it; could you also apply:

--- a/drivers/pci/search.c	17 Oct 2003 12:24:07 -0000	1.2
+++ b/drivers/pci/search.c	13 Dec 2003 22:36:04 -0000	1.3
@@ -125,7 +125,7 @@ struct pci_dev * pci_get_slot(struct pci
 	WARN_ON(in_interrupt());
 	spin_lock(&pci_bus_lock);
 
-	list_for_each(tmp, &bus->children) {
+	list_for_each(tmp, &bus->devices) {
 		dev = pci_dev_b(tmp);
 		if (dev->devfn == devfn)
 			goto out;

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
