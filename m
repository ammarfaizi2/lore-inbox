Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWABQWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWABQWT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 11:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWABQWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 11:22:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:31198 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750801AbWABQWS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 11:22:18 -0500
To: =?iso-8859-1?q?Dieter_St=FCken?= <stueken@conterra.de>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: X86_64 + VIA + 4g problems
References: <43B90A04.2090403@conterra.de>
From: Andi Kleen <ak@suse.de>
Date: 02 Jan 2006 17:22:12 +0100
In-Reply-To: <43B90A04.2090403@conterra.de>
Message-ID: <p73k6difvm3.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter Stüken <stueken@conterra.de> writes:

> just gave 2.6.15-rc7 a try, but still fail when plugging 4g into the board :-(
> Its an Asus sk8v (VIA chipset), thus I get:

Can you please post the full boot log? 

> ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 19
> ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 19
> eth0: 3Com Gigabit LOM (3C940)
>        PrefPort:A  RlmtMode:Check Link State
> 
> don't know, if it's related to that, but with 2G it runs stable since about a year.
> 
> The problem arises as soon as my network (3C940) gets enabled, the following
> message is continuously repeated and nothing else works any more, not even
> console switching.

When you not compile in the SKGE network driver does everything else work?
skge supports 64bit DMA, so it shouldn't use any IOMMU.  But I'm somewhat
suspicious of the >4GB support in the VIA chipset. We had problems with
that before. It's possible that it's just not supported in the hardware
or that the BIOS sets up the MTRRs wrong.

-Andi
