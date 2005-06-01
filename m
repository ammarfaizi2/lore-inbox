Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVFAFn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVFAFn6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 01:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbVFAFnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 01:43:47 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:5075 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261249AbVFAFne (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 01:43:34 -0400
Date: Wed, 1 Jun 2005 07:44:26 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] AHCI PCI MSI support, update 1
Message-ID: <20050601054422.GA1441@suse.de>
References: <429C8978.4060601@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429C8978.4060601@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31 2005, Jeff Garzik wrote:
> 
> I just updated the AHCI PCI MSI support patch to support the latest 
> ->host_stop() semantics changes that just made it into upstream.
> 
> This patch, until its merged, may always be found in the 'ahci-msi' 
> branch of
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

Tested on an ich6 based system, with this ahci controller:

centera:~ # lspci -s 0000:00:1f.2 -v
0000:00:1f.2 IDE interface: Intel Corp. I/O Controller Hub SATA cc=raid
(rev 03) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: Tyan Computer: Unknown device 5150
        Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 169
        I/O ports at e900
        I/O ports at ea00 [size=4]
        I/O ports at eb00 [size=8]
        I/O ports at ec00 [size=4]
        I/O ports at ed00 [size=16]
        Memory at d03c3000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [70] Power Management version 2

And system boots and works fine, MSI isn't enabled of course.

Also tested on an ich7 based system (945G express chipset), with this
ahci controller:

nelson:~ # lspci -s 0000:00:1f.2 -v
0000:00:1f.2 Class 0106: Intel Corporation I/O Controller Hub SATA
cc=AHCI (rev 01) (prog-if 01)
        Subsystem: Intel Corporation: Unknown device e302
        Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 201
        I/O ports at 40d8 [size=8]
        I/O ports at 40f4 [size=4]
        I/O ports at 40d0 [size=8]
        I/O ports at 40f0 [size=4]
        I/O ports at 4020 [size=32]
        Memory at 48304000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
        Capabilities: [70] Power Management version 2
        Capabilities: [a8] #12 [0010]

System boots and works fine (typing this message here), MSI is enabled.
I double checked with an added printk :-)

So that's at least one ACK for you. Now running NCQ and MSI enabled
ahci, I'm not sure SATA gets any better!

-- 
Jens Axboe

