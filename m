Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266431AbTBTTTR>; Thu, 20 Feb 2003 14:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266540AbTBTTTR>; Thu, 20 Feb 2003 14:19:17 -0500
Received: from havoc.daloft.com ([64.213.145.173]:14489 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S266431AbTBTTTQ>;
	Thu, 20 Feb 2003 14:19:16 -0500
Date: Thu, 20 Feb 2003 14:29:17 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Christoph Hellwig <hch@infradead.org>,
       chas williams <chas@locutus.cmf.nrl.navy.mil>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] cli() for net/atm/lec.c
Message-ID: <20030220192917.GO9800@gtf.org>
References: <200302201751.h1KHpKqA009567@locutus.cmf.nrl.navy.mil> <20030220190613.A8663@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030220190613.A8663@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 07:06:13PM +0000, Christoph Hellwig wrote:
> >  extern void (*br_fdb_put_hook)(struct net_bridge_fdb_entry *ent);
> > +static spinlock_t lec_arp_spinlock = SPIN_LOCK_UNLOCKED;
> > +static unsigned long lec_arp_flags;
> >  
> > +#define LEC_ARP_LOCK()   spin_lock_irqsave(&lec_arp_spinlock, lec_arp_flags);
> > +#define LEC_ARP_UNLOCK() spin_unlock_irqrestore(&lec_arp_spinlock, lec_arp_flags);
> 
> I don't think this is a good idea - use the spin_lock calls directly and
> always use flags on the stack.

Good spotting, though I would be more direct :)

Simon sez, "Don't do that"

1) use 'unsigned long flags' on the stack
2) do _not_ pass this variable between functions

	Jeff


