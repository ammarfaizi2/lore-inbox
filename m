Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932678AbVIMPeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932678AbVIMPeN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 11:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932679AbVIMPeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 11:34:13 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:42131 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932678AbVIMPeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 11:34:12 -0400
Date: Tue, 13 Sep 2005 12:02:55 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Norbert Kiesel <nkiesel@tbdnetworks.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13.1 locks machine after some time, 2.6.12.5 work fine
Message-ID: <20050913120255.A16713@mail.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0509130755280.3351@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2005, Linus Torvalds wrote:
> On Tue, 13 Sep 2005, Linus Torvalds wrote:
> > 
> > I bet this will fix it..
> 
> Btw, there's a third case of this in the hpt34x driver. I'll fix that
> one too.

That made me do some grepping of my own. Nothing obvious, but this bit
from drivers/scsi/qla2xxx/qla_init.c seems a little odd:

        uint16_t w, mwi;
	...
        /* Reset expansion ROM address decode enable */
        pci_read_config_word(ha->pdev, PCI_ROM_ADDRESS, &w);
        w &= ~PCI_ROM_ADDRESS_ENABLE;
        pci_write_config_word(ha->pdev, PCI_ROM_ADDRESS, w);

Is the address register really only 16 bits wide on some hw?

--Adam

