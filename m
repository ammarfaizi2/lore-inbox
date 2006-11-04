Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWKDBIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWKDBIG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 20:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWKDBIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 20:08:05 -0500
Received: from cacti2.profiwh.com ([85.93.165.64]:6586 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S932290AbWKDBIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 20:08:02 -0500
Message-ID: <454BE807.5040909@gmail.com>
Date: Sat, 04 Nov 2006 02:08:00 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
Newsgroups: comp.os.linux.networking
To: Gaurav <gorby13@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Subject: Re: Kernel oops in rt_check_expire()
References: <1162547263.435596.80820@h54g2000cwb.googlegroups.com>
In-Reply-To: <1162547263.435596.80820@h54g2000cwb.googlegroups.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gaurav wrote:
> Hi All,
> 
> I am seeing a crash in rt_check_expire. Below is the Oops info.
> 
> Does any one has an idea about the cause of this?
> 
> Thanks in advance.
> 
> Regards,
> Gaurav
> -------------------------------------------------------------------------------------------------------
> 
> CPU 0 Unable to handle kernel paging request at virtual address
> 01010020, epc == 8028c28c,
> ra == 802
> 
> Oops in arch/mips/mm/fault.c::do_page_fault, line 171[#1]:
> Cpu 0
> $ 0   : 00000000 1000fc01 00000010 00000001
> $ 4   : 000001ff 80378000 80430000 80539640
> $ 8   : 00000000 00000000 80420000 00000000
> $12   : 80b2b7e0 00000003 00000009 00000003
> $16   : 01010000 0000ea60 80378000 005808d1
> $20   : 00000020 00000040 00000000 00415e60
> $24   : 00000000 c006a24c
> $28   : 8046c000 8046de98 00000100 8028c30c
> Hi    : 00000000
> Lo    : 00000000
> epc   : 8028c2f0 rt_check_expire+0xfc/0x234     Tainted: PF
> ra    : 8028c30c rt_check_expire+0x118/0x234
> Status: 1000fc03    KERNEL EXL IE
> Cause : 10800008
> BadVA : 01010020
> PrId  : 0001800a
> Modules linked in: ctlmtel ctlmatm ctlmeth ctlmdsl ctlmapi ctlm_sf
> ctlmspi
> Process ksoftirqd/0 (pid: 2, threadinfo=8046c000, task=804647c0)
> Stack : 8041cc90 80420000 00000000 c006a24c 00000020 00000000 00000000
> 8028c1f4
>         8046def0 8041b40c 00200200 00100100 80310000 8041b414 80310000
> 801338d8
>         802f0000 8026a7fc 80b87c00 8046def0 00000000 c006a24c 80b7ff10
> 80b7ff10
>         00000002 00000000 8041b190 00000001 00000004 802f0000 8041cc90
> 80420000
>         802f0000 8012da80 8012e7c4 00000002 80469ef0 8012e694 80420000
> 00000002
>         ...
> Call Trace:
>  [<c006a24c>] iad_osal_mutexGive+0x0/0xc0 [ctlmspi]
>  [<8028c1f4>] rt_check_expire+0x0/0x234
>  [<801338d8>] run_timer_softirq+0x51c/0xaa4
>  [<8026a7fc>] net_rx_action+0xd8/0x2a8
>  [<c006a24c>] iad_osal_mutexGive+0x0/0xc0 [ctlmspi]
>  [<8012da80>] ___do_softirq+0x90/0x168
>  [<8012e7c4>] ksoftirqd+0x130/0x138
>  [<8012e694>] ksoftirqd+0x0/0x138
>  [<8012e694>] ksoftirqd+0x0/0x138
>  [<8012dc6c>] _do_softirq+0x60/0x7c
>  [<8012e74c>] ksoftirqd+0xb8/0x138
>  [<8012e754>] ksoftirqd+0xc0/0x138
>  [<801454c0>] kthread+0x268/0x2b0
>  [<801452c8>] kthread+0x70/0x2b0
>  [<80103a68>] kernel_thread_helper+0x10/0x18
>  [<80103a58>] kernel_thread_helper+0x0/0x18
> 
> 
> Code: 12000012  00000000  afb40010 <8e020020> 02002021  1440fff0
> 02202821  3c02
> 8032  0c0a304d
> note: ksoftirqd/0[2] exited with preempt_count 1
> BUG: scheduling while atomic: ksoftirqd/0/0x00000001/2
> caller is do_exit+0x924/0x12f0
> Call Trace:
>  [<8012a79c>] do_exit+0x924/0x12f0
>  [<802e4f14>] __schedule+0x8d0/0xba0
>  [<802e4f0c>] __schedule+0x8c8/0xba0
>  [<80410000>] ip_auto_config+0x338/0x1158
>  [<8012a79c>] do_exit+0x924/0x12f0
>  [<80107bfc>] __die+0xf8/0x108
>  [<8010c44c>] do_page_fault+0x14c/0x3b0
>  [<c008044c>] iad_eth_start_xmit+0x180/0x4d4 [ctlmeth]
>  [<8028c2f0>] rt_check_expire+0xfc/0x234
>  [<8028c30c>] rt_check_expire+0x118/0x234
>  [<80410000>] ip_auto_config+0x338/0x1158
>  [<8014d184>] handle_IRQ_event+0x94/0x1cc
>  [<8012dd14>] do_softirq+0x8c/0xb8
>  [<8012dd14>] do_softirq+0x8c/0xb8
>  [<8014d484>] __do_IRQ+0x1b0/0x22c
>  [<8014d4d0>] __do_IRQ+0x1fc/0x22c
>  [<80269724>] dev_queue_xmit+0x344/0x3ec
>  [<802696ec>] dev_queue_xmit+0x30c/0x3ec
>  [<8012de64>] irq_exit+0x5c/0x74
>  [<8014d184>] handle_IRQ_event+0x94/0x1cc
>  [<801032b4>] do_IRQ+0x24/0x3c
>  [<801032ac>] do_IRQ+0x1c/0x3c
>  [<8010ce60>] tlb_do_page_fault_0+0x100/0x108
>  [<8014d4d0>] __do_IRQ+0x1fc/0x22c
>  [<8012de64>] irq_exit+0x5c/0x74
>  [<c006a24c>] iad_osal_mutexGive+0x0/0xc0 [ctlmspi]
>  [<8028c30c>] rt_check_expire+0x118/0x234
>  [<8028c2f0>] rt_check_expire+0xfc/0x234
>  [<c006a24c>] iad_osal_mutexGive+0x0/0xc0 [ctlmspi]
>  [<8028c1f4>] rt_check_expire+0x0/0x234
>  [<801338d8>] run_timer_softirq+0x51c/0xaa4
>  [<8026a7fc>] net_rx_action+0xd8/0x2a8
>  [<c006a24c>] iad_osal_mutexGive+0x0/0xc0 [ctlmspi]
>  [<8012da80>] ___do_softirq+0x90/0x168
>  [<8012e7c4>] ksoftirqd+0x130/0x138
>  [<8012e694>] ksoftirqd+0x0/0x138
>  [<8012e694>] ksoftirqd+0x0/0x138
>  [<8012dc6c>] _do_softirq+0x60/0x7c
>  [<8012e74c>] ksoftirqd+0xb8/0x138
>  [<8012e754>] ksoftirqd+0xc0/0x138
>  [<801454c0>] kthread+0x268/0x2b0
>  [<801452c8>] kthread+0x70/0x2b0
>  [<80103a68>] kernel_thread_helper+0x10/0x18
>  [<80103a58>] kernel_thread_helper+0x0/0x18
> 
> -------------------------------------------------------------------------------------------------------------------

You would rather post it to lkml and netdev.
Please post a kernel version and some other basic info if there is any.

regards,
-- 
http://www.fi.muni.cz/~xslaby/   Jiri Slaby
