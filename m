Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262612AbUKLTAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262612AbUKLTAb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 14:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbUKLTAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 14:00:31 -0500
Received: from mailfe06.swip.net ([212.247.154.161]:4493 "EHLO
	mailfe06.swip.net") by vger.kernel.org with ESMTP id S262612AbUKLTAU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 14:00:20 -0500
X-T2-Posting-ID: 2Ngqim/wGkXHuU4sHkFYGQ==
Subject: Re: 2.6.10-rc1-mm5
From: Alexander Nyberg <alexn@dsv.su.se>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mpm@selenic.com
In-Reply-To: <20041111012333.1b529478.akpm@osdl.org>
References: <20041111012333.1b529478.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1100286003.18492.0.camel@boxen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 12 Nov 2004 20:00:03 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-11 at 10:23, Andrew Morton wrote: 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm5/
> 
> 
> - Various updates to various things.  Nothing really stands out.

Got a few of these running LTP (the second -x 4 run). I was beating up
NFS a bit when I saw this (this coming from the server side). UP x86 box
with netconsole using tulip NIC. No preempt involved and it doesn't
appear to happen if I don't put some IO pressure on it, seems
reproducible otherwise.



Badness in local_bh_enable at kernel/softirq.c:140
[<c011c3c6>] local_bh_enable+0x86/0x90
[<c038c4b7>] svc_write_space+0x27/0x90
[<c0335ebb>] sock_wfree+0x5b/0x60
[<c0337229>] __kfree_skb+0x49/0xe0
[<c03469b9>] zap_completion_queue+0x39/0x60
[<c03468cf>] netpoll_poll+0x7f/0xc0
[<c0346b1e>] netpoll_send_skb+0x7e/0xc0
[<c02dbf72>] write_msg+0x32/0x40
[<c02dbf40>] write_msg+0x0/0x40
[<c01178d5>] __call_console_drivers+0x45/0x50
[<c01179c5>] call_console_drivers+0x75/0x100
[<c0117d4e>] release_console_sem+0x5e/0xf0
[<c0117c3e>] vprintk+0xfe/0x160
[<c0117b37>] printk+0x17/0x20
[<c014880e>] sys_swapon+0x58e/0x790
[<c0103db3>] syscall_call+0x7/0xb
Badness in local_bh_enable at kernel/softirq.c:140
[<c0104db7>] dump_stack+0x17/0x20
[<c011cf45>] local_bh_enable+0x85/0x90
[<c038fde8>] svc_write_space+0x28/0x90
[<c0338e48>] sock_wfree+0x58/0x60
[<c033a179>] __kfree_skb+0x49/0xd0
[<c0349b6a>] zap_completion_queue+0x3a/0x60
[<c0349a7b>] netpoll_poll+0x7b/0xb0
[<c0349cc7>] netpoll_send_skb+0x87/0xd0
[<c02de37a>] write_msg+0x3a/0x50
[<c0118202>] __call_console_drivers+0x52/0x60
[<c01182ff>] call_console_drivers+0x7f/0x100
[<c011869a>] release_console_sem+0x6a/0x100
[<c011856e>] vprintk+0xfe/0x160
[<c0118468>] printk+0x18/0x20
[<c014abe7>] sys_swapon+0x5b7/0x7d0
[<c0103fb7>] syscall_call+0x7/0xb
Badness in local_bh_enable at kernel/softirq.c:140
[<c0104db7>] dump_stack+0x17/0x20
[<c011cf45>] local_bh_enable+0x85/0x90
[<c038fde8>] svc_write_space+0x28/0x90
[<c0338e48>] sock_wfree+0x58/0x60
[<c033a179>] __kfree_skb+0x49/0xd0
[<c0349b6a>] zap_completion_queue+0x3a/0x60
[<c0349a7b>] netpoll_poll+0x7b/0xb0
[<c0349cc7>] netpoll_send_skb+0x87/0xd0
[<c02de37a>] write_msg+0x3a/0x50
[<c0118202>] __call_console_drivers+0x52/0x60
[<c01182ff>] call_console_drivers+0x7f/0x100
[<c011869a>] release_console_sem+0x6a/0x100
[<c011856e>] vprintk+0xfe/0x160
[<c0118468>] printk+0x18/0x20
[<c014abe7>] sys_swapon+0x5b7/0x7d0
[<c0103fb7>] syscall_call+0x7/0xb



