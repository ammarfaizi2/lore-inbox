Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262851AbVCDMUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262851AbVCDMUE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 07:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262871AbVCDMTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 07:19:37 -0500
Received: from fire.osdl.org ([65.172.181.4]:13535 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262835AbVCDLxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 06:53:47 -0500
Date: Fri, 4 Mar 2005 03:53:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Richard Fuchs <richard.fuchs@inode.info>
Cc: linux-kernel@vger.kernel.org
Subject: Re: slab corruption in skb allocs
Message-Id: <20050304035309.1da7774e.akpm@osdl.org>
In-Reply-To: <42283093.7040405@inode.info>
References: <42283093.7040405@inode.info>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Fuchs <richard.fuchs@inode.info> wrote:
>
> hello all!
> 
> the memory allocation debugger gives me the following messages under a
> vanilla 2.6.10 and 2.6.11 kernel when doing
> 
> 1) hdparm -d0 on my hard disk
> 2) tar c / > /dev/null
> 3) sending lots of network traffic to the machine (e.g. close to 100
> mbit/s udp packets)
> 
> -----------------------------------------------------
> Slab corruption: start=de9141a4, len=2048
> Redzone: 0x5a2cf071/0x5a2cf071.
> Last user: [<c03b8163>](kfree_skbmem+0x13/0x30)
> 010: 6b 6b 20 a0 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 3b c0
> 020: 6b 6b 00 0b cd 1e 1f d2 00 04 23 01 c7 6f 81 00
> 030: 00 df 08 00 45 00 00 1c 41 d0 40 00 40 11 33 78
> 040: c0 a8 22 1d c0 a8 22 1b 80 52 30 18 00 08 89 ea
> 050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 6b 6b
> ...
> 
> and so on. the disk activity alone or the network traffic alone doesn't
> trigger this. also doing the same with dma enabled doesn't trigger this
> either, but when everything comes together i get this within a second.
> kernel is not smp and preempt is not enabled.
> 
> kernel config (from 2.6.11) is attached; if you need any more info, let
> me know. is this a kernel issue, or could the hardware be at fault?

I guess it could be hardware.  But given that disabling DMA _causes_ the
problem, rather than fixes it, it seems unlikely.

Could you enable CONFIG_DEBUG_PAGEALLOC in .config and see it that triggers
an oops?

