Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264900AbUFXTC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264900AbUFXTC5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 15:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264788AbUFXTCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 15:02:35 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:237 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264808AbUFXTCJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 15:02:09 -0400
Date: Thu, 24 Jun 2004 12:01:44 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-mm2 oopses and badness
Message-ID: <27420000.1088103704@flay>
In-Reply-To: <1968860000.1088089370@[10.10.2.4]>
References: <1968860000.1088089370@[10.10.2.4]>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> During bootup, shortly after CPU init (mm1 was fine):
> 
> Only candidate I can see is 
> +reduce-tlb-flushing-during-process-migration-2.patch
> Will try backing that out unless you want something else ...

Looks like that's ia64 only ;-(

But the oops seems like we're just calling flush_tlb_mm with a NULL mm.
 
> Jun 24 06:54:24 larry kernel: c010e98b
> Jun 24 06:54:24 larry kernel: SMP 
> Jun 24 06:54:24 larry kernel: c010e98b
> Jun 24 06:54:24 larry kernel: Modules linked in:
> Jun 24 06:54:24 larry kernel: CPU:    12
> Jun 24 06:54:24 larry kernel: EIP:    0060:[flush_tlb_mm+7/120]    Not tainted VLI
> Jun 24 06:54:24 larry kernel: EFLAGS: 00010292   (2.6.7-mm2) 
> Jun 24 06:54:24 larry kernel: EIP is at flush_tlb_mm+0x7/0x78
> Jun 24 06:54:24 larry kernel: eax: 00000000   ebx: f124bfa8   ecx: 00000000   ed
> x: f124bf94
> Jun 24 06:54:24 larry kernel: esi: c30d3be0   edi: 00000000   ebp: f124bf9c   esp: f124bf4c
> Jun 24 06:54:24 larry kernel: ds: 007b   es: 007b   ss: 0068
> Jun 24 06:54:24 larry kernel: Process kswapd3 (pid: 72, threadinfo=f124a000 task=f1247390)
> Jun 24 06:54:24 larry kernel: Stack: 00200200 c01159e1 00000000 f1247390 f124bfdc f124bff0 f124bfa8 c02bcc40 
> Jun 24 06:54:24 larry kernel:        00000000 00000282 f124bf74 f124bf74 00000000 f1247390 0000000c f124a000 
> Jun 24 06:54:24 larry kernel:        00000000 00000001 f124bf94 f124bf94 f1a00000 c0138bca f1247390 0000f000 
> Jun 24 06:54:24 larry kernel: Call Trace:
> Jun 24 06:54:24 larry kernel:  [set_cpus_allowed+225/252] set_cpus_allowed+0xe1/0xfc
> Jun 24 06:54:24 larry kernel:  [kswapd+142/224] kswapd+0x8e/0xe0
> Jun 24 06:54:24 larry kernel:  [kswapd+0/224] kswapd+0x0/0xe0
> Jun 24 06:54:24 larry kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
> Jun 24 06:54:24 larry kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
> Jun 24 06:54:24 larry kernel:  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
> Jun 24 06:54:24 larry kernel: Code: 0f 20 d8 0f 22 d8 8b 04 24 85 c0 74 13 6a ff 51 50 e8 0a ff ff ff 83 c4 0c 8d b4 26 00 00 00 00 59 c3 89 f6 83 ec
>  04 8b 4c 24 08 <8b> 81 24 01 00 00 ba 00 e0 ff ff 21 e2 89 04 24 8b 42 10 f0 0f 

