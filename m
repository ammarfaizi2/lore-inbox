Return-Path: <linux-kernel-owner+w=401wt.eu-S1752531AbWLXTPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbWLXTPX (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 14:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752532AbWLXTPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 14:15:23 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:21706 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531AbWLXTPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 14:15:22 -0500
Date: Sun, 24 Dec 2006 11:16:22 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH] Update Documentation/pci.txt v7
Message-Id: <20061224111622.e22bfd8a.randy.dunlap@oracle.com>
In-Reply-To: <20061224060726.GC24131@colo.lackof.org>
References: <456404E2.1060102@jp.fujitsu.com>
	<20061122182804.GE378@colo.lackof.org>
	<45663EE8.1080708@jp.fujitsu.com>
	<20061124051217.GB8202@colo.lackof.org>
	<20061206072651.GG17199@kroah.com>
	<20061210072508.GA12272@colo.lackof.org>
	<20061215170207.GB15058@kroah.com>
	<20061218071133.GA1738@colo.lackof.org>
	<20061224060726.GC24131@colo.lackof.org>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Dec 2006 23:07:26 -0700 Grant Grundler wrote:

> +10. Legacy I/O port free driver
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

That subject (and patches with similar subject) confuses me.
It's difficult to associate the adjectives correctly.
I suppose it just needs some hyphens/dashes, like:

10. Legacy-I/O-port-free driver

but that's ETOOMUCH.  Maybe ?

10.  Stop using legacy I/O space

> +Large servers may not be able to provide I/O port resources to all PCI
> +devices. I/O Port space is only 64KB on Intel Architecture[1] and is
> +likely also fragmented since the I/O base register of PCI-to-PCI
> +bridge will usually be aligned to a 4KB boundary[2]. On such systems,
> +pci_enable_device() and pci_request_region() will fail when
> +attempting to enable I/O Port regions that don't have I/O Port
> +resources assigned.

> +11. MMIO Space and "Write Posting"
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Converting a driver from using I/O Port space to using MMIO space
> +often requires some additional changes. Specifically, "write posting"
> +needs to be handled. Many drivers (e.g. tg3, acenic, sym53c8xx_2)
> +already do this. I/O Port space guarantees write transactions reach the PCI
> +device before the CPU can continue. Writes to MMIO space allow the CPU
> +to continue before the transaction reaches the PCI device. HW weenies
> +call this "Write Posting" because the write completion is "posted" to
> +the CPU before the transaction has reached its destination.
> +
> +Thus, timing sensitive code should add readl() where the CPU is
> +expected to wait before doing other work.  The classic "bit banging"
> +sequence works fine for I/O Port space:
> +
> +       for (i=8; --i; val >>= 1) {

Please use:	i = 8;
to match CodingStyle.  (and below)

> +               outb(val & 1, ioport_reg);      /* write bit */
> +               udelay(10);
> +       }
> +
> +The same sequence for MMIO space should be:
> +
> +       for (i=8; --i; val >>= 1) {
> +               writeb(val & 1, mmio_reg);      /* write bit */
> +               readb(safe_mmio_reg);           /* flush posted write */
> +               udelay(10);
> +       }

Rest looks good to me.

---
~Randy
