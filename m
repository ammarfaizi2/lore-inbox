Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263577AbUCUAWL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 19:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263578AbUCUAWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 19:22:10 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:9159 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S263577AbUCUAWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 19:22:09 -0500
Date: Sat, 20 Mar 2004 19:22:13 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Jaroslav Kysela <perex@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
In-Reply-To: <20040320235445.B24744@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0403201920560.28447@montezuma.fsmlabs.com>
References: <20040320133025.GH9009@dualathlon.random> <20040320144022.GC2045@holomorphy.com>
 <20040320150621.GO9009@dualathlon.random> <20040320154419.A6726@flint.arm.linux.org.uk>
 <Pine.LNX.4.58.0403201651520.1816@pnote.perex-int.cz>
 <20040320160911.B6726@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403202038530.1816@pnote.perex-int.cz>
 <20040320222341.J6726@flint.arm.linux.org.uk> <20040320224518.GQ2045@holomorphy.com>
 <20040320235445.B24744@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Mar 2004, Russell King wrote:

> The issues are:
>
> 1. ALSA wants to mmap the buffer used to transfer data to/from the
>    card into user space.  This buffer may be direct-mapped RAM,
>    memory allocated via dma_alloc_coherent(), an on-device buffer,
>    or anything else.
>
>    The user space mapping must likewise be DMA-coherent.
>
>    Currently, ALSA just does virt_to_page() on whatever address it
>    feels like in its nopage() function, which is obviously not
>    acceptable for two out of the three specific cases above.
>
> 2. ALSA wants to _coherently_ share data between the kernel-side
>    drivers, and user space ALSA library, mainly the DMA buffer
>    head/tail pointers so both kernel space and user space knows
>    when the buffer is full/empty.

Doesn't DRI also suffer from the same issues?
