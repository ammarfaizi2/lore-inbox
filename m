Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261522AbSJZVLo>; Sat, 26 Oct 2002 17:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261523AbSJZVLo>; Sat, 26 Oct 2002 17:11:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11014 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261522AbSJZVLo>;
	Sat, 26 Oct 2002 17:11:44 -0400
Message-ID: <3DBB0675.7000304@pobox.com>
Date: Sat, 26 Oct 2002 17:17:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
CC: linux.nics@intel.com, linux-kernel@vger.kernel.org,
       scott.feldman@intel.com
Subject: Re: e100 doing bad things in 2.5.44.
References: <20021025185316.GA10278@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>Oct 25 18:38:12 tetrachloride kernel: Debug: sleeping function called from illegal context at mm/slab.c:1384
>Oct 25 18:38:12 tetrachloride kernel: Call Trace:
>Oct 25 18:38:12 tetrachloride kernel:  [<c011dd94>] __might_sleep+0x54/0x58
>Oct 25 18:38:12 tetrachloride kernel:  [<c01403ae>] kmalloc+0x5a/0x314
>Oct 25 18:38:12 tetrachloride kernel:  [<c017e2da>] proc_create+0x76/0xcc
>Oct 25 18:38:12 tetrachloride kernel:  [<c017e3fb>] proc_mkdir+0x17/0x40
>Oct 25 18:38:12 tetrachloride kernel:  [<c010a4c3>] register_irq_proc+0x6b/0xb0
>Oct 25 18:38:12 tetrachloride kernel:  [<c010a2ba>] setup_irq+0x166/0x174
>Oct 25 18:38:12 tetrachloride kernel:  [<c02b9424>] e100intr+0x0/0x308
>Oct 25 18:38:12 tetrachloride kernel:  [<c0109b48>] request_irq+0x88/0xa4
>Oct 25 18:38:12 tetrachloride kernel:  [<c02b84fa>] e100_open+0x106/0x188
>  
>
Well, it holds bdp->isolate_lock for an incredibly long time, so that 
might trigger this.  At least interrupts aren't disabled.

Another bug:  e100_close doesn't get the lock.


>Another weirdo.. Check out the Speed..
>
>Oct 25 18:38:12 tetrachloride kernel: Intel(R) PRO/100 Network Driver - version 2.1.24-k1
>Oct 25 18:38:12 tetrachloride kernel: Copyright (c) 2002 Intel Corporation
>Oct 25 18:38:12 tetrachloride kernel: 
>Oct 25 18:38:12 tetrachloride kernel: e100: selftest OK.
>Oct 25 18:38:12 tetrachloride kernel: e100: eth0: Intel(R) PRO/100 VE Network Connection
>Oct 25 18:38:12 tetrachloride kernel:   Mem:0xfeafc000  IRQ:20  Speed:0 Mbps  Dx:N/A
>Oct 25 18:38:12 tetrachloride kernel:   Hardware receive checksums enabled
>

Cosmetic or real, that's indeed another bug...

    Jeff




