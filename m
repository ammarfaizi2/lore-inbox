Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265008AbTAXT6T>; Fri, 24 Jan 2003 14:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265051AbTAXT6S>; Fri, 24 Jan 2003 14:58:18 -0500
Received: from zmamail04.zma.compaq.com ([161.114.64.104]:16141 "EHLO
	zmamail04.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S265008AbTAXT6L>; Fri, 24 Jan 2003 14:58:11 -0500
Date: Fri, 24 Jan 2003 15:04:59 -0500
From: "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>
To: "David S. Miller" <davem@redhat.com>
Cc: jgarzik@pobox.com, ink@jurassic.park.msu.ru, willy@debian.org,
       linux-kernel@vger.kernel.org, Jeff Wiedemeier <Jeff.Wiedemeier@hp.com>
Subject: Re: [patch 2.5] tg3.c: pci_{save,restore}_extended_state
Message-ID: <20030124150459.A3123@dsnt25.mro.cpqcorp.net>
References: <20030124212748.C25285@jurassic.park.msu.ru> <20030124193135.GA30884@gtf.org> <20030124150006.A2882@dsnt25.mro.cpqcorp.net> <20030124.115355.51751971.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030124.115355.51751971.davem@redhat.com>; from davem@redhat.com on Fri, Jan 24, 2003 at 11:53:55AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2003 at 11:53:55AM -0800, David S. Miller wrote:
>    From: "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>
>    Date: Fri, 24 Jan 2003 15:00:06 -0500
> 
>    The problem is that if the chip is configured for MSI (through config
>    space) and the platform's irq mapping code therefore filled in
>    pci_dev->irq with an appropriate vector for the MSI interrupt the chip
>    is assigned instead of the LSI interrupt it may also be assigned, then
>    unless MSGINT_MODE matches PCI_MSI_FLAGS_ENABLE, the driver will grab
>    wrong interrupt.
>    
> Why isn't it enabled at the point where we save the extended state?

It was (in config space) and that's why PCI_MSI_FLAGS_ENABLE is still
enabled after the restore of extended state. MSGINT_MODE is a
tigon3-specific register (not config space) and it's state does not
follow PCI_MSI_FLAGS_ENABLE in the MSI capability.

/jeff
