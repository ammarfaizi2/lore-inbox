Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263104AbTCWQT5>; Sun, 23 Mar 2003 11:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263105AbTCWQT5>; Sun, 23 Mar 2003 11:19:57 -0500
Received: from sccrmhc03.attbi.com ([204.127.202.63]:36838 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S263104AbTCWQT4>; Sun, 23 Mar 2003 11:19:56 -0500
Message-ID: <3E7DE12C.2020301@quark.didntduck.org>
Date: Sun, 23 Mar 2003 11:30:36 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Molina <tmolina@cox.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sleeping function call in 2.5.65-bk
References: <Pine.LNX.4.44.0303230958450.891-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0303230958450.891-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Molina wrote:
> I did a bk pull about 0500 CST this morning.  Five minutes after booting 
> into this version of the kernel I get an endless string of the following 
> until reboot.  The type of activity going on at the time doesn't seem to 
> affect whether I get it or not.  I've tried everything from completely 
> idle user-wise to compeletely loaded (load average >= 2) with both 
> interactive and background tasks active.
> 
> Mar 23 09:53:45 dad kernel: Debug: sleeping function called from illegal 
> context at mm/slab.c:1723
> Mar 23 09:53:45 dad kernel: Call Trace:
> Mar 23 09:53:45 dad kernel:  [<c011d7bf>] __might_sleep+0x4f/0x90
> Mar 23 09:53:45 dad kernel:  [<c0149611>] kmalloc+0x1a1/0x1c0
> Mar 23 09:53:45 dad kernel:  [<c0233985>] accel_cursor+0xd5/0x300
> Mar 23 09:53:45 dad kernel:  [<c02158b6>] e100_get_link_state+0x36/0xa0
> Mar 23 09:53:45 dad kernel:  [<c0233da5>] fb_vbl_handler+0x85/0xa0
> Mar 23 09:53:45 dad kernel:  [<c012a9d6>] update_process_times+0x46/0x50
> Mar 23 09:53:45 dad kernel:  [<c0232400>] cursor_timer_handler+0x0/0x40
> Mar 23 09:53:45 dad kernel:  [<c0232421>] cursor_timer_handler+0x21/0x40
> Mar 23 09:53:45 dad kernel:  [<c012ab32>] run_timer_softirq+0x132/0x3c0
> Mar 23 09:53:45 dad kernel:  [<c022c390>] ide_dma_intr+0x0/0xc0
> Mar 23 09:53:45 dad kernel:  [<c0125de1>] do_softirq+0xa1/0xb0
> Mar 23 09:53:45 dad kernel:  [<c010bdec>] do_IRQ+0x1fc/0x320
> Mar 23 09:53:45 dad kernel:  [<c0116c01>] apm_bios_call_simple+0x61/0xa0
> Mar 23 09:53:45 dad kernel:  [<c0109fdc>] common_interrupt+0x18/0x20
> Mar 23 09:53:45 dad kernel:  [<c0106fe7>] default_idle+0x27/0x30
> Mar 23 09:53:45 dad kernel:  [<c0116ef2>] apm_cpu_idle+0xc2/0x150
> Mar 23 09:53:45 dad kernel:  [<c0116e30>] apm_cpu_idle+0x0/0x150
> Mar 23 09:53:45 dad kernel:  [<c0106fc0>] default_idle+0x0/0x30
> Mar 23 09:53:45 dad kernel:  [<c0107061>] cpu_idle+0x31/0x40
> Mar 23 09:53:45 dad kernel:  [<c0105000>] rest_init+0x0/0x30
> Mar 23 09:53:45 dad kernel:

The fbcon driver is calling kmalloc in interrupt context without GFP_ATOMIC.

--
				Brian Gerst

