Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbWIHWtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWIHWtw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 18:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWIHWtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 18:49:51 -0400
Received: from gate.crashing.org ([63.228.1.57]:10122 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751150AbWIHWtu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 18:49:50 -0400
Subject: Re: TG3 data corruption (TSO ?)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Chan <mchan@broadcom.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
In-Reply-To: <1157755220.9584.21.camel@rh4>
References: <1551EAE59135BE47B544934E30FC4FC093FB19@NT-IRVA-0751.brcm.ad.broadcom.com>
	 <1157751689.31071.97.camel@localhost.localdomain>
	 <1157753242.9584.4.camel@rh4>
	 <1157754326.31071.115.camel@localhost.localdomain>
	 <1157755220.9584.21.camel@rh4>
Content-Type: text/plain
Date: Sat, 09 Sep 2006 08:49:33 +1000
Message-Id: <1157755773.31071.118.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I'd rather not have to do that, or even if I go that way, not have to
> > add that sync at all before the store and thus get back the few percent
> > of perfs lost due to those sync's on some heavy IO benchmarks.
> > 
> Another way to fix this without requiring drivers to add all kinds of
> barriers in the driver code is to add a writel_sync() variant.  So on
> powerpc, writel_sync() will have a sync before and after the write.  On
> most other architectures, writel_sync() is the same as writel() if the
> ordering is guaranteed.  We'll then convert tg3 and other drivers to use
> writel_sync() in places where they're needed.

I think the preferred approach for that sort of thing is to have writel
be the "sync" version and add special "relaxed" version. Now there have
been talks and debates about relaxed IOs but they generally map to
something different, typically IOs that are relaxed vs. DMA (PCI-X/PCIe
relaxed ordering options for example).

Adding yet another round of IO accessors sounds like a bit nasty to me,
driver writers will potentially not understand which ones to use etc...

Anyway, I think I'll let Anton and Paulus argue that one for now.

Cheers,
Ben.


