Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751429AbWI3WNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbWI3WNK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 18:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWI3WNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 18:13:10 -0400
Received: from ns1.suse.de ([195.135.220.2]:39326 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751429AbWI3WNG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 18:13:06 -0400
From: Andi Kleen <ak@suse.de>
To: Luca Tettamanti <kronos.it@gmail.com>
Subject: Re: [2.6.18-git] Lost all PCI devices
Date: Sun, 1 Oct 2006 00:13:01 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060930174247.GA31793@dreamland.darkstar.lan> <200609302234.24778.ak@suse.de> <20060930220600.GA19990@dreamland.darkstar.lan>
In-Reply-To: <20060930220600.GA19990@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610010013.01390.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> "pci_direct_probe conf*" printk are placed before calling into
> pci_check_type{1,2}, it doesn't call pci_sanity_check so it's the I/O
> check that fails.
> I can do further debugging if you're interested.

No I was just curious. It's strange that your system doesn't work without 
PCI BIOS though. Is it an older laptop? The assumption so far
was that everything modern can do type 1 without problems (except 
one broken Apple system). Apparently that's not universally true.

> ACPI: Access to PCI configuration space unavailable
> ACPI: Interpreter enabled
> ACPI: Using PIC for interrupt routing
> ------------[ cut here ]------------
> Kernel BUG at [verbose debug info unavailable]
> invalid opcode: 0000 [#1]
> PREEMPT
> CPU:    0
> EIP:    0060:[<c0233103>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.18-g5ffd1a6a-dirty #20)
> EIP is at acpi_os_read_pci_configuration+0x4f/0x87

The patch I posted should have fixed that.

Although I think it might be better to do panic() instead of printk.

-Andi
