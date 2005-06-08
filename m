Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVFHQEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVFHQEU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 12:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVFHQCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 12:02:07 -0400
Received: from webmail.topspin.com ([12.162.17.3]:55132 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261345AbVFHP5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 11:57:23 -0400
To: Andi Kleen <ak@suse.de>
Cc: Andrew Grover <andy.grover@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Greg KH <gregkh@suse.de>, "David S. Miller" <davem@davemloft.net>,
       tom.l.nguyen@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi()
 for drivers - take 2
X-Message-Flag: Warning: May contain useful information
References: <20050607002045.GA12849@suse.de>
	<20050607202129.GB18039@kroah.com> <42A61CDE.6090906@pobox.com>
	<c0a09e5c05060722558a86ac8@mail.gmail.com>
	<20050608133503.GT23831@wotan.suse.de>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 08 Jun 2005 08:57:22 -0700
In-Reply-To: <20050608133503.GT23831@wotan.suse.de> (Andi Kleen's message of
 "Wed, 8 Jun 2005 15:35:03 +0200")
Message-ID: <52k6l4et99.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 08 Jun 2005 15:57:22.0753 (UTC) FILETIME=[C1F38310:01C56C42]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andi> I think we should have the right (default MSI) API by
    Andi> default.  If we wait 5 years we end up with lots of mess in
    Andi> the drivers.

I agree that we should get the API correct as soon as we can.  However
I would argue that one property of the correct API would be that
changing the default from MSI turned off to MSI turned on should not
affect the API.

I like Jeff's suggestion of rolling more common code into
pci_enable_device().  However I'm not sure if this fixes the MSI mess
completely -- there may be some devices where the driver wants to test
interrupt generation and disable MSI if it fails.  However this may be
enough of a special case that we can just add a flag to those
particular drivers so that users can manually control the use of MSI.

 - R.

