Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265375AbTFFHat (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 03:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265377AbTFFHat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 03:30:49 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:55815 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265375AbTFFHas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 03:30:48 -0400
Date: Fri, 6 Jun 2003 08:44:10 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, manfred@colorfullife.com,
       axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: problem with blk_queue_bounce_limit()
Message-ID: <20030606084410.A14779@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"David S. Miller" <davem@redhat.com>, davidm@hpl.hp.com,
	davidm@napali.hpl.hp.com, manfred@colorfullife.com, axboe@suse.de,
	linux-kernel@vger.kernel.org
References: <16096.14281.621282.67906@napali.hpl.hp.com> <20030605.235249.35666087.davem@redhat.com> <16096.16492.286361.509747@napali.hpl.hp.com> <20030606.003230.15263591.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030606.003230.15263591.davem@redhat.com>; from davem@redhat.com on Fri, Jun 06, 2003 at 12:32:30AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 06, 2003 at 12:32:30AM -0700, David S. Miller wrote:
> We could convert the few compile time checks of PCI_DMA_BUS_IS_PHYS
> so that you can set this based upon the configuration of the machine
> if for some configurations it is true.  drivers/net/tg3.c is the
> only offender, my bad :-)

That reminds of of another thing that came up when looking over
the scsi bounce limit setting code.  All this bounce code ist based
purely on a scsi host and if existant it's struct device - imo
PCI_DMA_BUS_IS_PHYS should be a propert of each struct device because
a machine might have a iommu for one bus type but not another, e.g.

	dma_is_phys(dev);

For those arches that need it this could be expanded to per-bus
code, for all those where everything is either phys or not it
would be a simple define that ignores the argument and still produces
"perfect" code.
