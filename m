Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261740AbSIXRl2>; Tue, 24 Sep 2002 13:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261720AbSIXRk4>; Tue, 24 Sep 2002 13:40:56 -0400
Received: from air-2.osdl.org ([65.172.181.6]:528 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261721AbSIXRX1>;
	Tue, 24 Sep 2002 13:23:27 -0400
Date: Tue, 24 Sep 2002 10:28:43 -0700
From: Dave Olien <dmo@osdl.org>
To: davidm@hpl.hp.com
Cc: "David S. Miller" <davem@redhat.com>, phillips@arcor.de,
       davidm@napali.hpl.hp.com, axboe@suse.de, _deepfire@mail.ru,
       linux-kernel@vger.kernel.org
Subject: Re: DAC960 in 2.5.38, with new changes
Message-ID: <20020924102843.C17658@acpi.pdx.osdl.net>
References: <20020923120400.A15452@acpi.pdx.osdl.net> <15759.26918.381273.951266@napali.hpl.hp.com> <E17ta3t-0003bj-00@starship> <20020923.135447.24672280.davem@redhat.com> <20020924095456.A17658@acpi.pdx.osdl.net> <15760.40126.378814.639307@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15760.40126.378814.639307@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Tue, Sep 24, 2002 at 10:11:26AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm, interesting.  A big part of what I'm doing to the driver
right now is plugging in calls to the PCI DMA interfaces.
So unless the underlying implementation is aware of these
platform limitations and "doing the right thing", I'm adding
a bunch of bounce buffer activity for many ia64 platforms.
That would be too bad.

I distantly recall that the cost of doing PCI DAC isn't really
that high for bursty transfers, because the bus is able to
group packets of data cycles behind one initial address cycle.
But it's been many years since I last looked at this and I could have
this wrong.


On Tue, Sep 24, 2002 at 10:11:26AM -0700, David Mosberger wrote:
> >>>>> On Tue, 24 Sep 2002 09:54:56 -0700, Dave Olien <dmo@osdl.org> said:
> 
>   Dave> According to the Documentation/DMA-mapping.txt file, the new
>   Dave> DMA mapping interfaces should allow all PCI transfers to use
>   Dave> 32-bit DMA addresses. Controllers on the PCI bus should never
>   Dave> need to use DAC PCI transfers.  Based on this, writel() should
>   Dave> work even on ia64.
> 
> Warning: there is a big difference between *can* and *want*.  On ia64
> machines with an Intel chipset, the PCI DMA interface is implemented
> via bounce buffers, so it will be *much* slower than DAC.  For this
> reason, it is preferable on ia64 to use DAC where possible (and just
> in case Dave Miller starts asking about this: yes, the hp zx1 chipset
> for Itanium 2 does have a hardware I/O TLB... ;-).
> 
> 	--david
