Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266796AbTBTS4K>; Thu, 20 Feb 2003 13:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266805AbTBTS4K>; Thu, 20 Feb 2003 13:56:10 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:29712 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266796AbTBTS4J>; Thu, 20 Feb 2003 13:56:09 -0500
Date: Thu, 20 Feb 2003 19:06:13 +0000
From: Christoph Hellwig <hch@infradead.org>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] cli() for net/atm/lec.c
Message-ID: <20030220190613.A8663@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	chas williams <chas@locutus.cmf.nrl.navy.mil>,
	linux-kernel@vger.kernel.org
References: <200302201751.h1KHpKqA009567@locutus.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200302201751.h1KHpKqA009567@locutus.cmf.nrl.navy.mil>; from chas@locutus.cmf.nrl.navy.mil on Thu, Feb 20, 2003 at 12:51:20PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  extern void (*br_fdb_put_hook)(struct net_bridge_fdb_entry *ent);
> +static spinlock_t lec_arp_spinlock = SPIN_LOCK_UNLOCKED;
> +static unsigned long lec_arp_flags;
>  
> +#define LEC_ARP_LOCK()   spin_lock_irqsave(&lec_arp_spinlock, lec_arp_flags);
> +#define LEC_ARP_UNLOCK() spin_unlock_irqrestore(&lec_arp_spinlock, lec_arp_flags);

I don't think this is a good idea - use the spin_lock calls directly and
always use flags on the stack.

>          dev->get_stats = lec_get_stats;
>          dev->set_multicast_list = NULL;
>          dev->do_ioctl  = NULL;
> +	spin_lock_init(&lec_arp_spinlock);

not needed - you already initialized it at compiletime

