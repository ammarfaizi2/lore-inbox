Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266249AbUBLD7V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 22:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266252AbUBLD7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 22:59:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3300 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266249AbUBLD7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 22:59:19 -0500
Date: Wed, 11 Feb 2004 19:58:12 -0800
From: "David S. Miller" <davem@redhat.com>
To: dsaxena@plexity.net
Cc: mporter@kernel.crashing.org, lists@mdiehl.de, linux-kernel@vger.kernel.org
Subject: Re: [Patch] dma_sync_to_device
Message-Id: <20040211195812.4db8cede.davem@redhat.com>
In-Reply-To: <20040212034610.GA27317@plexity.net>
References: <20040211061753.GA22167@plexity.net>
	<Pine.LNX.4.44.0402110729510.2349-100000@notebook.home.mdiehl.de>
	<20040211111800.A5618@home.com>
	<20040211103056.69e4660e.davem@redhat.com>
	<20040211185725.GA25179@plexity.net>
	<20040211110853.492f479b.davem@redhat.com>
	<20040212034610.GA27317@plexity.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Feb 2004 20:46:11 -0700
Deepak Saxena <dsaxena@plexity.net> wrote:

> /me groks now. I am assuming this is a 2.7 thing as it is
> reinterpreting/redefining the API.

No, it is adding an operation that previously was impossible to
make occur.

> In ARM, pci_dma_sync_single() does
> a cache flush, which is why I was confused asked about two cache flushes.
> What you are proposing is that by definition pci_dma_sync_* syncs 
> bridges caches with system memory, while pci_dma_sync_device_* syncs 
> the CPU's cache with system memory.
> 
> This will definetely confuse a lot of driver writers. 

What I am proposing, is to keep pci_dma_sync_*() with it's current definition
which is to transfer control of the buffer from DEVICE to CPU.  It has always
been defined this way.

I am also adding a new operation, pci_dma_sync_device_*() which transfers control
of the buffer from CPU back to DEVICE.  This operation was not possible previously.

Therefore we will merge this into both 2.6.x and 2.4.x as soon as a suitable full
and reviewed patch exists.

If you flush the cache on ARM for pci_dma_sync_*(), so what?  If the cpu writes to
the buffer then asks the device to DMA from the area it's going to see garbage.

To be honest there aren't many pci_dma_sync_*() users, and thus it is relatively
easy to audit them all for problems in this area.  Yes, updates and clarifications
in the docs will be necessary as well.
