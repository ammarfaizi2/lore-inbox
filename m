Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272225AbRH3OR7>; Thu, 30 Aug 2001 10:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272226AbRH3ORt>; Thu, 30 Aug 2001 10:17:49 -0400
Received: from ns.ithnet.com ([217.64.64.10]:6415 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S272225AbRH3ORk>;
	Thu, 30 Aug 2001 10:17:40 -0400
Date: Thu, 30 Aug 2001 16:16:45 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Memory Problem in 2.4.10-pre2 / __alloc_pages failed
Message-Id: <20010830161645.2a1a6922.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.33.0108300521280.448-100000@mikeg.weiden.de>
In-Reply-To: <20010829211810.68a75425.skraw@ithnet.com>
	<Pine.LNX.4.33.0108300521280.448-100000@mikeg.weiden.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2001 05:42:14 +0200 (CEST)
Mike Galbraith <mikeg@wen-online.de> wrote:

> On Wed, 29 Aug 2001, Stephan von Krawczynski wrote:
> A small sample with junk like that order 3 GFP_ATOMIC allocation should
> pin the tail on the donkey.

Ok. I produced another one, here it is. This time I send only one :-) If it is not sufficient, tell me, I have some dozends left.

Aug 30 16:05:07 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 30 16:05:07 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=3, ...)
Aug 30 16:05:07 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] [<fdcf77d7>] 
Aug 30 16:05:07 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [send_sigio_to_task+226/236] [ip_rcv_finish+0/480] [nf_iterate+48/132] [ip_rcv_finish+0/480] 
Aug 30 16:05:07 admin kernel:    [ip_rcv_finish+0/480] [nf_hook_slow+215/404] [send_sigio+88/168] [update_wall_time+11/52] [timer_bh+54/700] [tqueue_bh+22/28] 
Aug 30 16:05:07 admin kernel:    [bh_action+76/132] [tasklet_hi_action+110/156] [update_process_times+32/148] [smp_apic_timer_interrupt+241/276] [sys_ioctl+443/532] [system_call+51/56] 

Trace; c012beee <_alloc_pages+16/18>
Trace; c012c1aa <__get_free_pages+a/18>
Trace; fdcf8826 <[sg]sg_low_malloc+13e/1a4>
Trace; fdcf8913 <[sg]sg_malloc+87/120>
Trace; fdcf77d7 <[sg]sg_build_indi+16f/1a8>
Trace; fdcf80f5 <[sg]sg_build_reserve+25/48>
Trace; fdcf6589 <[sg]sg_ioctl+6c5/ae4>
Trace; c01403d6 <send_sigio_to_task+e2/ec>
Trace; c01d4ba0 <ip_rcv_finish+0/1e0>
Trace; c01cec8c <nf_iterate+30/84>   
Trace; c01d4ba0 <ip_rcv_finish+0/1e0>
Trace; c01d4ba0 <ip_rcv_finish+0/1e0>
Trace; c01cefdf <nf_hook_slow+d7/194>
Trace; c0140438 <send_sigio+58/a8>   
Trace; c011bb87 <update_wall_time+b/34>
Trace; c011bd96 <timer_bh+36/2bc>
Trace; c011b89e <tqueue_bh+16/1c>
Trace; c0118e74 <bh_action+4c/84>
Trace; c0118d5a <tasklet_hi_action+6e/9c>
Trace; c011bca4 <update_process_times+20/94>
Trace; c011019d <smp_apic_timer_interrupt+f1/114>
Trace; c0140937 <sys_ioctl+1bb/214>
Trace; c0106d1b <system_call+33/38>

Regards, Stephan

