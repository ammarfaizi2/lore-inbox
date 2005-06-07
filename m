Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261967AbVFGUMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbVFGUMK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 16:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbVFGUMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 16:12:09 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:11484 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261947AbVFGULu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 16:11:50 -0400
Date: Tue, 7 Jun 2005 22:08:20 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.12-rc6-mm1 & Chelsio driver
Message-ID: <20050607200820.GA25546@electric-eye.fr.zoreil.com>
References: <20050607181300.GL2369@mail.muni.cz> <42A5EC7C.4020202@pobox.com> <20050607185845.GM2369@mail.muni.cz> <42A5F51B.5060909@pobox.com> <20050607193305.GN2369@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050607193305.GN2369@mail.muni.cz>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Hejtmanek <xhejtman@mail.muni.cz> :
[...]
> > >    Ethernet controller: PCI device 1425:0006 (ASIC Designers Inc) (rev 0).
> > >      IRQ 24.
> > >      Master Capable.  Latency=248.  
> > >      Non-prefetchable 64 bit memory at 0xf6042000 [0xf6042fff].

/me greps in -mm

#define CH_DEVICE(devid, ssid, idx) \
	{ PCI_VENDOR_ID_CHELSIO, devid, PCI_ANY_ID, ssid, 0, 0, idx }
[...]
enum {
       CH_BRD_N110_1F,
       CH_BRD_N210_1F,
       CH_BRD_T210_1F,
};
[...]
struct pci_device_id t1_pci_tbl[] = {
	CH_DEVICE(7, 0, CH_BRD_N110_1F),
	CH_DEVICE(10, 1, CH_BRD_N210_1F),
	{ 0, }
};

-> it does not match your 0006 revision. No wonder nothing gets detected.

As a quick hack, one could cross fingers and add a
CH_DEVICE(6, 0, CH_BRD_N110_1F)

or, if it does not work:

CH_DEVICE(6, 1, CH_BRD_N210_1F)

(the drivers code suggests some deep differences between CH_BRD_N210_1F
and CH_BRD_N110_1F wrt irq management for instance)

If it does not work at all, someone will have to dissect the whole
thing. Please fill an entry at bugzilla.kernel.org, add it your lspci info
and make it link the 2.6.6 driver from Chelsio's website.

--
Ueimor
