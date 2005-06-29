Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262234AbVF2Bx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbVF2Bx4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 21:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbVF2Bui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 21:50:38 -0400
Received: from gate.crashing.org ([63.228.1.57]:29088 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262328AbVF2Btm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 21:49:42 -0400
Subject: Re: [PATCH 1/13]: PCI Err: pci.h header file changes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org, long <tlnguyen@snoqualmie.dp.intel.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Greg KH <greg@kroah.com>, ak@muc.de, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@us.ibm.com
In-Reply-To: <20050628235817.GA6324@austin.ibm.com>
References: <20050628235817.GA6324@austin.ibm.com>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 11:43:56 +1000
Message-Id: <1120009436.5133.225.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-28 at 18:58 -0500, Linas Vepstas wrote:
> +
> +/* PCI bus error event callbacks */
> +struct pci_error_handlers
> +{
> +       enum pci_channel_state error_state;       /* current error state */
> +       int (*error_detected)(struct pci_dev *dev, enum pci_channel_state error);
> +       int (*mmio_enabled)(struct pci_dev *dev); /* MMIO has been reanbled, but not DMA */
> +       int (*link_reset)(struct pci_dev *dev);   /* PCI Express link has been reset */
> +       int (*slot_reset)(struct pci_dev *dev);   /* PCI slot has been reset */
> +       void (*resume)(struct pci_dev *dev);      /* Device driver may resume normal operations */
> +};

The state variable shouldn't be in that structure. As Greg pointed, we
should have a pointer to that structure in pci_driver, not a copy, and
the error state should be in pci_dev. (With you current code, it's per
driver which is broken anyway).

Ben.

