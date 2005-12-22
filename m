Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030368AbVLVXRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030368AbVLVXRR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 18:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030370AbVLVXRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 18:17:17 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:9991 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1030368AbVLVXRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 18:17:16 -0500
Date: Fri, 23 Dec 2005 00:16:59 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Tim Warnock <timoid@getonit.net.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FW: Kernel oops v2.4.31 in e1000 network card driver.
Message-ID: <20051222231659.GN15993@alpha.home.local>
References: <C67FBCB411B4024382B11B96D68E49E407968C@server.local.GetOffice>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C67FBCB411B4024382B11B96D68E49E407968C@server.local.GetOffice>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Dec 22, 2005 at 07:10:04PM +1000, Tim Warnock wrote:
> Further information to this:
> 
> Network card causing the problem is the intel quad port gigabit ethernet
> pci card.
> I have tested also on 2.4.27, 2.4.32 and the latest 2.6 series kernel.
> 
> Under load (10-15kpps) the network driver crashes. Under increased load
> (20-30kpps) the driver will actually cause a full kernel panic and
> reboot the box.

What type of system is it ? P3/P4/K7/K8 ? UP/SMP ? do you have a PCI-X
bus in it ? have you checked /proc/interrupts for strange behaviours ?

> After replacing the card with a single port intel gigabit ethernet pci
> card, the system has been rock stable.
> 
> According to intel, the quad port nic is based around the "Intel(r)
> 82546EB" controller, the single port nic is based around the "Intel(r)
> 82545" controller.
> 
> Are there any other known problems with Intel(r) 82546EB controller
> support with the current e1000 driver?

Not to my knowledge. I have several of them running on moderate volume
(50 Mbps) on production up to 50-60 kpps, and they have never ever caused
any trouble after 2.5 years. I even use others in stress-testing machines
which throw up to 500 kpps per port without any problem either. BTW, the
ones in the stress-testers are more recent, they are the ones with the
"toundra" PCI bridge.

Do you encounter the problem in only one system ? I begin to suspect a
hardware failure somewhere (CPU, RAM) which is triggered by higher loads.

> I'm not on the list so can I please be CC'd?
> 
> Original email attached below: 
> 
> Thanks
> Tim Warnock
> 
> ISP Technical Manager
> GetOnIt! Nationwide Internet.
> 1300 88 00 97
> timoid (at) getonit.net.au

Regards,
Willy

> ------------- original message ------------------
> From: Tim Warnock 
> Sent: Wednesday, 23 November 2005 10:48 PM
> To: 'linux-kernel@vger.kernel.org'
> Subject: Kernel oops v2.4.31 in e1000 network card driver.
> 
> Any assistance to what this means?
> 
> Nov 23 21:09:40 garnet kernel: NETDEV WATCHDOG: eth2: transmit timed out
> Nov 23 21:09:40 garnet kernel: Unable to handle kernel paging request at
> virtual address 0003066e
> Nov 23 21:09:40 garnet kernel:  printing eip:
> Nov 23 21:09:40 garnet kernel: c025feb2
> Nov 23 21:09:40 garnet kernel: *pde = 00000000
> Nov 23 21:09:40 garnet kernel: Oops: 0000
> Nov 23 21:09:40 garnet kernel: CPU:    0
> Nov 23 21:09:40 garnet kernel: EIP:    0010:[skb_drop_fraglist+34/80]
> Not tainted
> Nov 23 21:09:40 garnet kernel: EFLAGS: 00010206
> Nov 23 21:09:40 garnet kernel: eax: 00030600   ebx: 000305fa   ecx:
> e905a880   edx: 000305fa
> Nov 23 21:09:40 garnet kernel: esi: dd6b4680   edi: dd6b46e0   ebp:
> 00000bb8   esp: f7edfefc
> Nov 23 21:09:40 garnet kernel: ds: 0018   es: 0018   ss: 0018
> Nov 23 21:09:40 garnet kernel: Process keventd (pid: 2,
> stackpage=f7edf000)
> Nov 23 21:09:40 garnet kernel: Stack: c1c15900 f8a76bb8 c025ff79
> dd6b4680 f8a76bb8 dd6b4680 c025ffc7 dd6b4680
> Nov 23 21:09:40 garnet kernel:        d8515180 f8a76bb8 f7e4ca88
> c026012e dd6b4680 c01e3cd8 f8a76000 c01e3e22
> Nov 23 21:09:40 garnet kernel:        dd6b4680 00000096 f7e4c980
> f7e4c980 f7e4c800 f7ede000 c01e2eac f7e4c980
> Nov 23 21:09:40 garnet kernel: Call Trace:    [skb_release_data+105/160]
> [kfree_skbmem+23/128] [__kfree_skb+254/352]
> [e1000_clean_tx_ring+472/592] [e1000_clean_rx_ring+82/30
> 4]
> Nov 23 21:09:40 garnet kernel:   [e1000_down+204/304]
> [e1000_tx_timeout_task+22/48] [__run_task_queue+106/128]
> [context_thread+478/496] [context_thread+0/496] [_stext+0/96]
> Nov 23 21:09:40 garnet kernel:   [arch_kernel_thread+46/64]
> [context_thread+0/496]
> Nov 23 21:09:40 garnet kernel:
> Nov 23 21:09:40 garnet kernel: Code: 8b 42 74 8b 1b 48 75 15 f0 83 44 24
> 00 00 89 14 24 e8 68 01
> 
> Kernel vanilla v2.4.31 debian stable.
> Network cards are intel e1000's
> 
> Im not on the list so can I please be CC'd
> 
> Thanks
> Tim Warnock
> 
> ISP Technical Manager
> GetOnIt! Nationwide Internet.
> 1300 88 00 97
> timoid (at) getonit.net.au
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
