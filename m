Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbUKHAnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbUKHAnR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 19:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbUKHAnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 19:43:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:35300 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261717AbUKHAmz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 19:42:55 -0500
Date: Sun, 7 Nov 2004 16:42:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Michael Buesch <mbuesch@freenet.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] fix address passing of unknown_bootoption
Message-Id: <20041107164244.34ad8bfd.akpm@osdl.org>
In-Reply-To: <200411072247.39841.mbuesch@freenet.de>
References: <200411072247.39841.mbuesch@freenet.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch <mbuesch@freenet.de> wrote:
>
> Hi Andrew,
> 
> Addresses of functions are returned by their name without
> parantheses. Remove an & in main.c

Using `&' in fornt of a function name when passing the function's address
is unnecessary and is kinda dorky, but your patch shouldn't change
generated code.

> Unable to handle kernel paging request at virtual address 00020800
>  printing eip:
> 00020800
> *pde = 00000000
> Oops: 0000 [#1]
> SMP 
> Modules linked in: ipv6 ohci_hcd tuner tvaudio msp3400 bttv video_buf btcx_risc nvidia ehci_hcd uhci_hcd usbcore intel_agp agpgart evdev
> CPU:    0
> EIP:    0060:[<00020800>]    Tainted: P   VLI
> EFLAGS: 00010296   (2.6.9-ck3-ac6-nozeroram) 
> EIP is at 0x20800
> eax: 00000001   ebx: b03e6000   ecx: 00000001   edx: 00000084
> esi: 00099100   edi: b01020a7   ebp: 00459007   esp: b03e7fec
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 0, threadinfo=b03e6000 task=b034bac0)
> Stack: b03e881c 000000d9 b03e8310 b04132a0 b0100211 
> Call Trace:
>  [<b03e881c>] start_kernel+0x139/0x152
>  [<b03e8310>] unknown_bootoption+0x0/0x171
> Code:  Bad EIP value.
>  <0>Kernel panic - not syncing: Attempted to kill the idle task!
> 
> 
> Unable to handle kernel paging request at virtual address 00099108
>  printing eip:
> b01020a7
> *pde = 00000000
> Oops: 0000 [#1]
> SMP 
> Modules linked in: nvidia ohci_hcd tuner tvaudio msp3400 bttv video_buf btcx_risc ehci_hcd uhci_hcd usbcore intel_agp agpgart evdev
> CPU:    0
> EIP:    0060:[<b01020a7>]    Tainted: P   VLI
> EFLAGS: 00010292   (2.6.9-ck2-ac4-nozeroram) 
> EIP is at cpu_idle+0x2e/0x3c
> eax: 00000001   ebx: 00099100   ecx: 00000000   edx: 0000001d
> esi: 00000000   edi: 00000008   ebp: 004f3007   esp: b0477fe8
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 0, threadinfo=b0476000 task=b03ccac0)
> Stack: 00020800 b047881c 000000dd b0478310 b04a62a0 b0100211 
> Call Trace:
>  [<b047881c>] start_kernel+0x139/0x152
>  [<b0478310>] unknown_bootoption+0x0/0x171
> Code: e0 ff ff 21 e3 eb 24 8b 0d 80 56 4a b0 b8 1a 20 10 b0 8b 15 a0 e5 3c b0 85 c9 0f 44 c8 8b 43 10 c1 e0 07 89 90 04 ea 4a b0 ff d1 <8b> 43 08 a8 08 74 d5 e8 0d a9 26 00 eb f2 56 53 fb ba 00 e0 ff 
>  <0>Kernel panic - not syncing: Attempted to kill the idle task!

hm, I don't know what happened there.  Maybe the value of pm_idle in
cpu_idle() is garbage.  Or maybe not.

