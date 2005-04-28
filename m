Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262113AbVD1PJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbVD1PJf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 11:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbVD1PJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 11:09:34 -0400
Received: from colo.lackof.org ([198.49.126.79]:27279 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S262113AbVD1PIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 11:08:47 -0400
Date: Thu, 28 Apr 2005 09:11:17 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       grundler@parisc-linux.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, greg@kroah.com, bjorn.helgaas@hp.com,
       davem@redhat.com
Subject: Re: pci-sysfs resource mmap broken (and PATCH)
Message-ID: <20050428151117.GB10171@colo.lackof.org>
References: <1114493609.7183.55.camel@gaston> <20050426163042.GE2612@colo.lackof.org> <1114555655.7183.81.camel@gaston> <1114643616.7183.183.camel@gaston> <20050428053311.GH21784@colo.lackof.org> <20050427223702.21051afc.davem@davemloft.net> <1114670353.7182.246.camel@gaston> <20050427235056.0bd09a94.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427235056.0bd09a94.davem@davemloft.net>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 11:50:56PM -0700, David S. Miller wrote:
> > Yes, and I think that pretty much match with PCI devices exposing a
> > "prefetchable" BAR, don't you agree ?
> 
> Some scsi controllers have prefetchable set in their normal
> register BARs.  The sym53c8xx does if I remember correctly.

None of the ones I have here seem to.
Maybe someone else does?

grundler <504>lspci -vd 1000:
0000:00:01.0 SCSI storage controller: LSI Logic / Symbios Logic 53C896/897 (rev 07)
        Flags: bus master, medium devsel, latency 128, IRQ 18
        I/O ports at 0100 [size=256]
        Memory at f8020000 (64-bit, non-prefetchable) [size=1K]
        Memory at f8040000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: <available only to root>

0000:00:01.1 SCSI storage controller: LSI Logic / Symbios Logic 53C896/897 (rev 07)
        Flags: bus master, medium devsel, latency 128, IRQ 19
        I/O ports at 0200 [size=256]
        Memory at f8007000 (64-bit, non-prefetchable) [size=1K]
        Memory at f8002000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: <available only to root>

0000:00:02.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 14)
        Flags: bus master, medium devsel, latency 128, IRQ 19
        I/O ports at 0300 [size=256]
        Memory at f8008000 (32-bit, non-prefetchable) [size=256]
        Memory at f8001000 (32-bit, non-prefetchable) [size=4K]

0000:00:02.1 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 14)
        Flags: bus master, medium devsel, latency 128, IRQ 20
        I/O ports at 0400 [size=256]
        Memory at f8009000 (32-bit, non-prefetchable) [size=256]
        Memory at f8004000 (32-bit, non-prefetchable) [size=4K]

0000:20:00.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 66MHz  Ultra3 SCSI Adapter (rev 01)
        Subsystem: LSI Logic / Symbios Logic: Unknown device 1020
        Flags: bus master, 66MHz, medium devsel, latency 128, IRQ 24
        I/O ports at 20000 [size=256]
        Memory at fa044000 (64-bit, non-prefetchable) [size=1K]
        Memory at fa040000 (64-bit, non-prefetchable) [size=8K]
        Expansion ROM at fa000000 [disabled] [size=128K]
        Capabilities: <available only to root>

0000:20:00.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 66MHz  Ultra3 SCSI Adapter (rev 01)
        Subsystem: LSI Logic / Symbios Logic: Unknown device 1020
        Flags: bus master, 66MHz, medium devsel, latency 128, IRQ 25
        I/O ports at 20100 [size=256]
        Memory at fa045000 (64-bit, non-prefetchable) [size=1K]
        Memory at fa042000 (64-bit, non-prefetchable) [size=8K]
        Expansion ROM at fa020000 [disabled] [size=128K]
        Capabilities: <available only to root>

0000:30:02.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 08)
        Subsystem: Hewlett-Packard Company: Unknown device 12c5
        Flags: 66MHz, medium devsel, IRQ 27
        I/O ports at 30000 [disabled] [size=256]
        Memory at fb200000 (64-bit, non-prefetchable) [disabled] [size=128K]
        Memory at fb220000 (64-bit, non-prefetchable) [disabled] [size=128K]
        Expansion ROM at fb000000 [disabled] [size=1M]
        Capabilities: <available only to root>

0000:30:02.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 08)
        Subsystem: Hewlett-Packard Company: Unknown device 12c5
        Flags: 66MHz, medium devsel, IRQ 28
        I/O ports at 30100 [disabled] [size=256]
        Memory at fb240000 (64-bit, non-prefetchable) [disabled] [size=128K]
        Memory at fb260000 (64-bit, non-prefetchable) [disabled] [size=128K]
        Expansion ROM at fb100000 [disabled] [size=1M]
        Capabilities: <available only to root>


> Anyways, what I'm trying to say is that blinding turning prefetchable
> BAR into "don't set side effect bit in PTE" might not be so wise.
> 
> I really think it's a userlevel decision.  That's where all the ioctl()
> garbage came from for the /proc/bus/pci mmap() stuff.  It was for chossing
> IO vs MEM space, and also for setting these kinds of mapping attributes.

Well, if it's a device driver decision, I guess that's ok.
And the primary device driver happens to live in user space in X.org case.

hth,
grant
