Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932615AbVKRHnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932615AbVKRHnV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 02:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932617AbVKRHnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 02:43:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53709 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932615AbVKRHnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 02:43:20 -0500
Date: Thu, 17 Nov 2005 23:42:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc1-mm1
Message-Id: <20051117234252.087fa813.akpm@osdl.org>
In-Reply-To: <437D80BD.7030609@reub.net>
References: <20051117111807.6d4b0535.akpm@osdl.org>
	<437D80BD.7030609@reub.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly <reuben-lkml@reub.net> wrote:
>
> Hi,
> 
> On 18/11/2005 8:18 a.m., Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc1/2.6.15-rc1-mm1
> > 
> > - reiser4 significantly updated
> > 
> > 
> > 
> > 
> > Changes since 2.6.14-mm2:
> 
> This has been one of the best -mm releases in a while.  No problems compiling
> or running - and so far nearly 18 hours uptime without any surprises.

We'll have to try harder.  -mm2 is up there now, to break everything again.

> Following up on a posting from the last -mm release,  I'm still seeing errors 
> loading multiple network drivers as modules (e100 and sky2) when 
> CONFIG_PREEMPT_BKL is enabled, with 2.6.14-mm1, 2.6.14-mm2 and now
> 2.6.15-rc1-mm1.  Mainline git doesn't exhibit the problem, so it's -mm specific.
> 
> This is what is logged:
> 
> Nov 18 17:40:42 tornado kernel: e100: 0000:06:03.0: e100_eeprom_load: EEPROM
> corrupted
> Nov 18 17:40:42 tornado kernel: ACPI: PCI interrupt for device 0000:06:03.0
> disabled
> Nov 18 17:40:42 tornado kernel: e100: probe of 0000:06:03.0 failed with error -11
> Nov 18 17:40:43 tornado kernel: ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 17
> (level, low) -> IRQ 177
> Nov 18 17:40:43 tornado kernel: sky2 0000:04:00.0: unsupported chip type 0xff
> Nov 18 17:40:43 tornado kernel: ACPI: PCI interrupt for device 0000:04:00.0
> disabled
> Nov 18 17:40:43 tornado kernel: sky2: probe of 0000:04:00.0 failed with error -95
> 
> I'm certain that both of these NIC's are OK as they work fine with 
> CONFIG_PREEMPT_BKL not selected.
> 
> With CONFIG_PREEMPT_BKL disabled and an otherwise identical config, the
> driver modules load up just fine.
> 
> A known good kernel with this config was 2.6.14-rc5-mm1.
> I have backed out git-netdev-all but it made no difference, as well as backed 
> out the e100 changes in -mm on 2.6.15-mm2, again no difference.  So I suspect 
> it's not a netdev driver problem.
> 
> What else can I do to help narrow down the problem?  What other trees or patches 
> would be worth backing out to try and narrow it down?

I'd be suspecting the PCI changes firstly.  That's gregkh-pci-*. 

Conceivably git-acpi, but that hasn't changed in quite some time.  In fact,
no ACPI changes since 2.6.14-rc5-mm1.

After that I don't know, sorry.   Binary search time?
