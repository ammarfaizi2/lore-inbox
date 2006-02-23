Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751015AbWBWA0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbWBWA0F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 19:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbWBWA0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 19:26:05 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:21950 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751015AbWBWA0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 19:26:03 -0500
Subject: Re: [PATCH 9/13] ATA ACPI: check SATA/PATA more carefully
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       akpm@osdl.org, jgarzik@pobox.com
In-Reply-To: <20060222140008.3832951a.randy_d_dunlap@linux.intel.com>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>
	 <20060222140008.3832951a.randy_d_dunlap@linux.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Feb 2006 00:30:04 +0000
Message-Id: <1140654604.8672.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-02-22 at 14:00 -0800, Randy Dunlap wrote:
> +	if (ap->legacy_mode) {
>  		err = pata_get_dev_handle(dev, &dev_handle, &pcidevfn);
>  		if (err < 0) {
>  			if (ata_msg_probe(ap))

ap->legacy mode tells you if one of a subset of PCI controllers is in
native or legacy compatibility mode. It tells you nothing about whether
the controller is SATA or PATA. In fact it may even be both at once as
there may be a SATA bridge on one channel in some configurations. The
field is also meaningless for PCI controllers that are not class IDE.

The cable type field will tell you in some situations if we are PATA or
SATA but we actually don't always know at the moment. We probably have
the info for 99.9% of cases if needed it just isnt ap->legacy_mode, its
cable type plus the PATA/SATA bridge knobbling check.

Alan
