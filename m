Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262713AbRE3KhQ>; Wed, 30 May 2001 06:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262720AbRE3KhH>; Wed, 30 May 2001 06:37:07 -0400
Received: from indyio.rz.uni-sb.de ([134.96.7.3]:60191 "EHLO
	indyio.rz.uni-sb.de") by vger.kernel.org with ESMTP
	id <S262713AbRE3Kgw>; Wed, 30 May 2001 06:36:52 -0400
Message-ID: <3B14CD25.FFF8019E@stud.uni-saarland.de>
Date: Wed, 30 May 2001 10:36:21 +0000
From: Studierende der Universitaet des Saarlandes 
	<masp0008@stud.uni-sb.de>
Reply-To: manfred@colorfullife.com
Organization: Studierende Universitaet des Saarlandes
X-Mailer: Mozilla 4.08 [en] (X11; I; Linux 2.0.36 i686)
MIME-Version: 1.0
To: alan@lxorguk.ukuu.org.uk
CC: linux-kernel@vger.kernel.org, ankry@green.mif.pg.gda.pl
Subject: Re: [PATCH] net 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > @@ -643,9 +631,7 @@ 
> >  eexp_hw_tx_pio(dev,data,length); 
> > } 
> > dev_kfree_skb(buf); 
> > -#ifdef CONFIG_SMP 
> > spin_unlock_irqrestore(&lp->lock, flags); 
> > -#endif 
> > enable_irq(dev->irq); 
> > return 0; 
> 
> They are done this way to get good non SMP performance. Your changes would 
> ruin that. 

I think the spin_lock could be removed on SMP, too.

Concurrent xmit & timeout calls are prevented by core network code, and
concurrent interrupts are prevented by disable_irq().

Or replace spin_lock_irqsave() with spin_lock().

--
	Manfred
