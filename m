Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264219AbTIIQaX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 12:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264220AbTIIQaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 12:30:23 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32778 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264219AbTIIQaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 12:30:19 -0400
Date: Tue, 9 Sep 2003 17:30:14 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Fedor Karpelevitch <fedor@karpelevitch.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test5]oops inserting PCMCIA card
Message-ID: <20030909173014.E4216@flint.arm.linux.org.uk>
Mail-Followup-To: Fedor Karpelevitch <fedor@karpelevitch.net>,
	linux-kernel@vger.kernel.org
References: <200309081630.19263.fedor@karpelevitch.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200309081630.19263.fedor@karpelevitch.net>; from fedor@karpelevitch.net on Mon, Sep 08, 2003 at 04:30:19PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 04:30:19PM -0700, Fedor Karpelevitch wrote:
> Unable to handle kernel paging request at virtual address d08721c0
>  printing eip:
> c020b80a
> *pde = 013ae067
> *pte = 00000000
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[pci_match_device+10/160]    Not tainted
> EFLAGS: 00010286
> EIP is at pci_match_device+0xa/0xa0
> eax: d08721c0   ebx: cdbf9334   ecx: 00000002   edx: d08721c0
> esi: d08afe88   edi: cdbf9334   ebp: cdef3e14   esp: cdef3e10
> ds: 007b   es: 007b   ss: 0068
> Process pccardd (pid: 765, threadinfo=cdef2000 task=cdd7db40)
> Stack: d08afe60 cdef3e54 c020c14a d08721c0 cdbf9334 0000006b 000005ed 00000088 
>        c0202fdf c3cd8d54 d0827b80 00000282 0000002e 0248a870 d08afe88 cdbf9388 
>        ffffffed cdef3e70 c025a95a cdbf9388 d08afe88 d08afed4 cdbf9388 c037e7f8 
> Call Trace:
>  [pci_bus_match+42/816] pci_bus_match+0x2a/0x330
>  [kset_hotplug+751/960] kset_hotplug+0x2ef/0x3c0
>  [bus_match+42/112] bus_match+0x2a/0x70
>  [device_attach+82/176] device_attach+0x52/0xb0
>  [bus_add_device+117/192] bus_add_device+0x75/0xc0
>  [device_add+209/272] device_add+0xd1/0x110
>  [pci_bus_add_devices+583/976] pci_bus_add_devices+0x247/0x3d0
>  [__crc___wait_on_buffer+2481555/2542871] cardbus_assign_irqs+0xc1/0xd0 [pcmcia_core]
>  [__crc___wait_on_buffer+2481762/2542871] cb_alloc+0xc0/0x100 [pcmcia_core]
>  [__crc___wait_on_buffer+2467213/2542871] socket_setup+0x11b/0x170 [pcmcia_core]
>  [__crc___wait_on_buffer+2467471/2542871] socket_insert+0xad/0x150 [pcmcia_core]
>  [__crc___wait_on_buffer+2468209/2542871] socket_detect_change+0x4f/0x80 [pcmcia_core]
>  [__crc___wait_on_buffer+2468851/2542871] pccardd+0x251/0x320 [pcmcia_core]
>  [default_wake_function+0/48] default_wake_function+0x0/0x30
>  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
>  [default_wake_function+0/48] default_wake_function+0x0/0x30
>  [__crc___wait_on_buffer+2468258/2542871] pccardd+0x0/0x320 [pcmcia_core]
>  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
> 
> Code: 8b 0a 85 c9 74 74 83 f9 ff 74 2e 0f b7 43 24 39 c1 74 26 31 

This isn't a PCMCIA nor CardBus problem.

If its in pci_bus_match, I'll place my bets on a PCI driver whose
pci_driver structure is marked __initdata, or whose pci_device_id table
is marked __initdata.

Which modules do you have loaded?

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
