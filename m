Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbUKWVOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbUKWVOt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 16:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbUKWTJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 14:09:04 -0500
Received: from fsmlabs.com ([168.103.115.128]:3264 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261401AbUKWSxs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 13:53:48 -0500
Date: Tue, 23 Nov 2004 11:53:31 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: "Deepak Kumar Gupta, Noida" <dkumar@hcltech.com>
cc: "'Robin Holt '" <holt@sgi.com>,
       "''lilbilchow@yahoo.com' '" <lilbilchow@yahoo.com>,
       "''ananth@sgi.com' '" <ananth@sgi.com>,
       "''linux-kernel@vger.kernel.org' '" <linux-kernel@vger.kernel.org>,
       "''linux-ia64@vger.kernel.org' '" <linux-ia64@vger.kernel.org>
Subject: RE: smp_call_function/flush_tlb_all hang on large memory system
In-Reply-To: <267988DEACEC5A4D86D5FCD780313FBB2BFBB6@exch-03.noida.hcltech.com>
Message-ID: <Pine.LNX.4.61.0411231152020.7167@musoma.fsmlabs.com>
References: <267988DEACEC5A4D86D5FCD780313FBB2BFBB6@exch-03.noida.hcltech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2004, Deepak Kumar Gupta, Noida wrote:

> Hi Robin 
> 
> The output of CPU is 
> 
> CPU  A: 0x02:   Kernel: CPU busy
>         0x03:   Kernel: CPU busy
> CPU  C: 0x03:   Kernel: CPU busy
> 
> well regarding filing the issue.. i haven't yet contactated support
> persons.. send the mail to just know whether there is already a solution
> available or not.. 
> 
> If you are interested in stack trace.. then it is as follows:-
> 
> [0]kdb> bt
> Stack traceback for pid 7
> 0xe00000307b818000        7        1  1    0   R  0xe00000307b8185a0 *kswapd
> 0xe00000000444b120 smp_call_function+0x5e0
>         args (0xe000000005033698, 0xe000000005033698, 0x1,
> 0xa000000000008000, 0x1)
>         kernel .text 0xe000000004400000 0xe00000000444ab40
> 0xe00000000444b160
> 0xe00000000444a330 smp_flush_tlb_all+0x30
>         args (0xe0000000044545a0, 0x288)
>         kernel .text 0xe000000004400000 0xe00000000444a300
> 0xe00000000444a360
> 0xe0000000044545a0 flush_tlb_range+0x40
>         args (0xe00000307a5b64c8, 0x2000000002128000, 0x200000000212c000,
> 0xe000000004559880, 0x58e)
>         kernel .text 0xe000000004400000 0xe000000004454560
> 0xe000000004454700
> 0xe000000004559880 try_to_swap_out+0x320
>         args (0xe00000307a5b64c8, 0xe00000303b910468, 0x27be00,
> 0xe000003045638250, 0xa0007fffffe20300)
>         kernel .text 0xe000000004400000 0xe000000004559560

This function holds mm->page_table_lock which is acquired with interrupts 
disabled. As a result there is a window for deadlock when you descend into 
smp_call_function. I suggest you run fast from crusty kernels ;)

