Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbTKBSM0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 13:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbTKBSM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 13:12:26 -0500
Received: from gn78-101.ma.emulex.com ([138.239.78.101]:47043 "EHLO
	wintermute.ma.emulex.com") by vger.kernel.org with ESMTP
	id S261771AbTKBSMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 13:12:25 -0500
Date: Sun, 2 Nov 2003 13:12:24 -0500
From: Jamie Wellnitz <Jamie.Wellnitz@emulex.com>
To: linux-kernel@vger.kernel.org
Subject: virt_to_page/pci_map_page vs. pci_map_single
Message-ID: <20031102181224.GD2149@ma.emulex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see code similar to the following in a few drivers (qlogicfc,
sym53c8xx, acenic does something similar):

page = virt_to_page(buffer);
offset = ((unsigned long)buffer & ~PAGE_MASK);
busaddr = pci_map_page(pci_dev, page, offset, len, direction);

How is this preferable to:

pci_map_single( pci_dev, buffer, len, direction);

?

pci_map_single can't handle highmem pages (because they don't have a
kernel virtual address) but doesn't virt_to_page suffer from the same
limitation?  Is there some benefit on architectures that don't have
highmem?

Thanks,
Jamie Wellnitz
Jamie.Wellnitz@emulex.com
