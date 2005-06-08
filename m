Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbVFHSrC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVFHSrC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 14:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVFHSrC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 14:47:02 -0400
Received: from [194.90.237.34] ([194.90.237.34]:63047 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S261501AbVFHSq6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 14:46:58 -0400
Date: Wed, 8 Jun 2005 21:47:22 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Greg KH <gregkh@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, tom.l.nguyen@intel.com,
       roland@topspin.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi() for drivers - take 2
Message-ID: <20050608184722.GA11380@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20050608060242.GA8035@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050607002045.GA12849@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, anyone else think this is a good idea?  Votes for me to just drop it
> and go back to hacking on the driver core instead?

OT, what I'd like see changed with current MSI/MSI-X code is
the masking/unmasking of vectors currently performed on each interrupt.

Note that in MSI some devices dont support per-vector masking,
while in MSI-X the masking is performed by means of PCI write with no flush,
which might not yet reach the device by the time the handler is called.

IMHO, its better to have helper functions for drivers to mask/unmask vectors
if/when they need to, removing some overhead for drivers that dont need this
masking, and giving drivers the ability to combine the masking write with
read to actually mask interrupts if they do need it.

Does this make sense to anyone?

MST
