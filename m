Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261766AbSIXSQl>; Tue, 24 Sep 2002 14:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261768AbSIXSQl>; Tue, 24 Sep 2002 14:16:41 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:23791 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S261766AbSIXSQk>;
	Tue, 24 Sep 2002 14:16:40 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15760.44345.987685.413861@napali.hpl.hp.com>
Date: Tue, 24 Sep 2002 11:21:45 -0700
To: Dave Olien <dmo@osdl.org>
Cc: davidm@hpl.hp.com, "David S. Miller" <davem@redhat.com>, phillips@arcor.de,
       davidm@napali.hpl.hp.com, axboe@suse.de, _deepfire@mail.ru,
       linux-kernel@vger.kernel.org
Subject: Re: DAC960 in 2.5.38, with new changes
In-Reply-To: <20020924102843.C17658@acpi.pdx.osdl.net>
References: <20020923120400.A15452@acpi.pdx.osdl.net>
	<15759.26918.381273.951266@napali.hpl.hp.com>
	<E17ta3t-0003bj-00@starship>
	<20020923.135447.24672280.davem@redhat.com>
	<20020924095456.A17658@acpi.pdx.osdl.net>
	<15760.40126.378814.639307@napali.hpl.hp.com>
	<20020924102843.C17658@acpi.pdx.osdl.net>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 24 Sep 2002 10:28:43 -0700, Dave Olien <dmo@osdl.org> said:

  Dave> Hmm, interesting.  A big part of what I'm doing to the driver
  Dave> right now is plugging in calls to the PCI DMA interfaces.

That's fine (actually, it's more than that: it's great!).

  Dave> So unless the underlying implementation is aware of these
  Dave> platform limitations and "doing the right thing", I'm adding
  Dave> a bunch of bounce buffer activity for many ia64 platforms.
  Dave> That would be too bad.

The idea is to do something along these lines:

 o Use PCA DMA interface for managing all DMA buffers.

 o If sizeof(dma_addr_t) > 4, turn on DAC mode and call
   pci_set_dma_mask(dev, MAX_ADDR), where MAX_ADDR is the maximum
   address that can be reached by the controller (i.e.,
   0xffffffffffffffff for a truly 64-bit-capable PCI controller).

This way, everything should work out correctly and with good
performance on all imaginable platforms (ia64 with and without
hardware I/O TLB, plain x86, x86 with >4GB RAM, SPARC64 with 32-bit
dma_addr_t, etc.).

	--david
