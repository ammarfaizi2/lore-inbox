Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264954AbUBIMNu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 07:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265081AbUBIMNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 07:13:50 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:8320 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S264954AbUBIMNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 07:13:46 -0500
Subject: Re: oops in old isdn4linux and 2.6.2-rc3 (was in -rc2 too)
From: David Woodhouse <dwmw2@infradead.org>
To: Karsten Keil <kkeil@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040202195139.GB2534@pingi3.kke.suse.de>
References: <401E4A80.4050907@web.de>
	 <20040202195139.GB2534@pingi3.kke.suse.de>
Content-Type: text/plain
Message-Id: <1076328820.11882.27.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Mon, 09 Feb 2004 12:13:40 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-02-02 at 20:51 +0100, Karsten Keil wrote:
> try the actual I4L for 2.6 patch in 
> ftp://ftp.isdn4linux.de/pub/isdn4linux/kernel/v2.6

I applied isdn-2.6.2-rc2.diff.gz to 2.6.3-rc1 (actually to BK as of
about Friday). Works fine for dialup, including isdn_lzscomp, on SMP.

Dies horribly upon an incoming v.110 call though...

(akpm/linus please note v.110 is fairly esoteric and it won't even
_compile_ in 2.6 at the moment so this is not a reason not to merge
Karsten's patch, which does at least make ISDN usable again in 2.6)

NMI Watchdog detected LOCKUP on CPU1, eip f8a5cd65, registers:
CPU:    1
EIP:    0060:[<f8a5cd65>]    Not tainted
EFLAGS: 00000086
EIP is at .text.lock.hfc_pci+0xfb/0x186 [hisax]
eax: f6531000   ebx: 00000120   ecx: 00000000   edx: f6288a40
esi: f6531614   edi: f652ac00   ebp: f6288a40   esp: f7f81b40
ds: 007b   es: 007b   ss: 0068
Process events/1 (pid: 7, threadinfo=f7f80000 task=f7f94ce0)
Stack: f6288800 00000028 c0224fea 00000097 f6531210 f652ac00 00000028 f6288800
       f8a533e6 f652ac00 00000120 f6288a40 0000003c 00000020 f75b7810 f6d52000
       f6288800 00000000 00000001 f89fb58f 00000000 00000001 00000001 f6288800
Call Trace:
 [<c0224fea>] skb_clone+0xaa/0x180
 [<f8a533e6>] HiSax_writebuf_skb+0x156/0x230 [hisax]
 [<f89fb58f>] isdn_v110_stat_callback+0x2bf/0x330 [isdn]
 [<f89fc57e>] isdn_status_callback+0x76e/0x8e0 [isdn]
 [<f89fc09c>] isdn_status_callback+0x28c/0x8e0 [isdn]
 [<c01b5937>] vsprintf+0x27/0x30
 [<f8a52231>] ll_writewakeup+0x61/0xa0 [hisax]
 [<c01b567d>] vsnprintf+0x23d/0x4a0
 [<c011afea>] __wake_up_common+0x3a/0x60
 [<f8a5af40>] hfcpci_fill_fifo+0x4e0/0x6a0 [hisax]
 [<f8a5c2d2>] hfcpci_send_data+0x22/0x50 [hisax]
 [<f8a5c5d5>] hfcpci_l2l1+0xa5/0x200 [hisax]
 [<c0224fea>] skb_clone+0xaa/0x180
 [<f8a533e6>] HiSax_writebuf_skb+0x156/0x230 [hisax]
 [<f89fb3dc>] isdn_v110_stat_callback+0x10c/0x330 [isdn]
 [<f89fc109>] isdn_status_callback+0x2f9/0x8e0 [isdn]
 [<c01b567d>] vsnprintf+0x23d/0x4a0
 [<f8a50370>] lli_go_active+0x0/0xd0 [hisax]
 [<c01b5937>] vsprintf+0x27/0x30
 [<f8a50370>] lli_go_active+0x0/0xd0 [hisax]
 [<f8a4ff24>] link_debug+0x64/0x80 [hisax]
 [<f8a50370>] lli_go_active+0x0/0xd0 [hisax]
 [<f8a503e7>] lli_go_active+0x77/0xd0 [hisax]
 [<f8a50370>] lli_go_active+0x0/0xd0 [hisax]
 [<c01b5937>] vsprintf+0x27/0x30
 [<f8a50370>] lli_go_active+0x0/0xd0 [hisax]
 [<f8a51c60>] callc_debug+0x50/0x60 [hisax]
 [<f8a44374>] l1m_debug+0x54/0x70 [hisax]
 [<f8a53640>] FsmEvent+0x90/0xf0 [hisax]
 [<f8a45130>] l1b_timer_act+0x0/0x40 [hisax]
 [<f8a45164>] l1b_timer_act+0x34/0x40 [hisax]
 [<f8a53640>] FsmEvent+0x90/0xf0 [hisax]
 [<f8a448b4>] BChannel_proc_rcv+0xa4/0xb0 [hisax]
 [<f8a4490d>] BChannel_bh+0x4d/0x50 [hisax]
 [<c012edea>] worker_thread+0x1aa/0x220
 [<f8a448c0>] BChannel_bh+0x0/0x50 [hisax]
 [<c011af90>] default_wake_function+0x0/0x20
 [<c0108e82>] ret_from_fork+0x6/0x14
 [<c011af90>] default_wake_function+0x0/0x20
 [<c012ec40>] worker_thread+0x0/0x220
 [<c0106e69>] kernel_thread_helper+0x5/0xc
 
Code: 80 38 00 7e f9 e9 fe f7 ff ff f3 90 80 7e 34 00 7e f8 e9 07
console shuts up ...


-- 
dwmw2


