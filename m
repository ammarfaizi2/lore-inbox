Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967214AbWKYV33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967214AbWKYV33 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 16:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967215AbWKYV33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 16:29:29 -0500
Received: from smtp.osdl.org ([65.172.181.25]:22253 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S967214AbWKYV32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 16:29:28 -0500
Date: Sat, 25 Nov 2006 13:28:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: OOM killer firing on 2.6.18 and later during LTP runs
Message-Id: <20061125132828.16a01762.akpm@osdl.org>
In-Reply-To: <4568AFB1.3050500@mbligh.org>
References: <4568AFB1.3050500@mbligh.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2006 13:03:45 -0800
"Martin J. Bligh" <mbligh@mbligh.org> wrote:

> On 2.6.18-rc7 and later during LTP:
> http://test.kernel.org/abat/48393/debug/console.log

The traces are a bit confusing, but I don't actually see anything wrong
there.  The machine has used up all swap, has used up all memory and has
correctly gone and killed things.  After that, there's free memory again.

> oom-killer: gfp_mask=0x201d2, order=0
> 
> Call Trace:
>   [<ffffffff802638cb>] out_of_memory+0x33/0x220
>   [<ffffffff80265374>] __alloc_pages+0x23a/0x2c3
>   [<ffffffff802667d2>] __do_page_cache_readahead+0x99/0x212
>   [<ffffffff80260799>] sync_page+0x0/0x45
>   [<ffffffff804b304c>] io_schedule+0x28/0x33
>   [<ffffffff804b32b8>] __wait_on_bit_lock+0x5b/0x66
>   [<ffffffff8043d849>] dm_any_congested+0x3b/0x42
>   [<ffffffff80262e50>] filemap_nopage+0x14b/0x353
>   [<ffffffff8026cf9a>] __handle_mm_fault+0x387/0x93f
>   [<ffffffff804b6366>] do_page_fault+0x44b/0x7ba
>   [<ffffffff80245a4e>] autoremove_wake_function+0x0/0x2e
> oom-killer: gfp_mask=0x280d2, order=0
> 
> Call Trace:
>   [<ffffffff802638cb>] out_of_memory+0x33/0x220
>   [<ffffffff80265374>] __alloc_pages+0x23a/0x2c3
>   [<ffffffff8026cde3>] __handle_mm_fault+0x1d0/0x93f
>   [<ffffffff804b6366>] do_page_fault+0x44b/0x7ba
>   [<ffffffff804b2854>] thread_return+0x0/0xe0
>   [<ffffffff8020a405>] error_exit+0x0/0x84
> 
> --------------------------------------------------
> 
> This doesn't seem to happen every run, unfortnately, only
> intermittently, and we don't have much data before that, so
> hard to tell how long it's been going on.
> 
> Still happening on latest kernels.
> http://test.kernel.org/abat/62445/debug/console.log

The same appears to have happened there too.  Although it does seem to have
killed a lot more than it should have.

Has something changed in the configuration of that machine?  New LTP
version?  Less swapsapce?

