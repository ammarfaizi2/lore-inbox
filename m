Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964984AbWDGVvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbWDGVvq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 17:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbWDGVvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 17:51:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45498 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964984AbWDGVvp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 17:51:45 -0400
Date: Fri, 7 Apr 2006 14:54:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Don Dupuis" <dondster@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops at __bio_clone with 2.6.16-rc6 anyone??????
Message-Id: <20060407145407.1a210380.akpm@osdl.org>
In-Reply-To: <632b79000604071129hf28af6x59d73f6708ccff6b@mail.gmail.com>
References: <632b79000603271917h4104049dh9b6b8251feac0437@mail.gmail.com>
	<20060327200134.7369c7f8.akpm@osdl.org>
	<632b79000603280735w1908684djab2798c3f35cfebb@mail.gmail.com>
	<20060328113150.0acf2b60.akpm@osdl.org>
	<632b79000604070823s7f495d5ci416c9cef63ba11b@mail.gmail.com>
	<632b79000604071129hf28af6x59d73f6708ccff6b@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Don Dupuis" <dondster@gmail.com> wrote:
>
> ...
> 
> This is the oops output from 2.6.16.1
> 
> Apr  7 07:12:52 (none) kernel: Unable to handle kernel paging request at
> virtual address f8000000
> Apr  7 07:12:52 (none) kernel:  printing eip:
> Apr  7 07:12:52 (none) kernel: c0155cfd
> Apr  7 07:12:52 (none) kernel: *pde = 00000000
> Apr  7 07:12:52 (none) kernel: Oops: 0000 [#1]
> Apr  7 07:12:52 (none) kernel: SMP
> Apr  7 07:12:52 (none) kernel: Modules linked in:
> Apr  7 07:12:52 (none) kernel: CPU:    1
> Apr  7 07:12:52 (none) kernel: EIP:    0060:[<c0155cfd>]    Not tainted VLI
> Apr  7 07:12:52 (none) kernel: EFLAGS: 00010206   (2.6.16.1 #4)
> Apr  7 07:12:52 (none) kernel: EIP is at __bio_clone+0x29/0x9b
> Apr  7 07:12:52 (none) kernel: eax: 00000300   ebx: f5e37280   ecx: 00000082
> edx: f7fffe80
> Apr  7 07:12:52 (none) kernel: esi: f8000000   edi: f7f56a78   ebp: f7ce9b98
> esp: f7ce9b84
> Apr  7 07:12:52 (none) kernel: ds: 007b   es: 007b   ss: 0068
> Apr  7 07:12:52 (none) kernel: Process ldconfig (pid: 533, threadinfo=f7ce9000
> task=f7c3d540)
> Apr  7 07:12:52 (none) kernel: Stack: <0>f7e29458 f5e37280 f5e37280 f7fffe80
> f5e2b140 f7ce9ba8 c0155d9a f7d9ed98
> Apr  7 07:12:52 (none) kernel:        00000000 f7ce9bf4 c02c7126 00000080
> 00000000 00000e00 c01d2a5c 00000000
> Apr  7 07:12:52 (none) kernel:        0000007f 00000080 f7fffe80 f7e23bc0
> f7e22000 f7fffe80 f7e29458 c015690f
> Apr  7 07:12:52 (none) kernel: Call Trace:
> Apr  7 07:12:52 (none) kernel:  [<c0104260>] show_stack_log_lvl+0xa8/0xb0
> Apr  7 07:12:52 (none) kernel:  [<c0104397>] show_registers+0x109/0x171
> Apr  7 07:12:52 (none) kernel:  [<c010456e>] die+0xfb/0x16f
> Apr  7 07:12:52 (none) kernel:  [<c0114754>] do_page_fault+0x359/0x48b
> Apr  7 07:12:52 (none) kernel:  [<c0103f0b>] error_code+0x4f/0x54
> Apr  7 07:12:52 (none) kernel:  [<c0155d9a>] bio_clone+0x2b/0x31
> Apr  7 07:12:52 (none) kernel:  [<c02c7126>] make_request+0x208/0x3d4
> Apr  7 07:12:52 (none) kernel:  [<c02c6ff1>] make_request+0xd3/0x3d4
> Apr  7 07:12:52 (none) kernel:  [<c01d2a5c>] generic_make_request+0xf5/0x105
> Apr  7 07:12:52 (none) kernel:  [<c01d2b0d>] submit_bio+0xa1/0xa9
> Apr  7 07:12:52 (none) kernel:  [<c016f307>] mpage_bio_submit+0x1c/0x21
> Apr  7 07:12:52 (none) kernel:  [<c016f710>] do_mpage_readpage+0x30b/0x44d
> Apr  7 07:12:52 (none) kernel:  [<c016f8df>] mpage_readpages+0x8d/0xf1
> Apr  7 07:12:52 (none) kernel:  [<c01a6dc3>] ext3_readpages+0x14/0x16
> Apr  7 07:12:52 (none) kernel:  [<c013d867>] read_pages+0x26/0xc6
> Apr  7 07:12:53 (none) kernel:  [<c013da20>]
> __do_page_cache_readahead+0x119/0x135
> Apr  7 07:12:53 (none) kernel:  [<c013dae4>] do_page_cache_readahead+0x3d/0x49
> Apr  7 07:12:53 (none) kernel:  [<c0138c5e>] filemap_nopage+0x149/0x2c9
> Apr  7 07:12:53 (none) kernel:  [<c0143528>] do_no_page+0x82/0x245
> Apr  7 07:12:53 (none) kernel:  [<c0143855>] __handle_mm_fault+0xf4/0x1ba
> Apr  7 07:12:53 (none) kernel:  [<c011456f>] do_page_fault+0x174/0x48b
> Apr  7 07:12:53 (none) kernel:  [<c0103f0b>] error_code+0x4f/0x54
> Apr  7 07:12:53 (none) kernel: Code: 5d c3 55 89 e5 57 56 53 51 51 89 45 f0 8b
> 42

We seem to have lost a line of "Code:" there.

Could you please mail me your vmlinux?  And a new oops trace, if it's not
the vmlinux which produced the above.

