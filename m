Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261704AbSIXRGi>; Tue, 24 Sep 2002 13:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261706AbSIXRGi>; Tue, 24 Sep 2002 13:06:38 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:46804 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S261704AbSIXRGi>;
	Tue, 24 Sep 2002 13:06:38 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15760.40126.378814.639307@napali.hpl.hp.com>
Date: Tue, 24 Sep 2002 10:11:26 -0700
To: Dave Olien <dmo@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, phillips@arcor.de, davidm@hpl.hp.com,
       davidm@napali.hpl.hp.com, axboe@suse.de, _deepfire@mail.ru,
       linux-kernel@vger.kernel.org
Subject: Re: DAC960 in 2.5.38, with new changes
In-Reply-To: <20020924095456.A17658@acpi.pdx.osdl.net>
References: <20020923120400.A15452@acpi.pdx.osdl.net>
	<15759.26918.381273.951266@napali.hpl.hp.com>
	<E17ta3t-0003bj-00@starship>
	<20020923.135447.24672280.davem@redhat.com>
	<20020924095456.A17658@acpi.pdx.osdl.net>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 24 Sep 2002 09:54:56 -0700, Dave Olien <dmo@osdl.org> said:

  Dave> According to the Documentation/DMA-mapping.txt file, the new
  Dave> DMA mapping interfaces should allow all PCI transfers to use
  Dave> 32-bit DMA addresses. Controllers on the PCI bus should never
  Dave> need to use DAC PCI transfers.  Based on this, writel() should
  Dave> work even on ia64.

Warning: there is a big difference between *can* and *want*.  On ia64
machines with an Intel chipset, the PCI DMA interface is implemented
via bounce buffers, so it will be *much* slower than DAC.  For this
reason, it is preferable on ia64 to use DAC where possible (and just
in case Dave Miller starts asking about this: yes, the hp zx1 chipset
for Itanium 2 does have a hardware I/O TLB... ;-).

	--david
