Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030327AbVKRHUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030327AbVKRHUk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 02:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030363AbVKRHUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 02:20:40 -0500
Received: from tornado.reub.net ([202.89.145.182]:62668 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1030327AbVKRHUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 02:20:39 -0500
Message-ID: <437D80BD.7030609@reub.net>
Date: Fri, 18 Nov 2005 20:20:29 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20051117)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc1-mm1
References: <20051117111807.6d4b0535.akpm@osdl.org>
In-Reply-To: <20051117111807.6d4b0535.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18/11/2005 8:18 a.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc1/2.6.15-rc1-mm1
> 
> - reiser4 significantly updated
> 
> 
> 
> 
> Changes since 2.6.14-mm2:

This has been one of the best -mm releases in a while.  No problems compiling
or running - and so far nearly 18 hours uptime without any surprises.

Following up on a posting from the last -mm release,  I'm still seeing errors 
loading multiple network drivers as modules (e100 and sky2) when 
CONFIG_PREEMPT_BKL is enabled, with 2.6.14-mm1, 2.6.14-mm2 and now
2.6.15-rc1-mm1.  Mainline git doesn't exhibit the problem, so it's -mm specific.

This is what is logged:

Nov 18 17:40:42 tornado kernel: e100: 0000:06:03.0: e100_eeprom_load: EEPROM
corrupted
Nov 18 17:40:42 tornado kernel: ACPI: PCI interrupt for device 0000:06:03.0
disabled
Nov 18 17:40:42 tornado kernel: e100: probe of 0000:06:03.0 failed with error -11
Nov 18 17:40:43 tornado kernel: ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 17
(level, low) -> IRQ 177
Nov 18 17:40:43 tornado kernel: sky2 0000:04:00.0: unsupported chip type 0xff
Nov 18 17:40:43 tornado kernel: ACPI: PCI interrupt for device 0000:04:00.0
disabled
Nov 18 17:40:43 tornado kernel: sky2: probe of 0000:04:00.0 failed with error -95

I'm certain that both of these NIC's are OK as they work fine with 
CONFIG_PREEMPT_BKL not selected.

With CONFIG_PREEMPT_BKL disabled and an otherwise identical config, the
driver modules load up just fine.

A known good kernel with this config was 2.6.14-rc5-mm1.
I have backed out git-netdev-all but it made no difference, as well as backed 
out the e100 changes in -mm on 2.6.15-mm2, again no difference.  So I suspect 
it's not a netdev driver problem.

What else can I do to help narrow down the problem?  What other trees or patches 
would be worth backing out to try and narrow it down?

.config and system details are up on http://www.reub.net/kernel/

Reuben

