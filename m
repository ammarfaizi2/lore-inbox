Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261723AbSIXSUJ>; Tue, 24 Sep 2002 14:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261772AbSIXSUJ>; Tue, 24 Sep 2002 14:20:09 -0400
Received: from air-2.osdl.org ([65.172.181.6]:32009 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261723AbSIXSUI>;
	Tue, 24 Sep 2002 14:20:08 -0400
Date: Tue, 24 Sep 2002 11:25:19 -0700
From: Dave Olien <dmo@osdl.org>
To: davidm@hpl.hp.com
Cc: "David S. Miller" <davem@redhat.com>, phillips@arcor.de,
       davidm@napali.hpl.hp.com, axboe@suse.de, _deepfire@mail.ru,
       linux-kernel@vger.kernel.org
Subject: Re: DAC960 in 2.5.38, with new changes
Message-ID: <20020924112519.D17658@acpi.pdx.osdl.net>
References: <20020923120400.A15452@acpi.pdx.osdl.net> <15759.26918.381273.951266@napali.hpl.hp.com> <E17ta3t-0003bj-00@starship> <20020923.135447.24672280.davem@redhat.com> <20020924095456.A17658@acpi.pdx.osdl.net> <15760.40126.378814.639307@napali.hpl.hp.com> <20020924102843.C17658@acpi.pdx.osdl.net> <15760.44345.987685.413861@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15760.44345.987685.413861@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Tue, Sep 24, 2002 at 11:21:45AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, thanks for explaining!

At some point, I want to step back and look over the BIO and DMA code.
Possibly this will be my "project" for October :-)

On Tue, Sep 24, 2002 at 11:21:45AM -0700, David Mosberger wrote:
> >>>>> On Tue, 24 Sep 2002 10:28:43 -0700, Dave Olien <dmo@osdl.org> said:
> 
>   Dave> Hmm, interesting.  A big part of what I'm doing to the driver
>   Dave> right now is plugging in calls to the PCI DMA interfaces.
> 
> That's fine (actually, it's more than that: it's great!).
> 
>   Dave> So unless the underlying implementation is aware of these
>   Dave> platform limitations and "doing the right thing", I'm adding
>   Dave> a bunch of bounce buffer activity for many ia64 platforms.
>   Dave> That would be too bad.
> 
> The idea is to do something along these lines:
> 
>  o Use PCA DMA interface for managing all DMA buffers.
> 
>  o If sizeof(dma_addr_t) > 4, turn on DAC mode and call
>    pci_set_dma_mask(dev, MAX_ADDR), where MAX_ADDR is the maximum
>    address that can be reached by the controller (i.e.,
>    0xffffffffffffffff for a truly 64-bit-capable PCI controller).
> 
> This way, everything should work out correctly and with good
> performance on all imaginable platforms (ia64 with and without
> hardware I/O TLB, plain x86, x86 with >4GB RAM, SPARC64 with 32-bit
> dma_addr_t, etc.).
> 
> 	--david
