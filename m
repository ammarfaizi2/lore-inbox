Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265058AbTAJNYg>; Fri, 10 Jan 2003 08:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265051AbTAJNYg>; Fri, 10 Jan 2003 08:24:36 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:17810
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265058AbTAJNYf>; Fri, 10 Jan 2003 08:24:35 -0500
Subject: Re: [PATCH]Re: spin_locks without smp.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Maciej Soltysiak <solt@dns.toxicfilms.tv>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030110130446.GR23814@holomorphy.com>
References: <Pine.LNX.4.51.0301101238560.6124@dns.toxicfilms.tv>
	 <20030110114546.GN23814@holomorphy.com>
	 <20030110114855.GO23814@holomorphy.com>
	 <Pine.LNX.4.51.0301101308410.25610@dns.toxicfilms.tv>
	 <1042204846.28469.75.camel@irongate.swansea.linux.org.uk>
	 <20030110130446.GR23814@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042208362.28469.103.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 10 Jan 2003 14:19:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-10 at 13:04, William Lee Irwin III wrote:
> Okay, what I'm getting here is that the UP case already has preempt
> disabled b/c the locks are taken in IRQ context?

The tx/timeout path isnt always in IRQ context. It may have pre-empt
disabled I'm just playing safe

> The thing I don't get is how the spinlock bits cause horrendous
> timing issues on UP that are different from SMP, esp. b/c they are
> #ifdef'd elsewhere to do nothing but inc/dec preempt_count elsewhere.
> There's a bit of "how did it happen" missing in my mind at least

Take a look at 8390.c for the whole how to do it SMP thing. That took
2 months to debug. For junk like the eexpress I've taken the attitude
that people who stick on in an SMP box deserve what tkey get. OTOH
lots of old single cpu boxes ues them and with the ifdef stuff in they
are perfectly usable cards for firewalls, linux terminal server recycled
PC's in schools and so forth.

> > 	preempt_disable()
> > 	disable_irq()
> > #ifdef CONFIG_SMP
> > 	spin_lock_...
> > #endif
> 
> Hmm, the part I'm missing here is why folding the preempt_disable()
> into the spin_lock() is wrong. Or is it the implicit local_irq_save()
> that's the (massive performance) problem?

Its the implicit irqsave we need to avoid

> I'm tied up with 64GB at the moment so my wetware cpu cycles are really
> totally unavailable for this. =(

Commiserations. I suspect the ethernet stuff is easier.

Alan

