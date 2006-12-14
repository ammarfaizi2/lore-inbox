Return-Path: <linux-kernel-owner+w=401wt.eu-S1751879AbWLNAel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbWLNAel (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 19:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751596AbWLNAel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 19:34:41 -0500
Received: from gate.crashing.org ([63.228.1.57]:50837 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751874AbWLNAej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 19:34:39 -0500
Subject: Re: [PATCH 0/6] PCI-X/PCI-Express read control interfaces
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061213161734.42821fdf@freekitty>
References: <20061208182241.786324000@osdl.org>
	 <1165808912.7260.14.camel@localhost.localdomain>
	 <20061213161734.42821fdf@freekitty>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 11:34:24 +1100
Message-Id: <1166056464.11914.249.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I am thinking in the next revision of these of masking the distinction
> between pci-x and pci express and just have:
> 
> pci_get_read_count
> pci_get_max_read_count
> pci_set_read_count

We absolutely need an arch hook though to limit the size. We need to
make sure we don't go over the capabilities of parent bridges,
especially the host bridge. P2P bridges and most PCIe host bridges can
be handled by generic code but pretty much no PCI-X host bridge, they'll
need an arch hook.

Ben.


