Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262919AbUDAOZH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 09:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262923AbUDAOZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 09:25:07 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:2690 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S262919AbUDAOZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 09:25:00 -0500
Date: Thu, 1 Apr 2004 11:24:58 -0300
From: Flavio Bruno Leitner <fbl@conectiva.com.br>
To: "Craig, Dave" <dwcraig@qualcomm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       "Rafael D'Halleweyn (List)" <list@noduck.net>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at kernel/timer.c:370!
Message-ID: <20040401142458.GB2132@conectiva.com.br>
References: <0320111483D8B84AAAB437215BBDA526847F70@NAEX01.na.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0320111483D8B84AAAB437215BBDA526847F70@NAEX01.na.qualcomm.com>
User-Agent: Mutt/1.5.5.1i
X-Bogosity: No, tests=bogofilter, spamicity=0.486275, version=0.16.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2004 at 09:16:52AM -0800, Craig, Dave wrote:
> cascade: c1a1d5e0 != c1a0d5e0
> hander=c028ee8d (igmp_ifc_timer_expire+0x0/0x3e)
> Call Trace:
>  [<c012ca73>] cascade+0x79/0xa1
>  [<c028ee8d>] igmp_ifc_timer_expire+0x0/0x3e
>  [<c012d0b3>] run_timer_softirq+0x159/0x1c9
>  [<c012899d>] do_softirq+0xc9/0xcb
>  [<c0119c46>] smp_apic_timer_interrupt+0xd8/0x140
>  [<c0108c09>] default_idle+0x0/0x32
>  [<c010bab2>] apic_timer_interrupt+0x1a/0x20
>  [<c0108c09>] default_idle+0x0/0x32
>  [<c0108c36>] default_idle+0x2d/0x32
>  [<c0108cb4>] cpu_idle+0x3a/0x43
>  [<c0105000>] rest_init+0x0/0x68
>  [<c039c89f>] start_kernel+0x1b7/0x209
>  [<c039c427>] unknown_bootoption+0x0/0x124
> 
> Here is the result.  I am doing a lot of IPv4 multicast.

Applied the patch, here is the result.
cascade: c040b170 != c040ab00           
handler=c040b168 (0xc040b168)
Call Trace:                  
 [<c012741f>] cascade+0x7f/0xb0
 [<c0127a3e>] run_timer_softirq+0xee/0x170
 [<c0123b15>] do_softirq+0xa5/0xb0        
 [<c010b625>] do_IRQ+0xe5/0x120   
 [<c0109a94>] common_interrupt+0x18/0x20
 [<c0107066>] default_idle+0x26/0x40    
 [<c01070f4>] cpu_idle+0x34/0x40    
 [<c03b0829>] start_kernel+0x189/0x1e0
 [<c03b0540>] unknown_bootoption+0x0/0x120
                                          
cascade: c040ab20 != c040ab00
handler=c040ab18 (0xc040ab18)
Call Trace:                  
 [<c012741f>] cascade+0x7f/0xb0
 [<c0127a3e>] run_timer_softirq+0xee/0x170
 [<c0123b15>] do_softirq+0xa5/0xb0        
 [<c010b625>] do_IRQ+0xe5/0x120   
 [<c0109a94>] common_interrupt+0x18/0x20
 [<c0107066>] default_idle+0x26/0x40    
 [<c01070f4>] cpu_idle+0x34/0x40    
 [<c03b0829>] start_kernel+0x189/0x1e0
 [<c03b0540>] unknown_bootoption+0x0/0x120


-- 
Flávio Bruno Leitner <fbl@conectiva.com.br>
[ E74B 0BD0 5E05 C385 239E  531C BC17 D670 7FF0 A9E0 ]
