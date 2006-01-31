Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWAaP5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWAaP5O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 10:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWAaP5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 10:57:14 -0500
Received: from [212.76.85.204] ([212.76.85.204]:28164 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1750772AbWAaP5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 10:57:14 -0500
From: Al Boldi <a1426z@gawab.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc1-mm4
Date: Tue, 31 Jan 2006 18:56:13 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <20060129144533.128af741.akpm@osdl.org> <200601301620.49199.a1426z@gawab.com> <20060130130007.4925e3ed.akpm@osdl.org>
In-Reply-To: <20060130130007.4925e3ed.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200601311856.13221.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Al Boldi <a1426z@gawab.com> wrote:
> > Andrew Morton wrote:
> > > - Various other random bits and pieces.  Things have been pretty quiet
> > >   lately - most activity seems to be concentrated about putting bugs
> > > into the various subsystem trees.
> >
> > Does it fix the DRM_i810 hang during a suspend-to-ram/disk cycle?
>
> I don't know - I don't watch every patch which goes into 49 different
> trees.  Did you try it?

It still hangs w/ drm.

w/o drm STD works like a charm.
w/o drm STR works lest this t/o and a noisy display in X.

Stopping tasks: ========================|
Suspending device 0.1
Suspending device 0.0
Suspending device ide0
Suspending device floppy.0
Suspending device serio1
Suspending device serio0
Suspending device i8042
Suspending device 0000:01:0a.0
Suspending device 0000:01:05.0
Suspending device 0000:00:1f.2
Suspending device 0000:00:1f.1
Suspending device 0000:00:1f.0
Suspending device 0000:00:1e.0
Suspending device 0000:00:01.0
Suspending device 0000:00:00.0
Suspending device pci0000:00
Suspending device platform
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Back to C!
ACPI: PCI Interrupt 0000:00:01.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> 
IRQ 11
PCI: Setting latency timer of device 0000:00:1e.0 to 64
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
hda: drive not ready on wakeup
hda: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hda: DMA disabled
hdb: DMA disabled
hda: drive not ready for command
ide0: reset: success
BUG: warning at drivers/ide/ide-iops.c:1235/ide_wait_not_busy()
 <c02612e2> ide_wait_not_busy+0xa2/0xb0   <c025ee87> 
start_request+0x1a7/0x230
 <c025f17a> ide_do_request+0x23a/0x3c0   <c026440a> 
set_multmode_intr+0x1a/0x70
 <c025f79b> ide_intr+0xeb/0x130   <c02643f0> set_multmode_intr+0x0/0x70
 <c0135610> handle_IRQ_event+0x30/0x70   <c01356a5> __do_IRQ+0x55/0xc0
 <c0105672> do_IRQ+0x42/0x70  
 =======================
 <c0103976> common_interrupt+0x1a/0x20   <c021886d> 
acpi_processor_idle+0x2b6/0x332
 <c0101030> default_idle+0x0/0x70   <c0101118> cpu_idle+0x58/0x70
 <c03c47bd> start_kernel+0x14d/0x170   <c03c4310> 
unknown_bootoption+0x0/0x1e0
hdb: set_drive_speed_status: status=0x40 { DriveReady }
ide: failed opcode was: unknown
Restarting tasks... done

Also, a 100HZ recompile in mainline causes a 400% delay doing a simple lilo, 
which seems fixed in mm.  Is there a reason you can't move that to mainline?

Thanks!

--
Al

