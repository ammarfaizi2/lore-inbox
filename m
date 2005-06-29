Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262376AbVF2BBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262376AbVF2BBn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 21:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbVF2BAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 21:00:39 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:12979 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S262376AbVF2ApF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 20:45:05 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] net: add driver for the NIC on Cell Blades
Date: Wed, 29 Jun 2005 02:38:58 +0200
User-Agent: KMail/1.7.2
Cc: Jeff Garzik <jgarzik@pobox.com>, netdev@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Jens Osterkamp <Jens.Osterkamp@de.ibm.com>,
       Utz Bacher <utz.bacher@de.ibm.com>
References: <200506281528.08834.arnd@arndb.de> <1119966799.3175.32.camel@laptopd505.fenrus.org>
In-Reply-To: <1119966799.3175.32.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200506290238.59231.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dinsdag 28 Juni 2005 15:53, Arjan van de Ven wrote:
> 
> > +static void
> > +spider_net_rx_irq_off(struct spider_net_card *card)
> > +{
> > +       u32 regvalue;
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&card->intmask_lock, flags);
> > +       regvalue = spider_net_read_reg(card, SPIDER_NET_GHIINT0MSK);
> > +       regvalue &= ~SPIDER_NET_RXINT;
> > +       spider_net_write_reg(card, SPIDER_NET_GHIINT0MSK, regvalue);
> > +       spin_unlock_irqrestore(&card->intmask_lock, flags);
> > +}
> 
> I think you have a PCI posting bug here....

Could you be more specific? My guess would be that the 'sync' in writel
takes care of this. Should there be an extra mmiowb() in here or are
you referring to some other problem?

	Arnd <><
