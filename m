Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263530AbTHVTWU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 15:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263537AbTHVTWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 15:22:20 -0400
Received: from adsl-065-081-070-095.sip.gnv.bellsouth.net ([65.81.70.95]:46276
	"EHLO medicaldictation.com") by vger.kernel.org with ESMTP
	id S263530AbTHVTWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 15:22:12 -0400
Date: Fri, 22 Aug 2003 15:22:13 -0400
From: Chuck Berg <chuck@encinc.com>
To: linux-kernel@vger.kernel.org
Subject: IDE DMA hangs on KT400 (shared IRQ problem?)
Message-ID: <20030822152213.A17232@timetrax.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a machine with a Soyo Dragon motherboard (Via KT400 chipset). It has
an onboard Highpoint HPT372 IDE controller in addition to the Via
chipset's. I run into trouble reading from these drives with DMA enabled at
the same time as heavy network activity. (a hang with or without errors or
a panic, depending on the kernel version). If it manages to work for a few
minutes, I'll get corruption on the disk reads. With DMA off, everything
seems OK.

IRQ 11 is shared between two of these controllers and the network interface.
Also sharing that IRQ is a SCSI controller I'm booting off of, but activity on
that device at the same time as the others doesn't seem to cause any problem.

With 2.4.22-rc2 and 2.6.0-test3, I get these messages:

hdc: dma_timer_expiry: dma status == 0x24
hdg: dma_timer_expiry: dma status == 0x24
hda: dma_timer_expiry: dma status == 0x24
hde: dma_timer_expiry: dma status == 0x24
hdc: DMA interrupt recovery
hdc: lost interrupt
hdg: DMA interrupt recovery
hdg: lost interrupt
hda: DMA interrupt recovery
hda: lost interrupt
hde: DMA interrupt recovery
hde: lost interrupt
sym0:3:0: ABORT operation started.
sym0:3:0: ABORT operation timed-out.
sym0:3:0: ABORT operation started.
sym0:3:0: ABORT operation timed-out.
sym0:3:0: ABORT operation started.
hdc: dma_timer_expiry: dma status == 0x24
hdg: dma_timer_expiry: dma status == 0x24
hda: dma_timer_expiry: dma status == 0x24
hde: dma_timer_expiry: dma status == 0x24

With 2.4.22-rc2-ac3 it just hangs and I get no messages on the console.

With 2.4.22-pre10-ac1, I got these messages:

hda: lost interrupt
int0: transmit timed out, tx_status 00 status e601.
  diagnostics: net 0cd8 media 8880 dma 0000003a.
int0: Interrupt posted but not delivered -- IRQ blocked by another device?
  Flags; bus-master 1, dirty 69987(3) current 69987(3)
  Transmit list 00000000 vs. ddbfd2c0.
  0: @ddbfd200  length 800000b2 status 000100b2
  1: @ddbfd240  length 800000b2 status 800100b2
  2: @ddbfd280  length 800000b2 status 800100b2
  3: @ddbfd2c0  length 800000b2 status 000100b2
  4: @ddbfd300  length 800000b2 status 000100b2
  5: @ddbfd340  length 800000b2 status 000100b2
  6: @ddbfd380  length 800000b2 status 000100b2
  7: @ddbfd3c0  length 800000b2 status 000100b2
  8: @ddbfd400  length 800000b2 status 000100b2
  9: @ddbfd440  length 800000b2 status 000100b2
  10: @ddbfd480  length 800000b2 status 000100b2
  11: @ddbfd4c0  length 800000b2 status 000100b2
  12: @ddbfd500  length 800000b2 status 000100b2
  13: @ddbfd540  length 800000b2 status 000100b2
  14: @ddbfd580  length 800000b2 status 000100b2
  15: @ddbfd5c0  length 800000b2 status 000100b2
hdg: dma_timer_expiry: dma status == 0x24
hdc: dma_timer_expiry: dma status == 0x24
hde: dma_timer_expiry: dma status == 0x24
hda: lost interrupt

(I renamed my network interfaces to ext0 and int0 with nameif)

With 2.4.21 and 2.5.71, I would get a panic in ide_dma_intr().

Additional info:
http://encinc.com/~chuck/kt400/2.4.22rc2-boot1.txt
http://encinc.com/~chuck/kt400/2.4.22rc2-config.txt
http://encinc.com/~chuck/kt400/2.6.0-test3-boot1.txt
http://encinc.com/~chuck/kt400/2.6.0-test3-config.txt
http://encinc.com/~chuck/kt400/cpuinfo.txt
http://encinc.com/~chuck/kt400/interrupts.txt
http://encinc.com/~chuck/kt400/iomem.txt
http://encinc.com/~chuck/kt400/ioports.txt
http://encinc.com/~chuck/kt400/lspci-vvv.txt

Here's a couple posts from older versions when it was panicing:
http://www.ussg.iu.edu/hypermail/linux/kernel/0304.3/1279.html
http://www.ussg.iu.edu/hypermail/linux/kernel/0306.2/0251.html

