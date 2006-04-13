Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbWDMKIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWDMKIs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 06:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWDMKIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 06:08:48 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41611 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964866AbWDMKIr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 06:08:47 -0400
Subject: Re: Reduce IRQ latency or revise hardware?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Burkhard =?ISO-8859-1?Q?Sch=F6lpen?= <bschoelpen@web.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <615249858@web.de>
References: <615249858@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Thu, 13 Apr 2006 11:17:56 +0100
Message-Id: <1144923476.9989.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-04-13 at 08:42 +0200, Burkhard Schölpen wrote:
> 1. Is it somehow possible to fulfill the realtime requirements of the
> hardware by e.g. a realtime kernel patch or some kernel configuration
> fine tuning (at the moment I need a maximum hardware latency of about
> 100 microseconds)?

I don't believe you can 100% reliably achieve 100uS on an x86 board just
because of the possible SMM, cache and tlb miss worse cases combined
with the IRQ latency of the hardware. If you have other PCI devices on
the bus then you will have real fun getting hear it.

Hand tuning all the configuration and using rtlinux as the bottom layer
might just about do it if you avoided other PCI devices that can be slow
to respond (eg ATA disk and many video cards). You'll also need a board
with no SMM mode code in use so probably ACPI disabled, and possibly
have to pick the board to suit the needs.

It may also be far easier to hit such deadlines if the chip is wired
fairly directly to one of the embedded processors so you don't have
busses in the way and you have a fast IRQ response.

> Again I would like to underline that the main task is to get the
> interrupt handler invoked early enough, so I can get data out of a
> hardware FIFO. If this FIFO produces overflows, I get into big
> trouble, because the following data stream will be corrupted and the
> hardware must be reset. The programmer of the FPGA says that the
> buffer size is already at the maximum.

The other highly latency sensitive stuff like that I've seen appears to
all bus master and have a FIFO to front that which just handles PCI
delays. That way an IRQ just means one of the bus master buffers is
full.

Alan

