Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751529AbWIMDnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbWIMDnU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 23:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbWIMDnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 23:43:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63668 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751527AbWIMDnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 23:43:20 -0400
Date: Tue, 12 Sep 2006 20:43:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Marcin =?UTF-8?B?UHLEhWN6a28i?= <marcin.praczko@googlemail.com>"@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Oops
Message-Id: <20060912204314.ef48c782.akpm@osdl.org>
In-Reply-To: <6c99578d0609120321h461e18c1tc50e06ec7cd43619@mail.gmail.com>
References: <6c99578d0609120321h461e18c1tc50e06ec7cd43619@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sep 2006 11:21:57 +0100
"Marcin Prączko" <marcin.praczko@googlemail.com> wrote:

> Hi,
> 
> I compiled kernel 2.6.17.7 - all is build in kernel (no modules)
> And yesterday I had Oops:
> I enclosed Oops info.
> 
> Can you explain to me please, where is some problem ??
>

>  
> BUG: unable to handlekernel paging request at virtual adress 04000020
>   printing eip:
> c024c3d5
> *pde = 00000000
> Oops: 0000 [#1]
> Modules linked in:
> CPU:     0
> EIP:     0060:[<c024c3d5>]  Not tainted VLI
> EFLAGS:  00010206  (2.6.17.7 #3)
> EIP: is at rt_check_expire+0x9a/0x10c
> eax: 04000000  ebx: 04000000  ecx: 00000000  edx: 00000055
> esi: f7ca0154  edi: 000124f8  ebp: 00001891  esp: c0343f60
> ds: 007b  es: 007b  ss: 0068
> Process swapper (pid: 0, threadinfo=c0342000 task=c02eb180)
> Stack: 0043cea3 00000055 0000000a c0342000 c03791e0 00000100 c024c33b c0119c7d
>        c0390034 c0390034 c0127ce8 00000001 c0378ee8 0000000a 003b9007 c0116e69
>        00000046 0009fb00 c0337800 c0116ed3 00010800 c01048de c010337a 00010800
> Call Trace:
>  <c024c33b> rt_check_expire+0x0/0x10c  <c0119c7d> run_timer_softirq+0x35/0x7d
>  <c0127ce8> handle_IRQ_event+0x21/0x4a  <c0116e69> __do_softirq+0x35/0x7d
>  <c0116ed3> do_softirq+0x22/0x26  <c01048de> do_IRQ+0x1e/0x24
>  <c010337a> common_interrupt+0x1a/0x20  <c0100a73> default_idle+0x2b/0x53
>  <c0100af1> cpu_idle+0x42/0x57  <c03445ea> start_kernel+0x170/0x172
> Code: ed 74 73 ff 44 24 04 8b 15 08 1f 39 c0 21 54 24 04 a1 04 1f 39 c0 8b 54 24 04 8b 3d 88 d3 30 c0 8d 34 90 8b 06 85 c0 74 4a
>  89 c3 <8b> 43 20 85 c0 74 07 3b 04 24 78 1b eb 13 8b 0d 88 d3 30 c0 89
> EIP: [<c024c3d5>] rt_check_expire+0x9a/0x10c SS:ESP 0068:c0343f60
>  <0>Kernel panic - not syncing: Fatal exception in interrupt 
> 

I'd be suspecting that 0x04000000 should have been 0x00000000: a single bit
error often indicates hardware problems.

