Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbTEEWzr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 18:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbTEEWzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 18:55:47 -0400
Received: from [217.157.19.70] ([217.157.19.70]:29969 "EHLO jehova.dsm.dk")
	by vger.kernel.org with ESMTP id S261789AbTEEWzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 18:55:46 -0400
Date: Tue, 6 May 2003 01:08:07 +0200 (CEST)
From: Thomas Horsten <thomas@horsten.com>
X-X-Sender: thomas@jehova.dsm.dk
To: Halil Demirezen <nitrium@bilmuh.ege.edu.tr>
cc: linux-kernel@vger.kernel.org
Subject: Re: about bios
In-Reply-To: <20030505230425.GA17060@bilmuh.ege.edu.tr>
Message-ID: <Pine.LNX.4.40.0305060101350.7106-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 May 2003, Halil Demirezen wrote:

> So can we say that, during initialization, setup.s pushes some bios info
> to the memory, and then after entering protected mode in i386, it pops
> these information and sets kernel depending on it. Because of absence of
> FDC controller info at this data area linux does not recognize FDC. However,

No it doesn't push or pop any info from the BIOS. The FDC is simply turned
off in the chipset initialisation code (in BIOS), in a proprietary way
that Linux doesn't know about.

> I can turn it on still usin IO ports and using in, out assembly
> instructions.

No. You need to change a chipset register to power it back on. And how to
do this depends on the chipset. On an old ISA floppy controller, this
would not be possible in software but would have to be done by a jumper,
but modern chipsets are configurable through registers. Unfortunately all
the different chipsets have different initialisation code for this, and
some are even not documented at all.

This is why, even though Linux does not use the BIOS at any point after
booting, some chipset setup code is still required and therefore you can't
just burn a Linux kernel into flash and start it directly (there is a
project called LinuxBIOS that was working on a replacement BIOS for some
common chipsets, intended for embedded systems).

Regards,
Thomas

