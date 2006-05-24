Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWEXQ6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWEXQ6j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 12:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWEXQ6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 12:58:39 -0400
Received: from [194.90.237.34] ([194.90.237.34]:42639 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S1751127AbWEXQ6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 12:58:38 -0400
Date: Wed, 24 May 2006 19:59:58 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Greg KH <gregkh@suse.de>, Roland Dreier <rolandd@cisco.com>
Cc: Brice Goglin <brice@myri.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: AMD 8131 MSI quirk called too late, bus_flags not inherited ?
Message-ID: <20060524165958.GE21266@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <4468EE85.4000500@myri.com> <20060518155441.GB13334@suse.de> <20060521101656.GM30211@mellanox.co.il> <447047F2.2070607@myri.com> <20060521121726.GQ30211@mellanox.co.il> <44705DA4.2020807@myri.com> <20060521131025.GR30211@mellanox.co.il> <447069F7.1010407@myri.com> <20060523041958.GA8415@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060523041958.GA8415@suse.de>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 24 May 2006 17:02:40.0968 (UTC) FILETIME=[DDF82C80:01C67F53]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Greg KH <gregkh@suse.de>:
> > Right, thanks. Greg, what do you think of putting the attached patch in
> > 2.6.17 ?
> 
> Ok, does everyone agree that this patch fixes the issues for them?

Worked here on a PCI-X AMD-8131 based system.

----

Offtopic, something I wanted to bring up with respect to MSI,
but never had the time to debug:

If I do

pci_enable_msix, pci_disable_msix

then later

pci_enable_msi

on the same device fails with the following message:
PCI: 0000:08:00.0: Can't enable MSI.  Device already has MSI-X vectors assigned

This is not something new - has been happening since forever.
Looks like not all MSI-X vectors get properly unassigned by pci_disable_msix.

One way to test this is by loading mthca driver with msi_x=1, unloading
and loading with msi=1.

Someone has any idea what's wrong?

-- 
MST
