Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbTIVGQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 02:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbTIVGQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 02:16:58 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:40662 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S263014AbTIVGQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 02:16:53 -0400
To: Greg Stark <gsstark@MIT.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New System freezes for seconds to minutes then recovers [2.4.23-pre4]
References: <87smmqp2nt.fsf@stark.dyndns.tv>
In-Reply-To: <87smmqp2nt.fsf@stark.dyndns.tv>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 22 Sep 2003 02:16:43 -0400
Message-ID: <87fzip73g4.fsf@stark.dyndns.tv>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Stark <gsstark@MIT.EDU> writes:

> I just set up a new system with an Asus P4P800 and P4 with HT. Under
> 2.4.23-pre4 the system freezes occasionally for a few seconds, sometimes for
> as long as a minute. Then it recovers as if nothing happened. No printks,

I think I've identified a culprit. Kind of. There are three drives in the
machine, one old 7G Quantum, an 80G Maxtor, (both on the same IDE channel),
and a new SATA maxtor. Whenever noflushd has the 80G Maxtor spun down I get
these freezes randomly. Not when it's spinning down, it happens randomly any
time while the drive is spun down.

In fact the whole spin-down spin-up sequence doesn't seem to work right at
all. Under older kernels the drive started spinning up immediately whenever it
was accessed. Under this kernel the drive doesn't even start audibly spinning
up for a long time, like 10s or so. Then I see errors in dmesg like the ones
below. Note that the problems still occur even once dma is disabled, though
they seem less severe. For some reason the problem only seems related to the
Maxtor, not the Quantum.

hdb: dma_timer_expiry: dma status == 0x61
hdb: error waiting for DMA
hdb: dma timeout retry: status=0xd0 { Busy }

hda: DMA disabled
hdb: DMA disabled
ide0: reset: success
blk: queue c035a268, I/O limit 4095Mb (mask 0xffffffff)

wait_on_irq, CPU 1:
irq:  0 [ 1 0 ]
bh:   1 [ 1 0 ]
Stack dumps:
CPU 0: <unknown> 
CPU 1:f7ed3f28 00000001 00000001 ffffffff 00000080 c0109e18 c02653a4 00000001 
       f4d2d000 c0108ff2 00000001 00000001 c01bcbd7 c0118a86 d9776000 c0349a14 
       00000000 f4d2d168 c02a65c4 f7ed3f88 00000000 f7ed2000 c0121cba f4d2d000 
Call Trace:    [<c0109e18>] [<c0108ff2>] [<c01bcbd7>] [<c0118a86>] [<c0121cba>]
  [<c012ae5e>] [<c012ac80>] [<c0105000>] [<c010592e>] [<c012ac80>]

hdb: dma_timer_expiry: dma status == 0x41
hdb: error waiting for DMA
hdb: dma timeout retry: status=0xd0 { Busy }

hdb: DMA disabled
ide0: reset: success

-- 
greg

