Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbWARLKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWARLKL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 06:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbWARLKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 06:10:11 -0500
Received: from tornado.reub.net ([202.89.145.182]:31688 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1030217AbWARLKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 06:10:10 -0500
Message-ID: <43CE2210.60509@reub.net>
Date: Thu, 19 Jan 2006 00:10:08 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20060117)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>
Subject: Re: 2.6.16-rc1-mm1
References: <20060118005053.118f1abc.akpm@osdl.org>
In-Reply-To: <20060118005053.118f1abc.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/01/2006 9:50 p.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm1/
> 
> - There are a lot of reiser3 features and fixes here.  Please test with
>   caution, but please test.
> 
> - Due to various vendor and glibc release timings I'm aiming to get the *at
>   functions (vfa-at-functions-core.patch) and the pselect/ppoll syscalls into
>   2.6.16.  This is rather late in the piece and I'd ask interested parties to
>   review and comment on those patches asap please.
> 
>   Ulrich would also like to get the unshare syscall into 2.6.16 but I don't
>   recall having seen that code get a decent review and there's quite some
>   potential for slipups in this area to cause very bad problems indeed.  So
>   we're a bit stuck on that one.
> 
> - Before I die I'd like to get an x86 allmodconfig build with gcc-3.2.1
>   which emits no warnings.  Once we have that we can worry about gcc-4 and
>   other architectures.  Patches will be gratefully leapt upon.

My box came up first time lucky on this release, but I got a new oops:

NET: Registered protocol family 1
NET: Registered protocol family 17
BUG: swapper/1, active lock [b19e6428(b19e6400-b19e6600)] freed!
  [<b01040d1>] show_trace+0xd/0xf
  [<b0104172>] dump_stack+0x17/0x19
  [<b0131c6d>] mutex_debug_check_no_locks_freed+0xff/0x18e
  [<b01544b3>] kfree+0x34/0x6a
  [<b02a6109>] cpufreq_add_dev+0x127/0x379
  [<b023abcb>] sysdev_driver_register+0x70/0xb0
  [<b02a67df>] cpufreq_register_driver+0x68/0xfe
  [<b03cc19d>] acpi_cpufreq_init+0xd/0xf
  [<b01003cc>] init+0xff/0x325
  [<b0100d25>] kernel_thread_helper+0x5/0xb
  [b19e6428] {cpufreq_add_dev}
.. held by:           swapper:    1 [efe14ab0, 115]
... acquired at:               cpufreq_add_dev+0x9d/0x379
p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
Starting balanced_irq

The box carried on and booted up normally after that and seems otherwise OK.

I'm yet to test this release out more throughly for some other problems I have 
seen recently as they require multiple reboots etc etc, but this one was more 
obvious  :)

reuben
