Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262808AbVDBBKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262808AbVDBBKg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 20:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262809AbVDBBKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 20:10:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:915 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262808AbVDBBKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 20:10:30 -0500
Date: Sat, 2 Apr 2005 02:10:23 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       gregkh@suse.de, prarit@sgi.com
Subject: Re: PCI: fix an oops in some pci devices on hotplug remove when their resources are being freed.
Message-ID: <20050402011023.GG21986@parcelfarce.linux.theplanet.co.uk>
References: <11123992702166@kroah.com> <11123992703458@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11123992703458@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2005 at 03:47:50PM -0800, Greg KH wrote:
> PCI: fix an oops in some pci devices on hotplug remove when their resources are being freed.
> 
> As reported by Prarit Bhargava <prarit@sgi.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> diff -Nru a/drivers/pci/remove.c b/drivers/pci/remove.c
>  	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
>  		struct resource *res = dev->resource + i;
> -		if (res->parent)
> +		if (res && res->parent)
>  			release_resource(res);

I can't believe this fixes anything.  How can res possibly be NULL here?
It's a pointer into a pci_dev.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
