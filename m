Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161009AbWJOOVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161009AbWJOOVv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 10:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161008AbWJOOVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 10:21:51 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:3730 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161007AbWJOOVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 10:21:50 -0400
Subject: Re: + drivers-ide-fix-error-return-bugs-interface.patch added to
	-mm tree
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jeff@garzik.org
In-Reply-To: <200610102047.k9AKl53O022518@shell0.pdx.osdl.net>
References: <200610102047.k9AKl53O022518@shell0.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 15 Oct 2006 15:46:46 +0100
Message-Id: <1160923606.5732.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-10-10 am 13:47 -0700, ysgrifennodd akpm@osdl.org:
> This fixes the following error handling problems:
> 
> * The init_chipset API function is defined to return 'unsigned int', but
> 	- the caller code tests the return value for '< 0'
> 	- drivers sometimes return a negative value

Dropped for good. The core code doesn't support failing in init_chipset.
Instead I've adjusted via82cxxx to do the check earlier in init_one().
Also avoids an API change and all the noise.

> * cs5530: handle pci_set_mwi() failure with a printk()... shouldn't kill driver

NAK. Fix is to remove bogus must_check from pci_set_mwi (and some of the
other functions)

> * sc1200: handle pci_enable_device() failure during resume

NAK: if the pci_enable_device fails here the best we can do is attempt
to get it back and hope the pci_enable_device failure is bogus. This is
a can't happen case anyway so its a waste of memory. If you insist on
checking pci_enable_device returns everywhere then please move the
printk into the pci_enable_device function so that we don't bloat the
kernel with a load of pointless identically messages for an event that
never happen, one per driver.

Alan

