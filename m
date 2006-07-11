Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWGKNtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWGKNtx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 09:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWGKNtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 09:49:53 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:57495 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750791AbWGKNtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 09:49:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RrdMdW/N1l0tNwSZFLT8AIqSgCnVsMw0q5b3tMtkyURMlVS6N65UgGWZTmYzThVi3ugGQSzmddd5xShEIDkJ7IH2lz8hdxoROmRJbY3XF8UL9uPrregDK/KXs/t9IyKgJHYSuy5CLvZxgPV/TVGHmySAIwQL2nMpzynCcimoUQA=
Message-ID: <6bffcb0e0607110649s464840a9sf04c7537809436b1@mail.gmail.com>
Date: Tue, 11 Jul 2006 15:49:52 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 00/10] Kernel memory leak detector 0.8
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b0943d9e0607110628w60a436f7t449714eb4a3200ca@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060710220901.5191.66488.stgit@localhost.localdomain>
	 <6bffcb0e0607110527x4520d5bbne8b9b3639a821a18@mail.gmail.com>
	 <b0943d9e0607110556v50185b9i5443dabedba46152@mail.gmail.com>
	 <6bffcb0e0607110617g36f7123dm2b5f0e88b10cbcaa@mail.gmail.com>
	 <b0943d9e0607110628w60a436f7t449714eb4a3200ca@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> On 11/07/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > With gcc 3.4 it build.
>
> Could you try with CONFIG_DEBUG_KEEP_INIT=y and gcc-3.4? It seems to
> work OK for me.

It builds fine.

System hangs when I try "cat /sys/kernel/debug/memleak". Here is what
I found in a log file.

Jul 11 15:40:13 ltg01-fedora kernel:  [<c0106e09>] show_trace_log_lvl+0x54/0xff
Jul 11 15:40:11 ltg01-fedora kernel:  [<c0106ec1>] show_trace+0xd/0xf
Jul 11 15:40:12 ltg01-fedora kernel:  [<c0106f93>] dump_stack+0x17/0x19
Jul 11 15:40:12 ltg01-fedora kernel:  [<c017572c>] memleak_free+0x10e/0x183
Jul 11 15:40:13 ltg01-fedora kernel:  [<c01734c2>] __cache_free+0x1e/0x5a
Jul 11 15:40:13 ltg01-fedora kernel:  [<c0173a42>] kmem_cache_free+0x54/0x6e
Jul 11 15:40:11 ltg01-fedora kernel:  [<c01205cd>] pgd_free+0xf/0x12
Jul 11 15:40:12 ltg01-fedora kernel:  [<c0127254>] __mmdrop+0x1d/0x33
Jul 11 15:40:13 ltg01-fedora kernel:  [<c02f1d32>] schedule+0x64a/0x6a9
Jul 11 15:40:14 ltg01-fedora kernel:  [<fd962493>] evdev_read+0xe2/0x174 [evdev]
Jul 11 15:40:11 ltg01-fedora kernel:  [<c0177fb7>] vfs_read+0xa9/0x151
Jul 11 15:40:12 ltg01-fedora kernel:  [<c01782d7>] sys_read+0x3b/0x60
Jul 11 15:40:13 ltg01-fedora kernel:  [<c0105ef1>] sysenter_past_esp+0x56/0x8d
Jul 11 15:40:13 ltg01-fedora kernel:  [<b7ff8410>] 0xb7ff8410
Jul 11 15:40:13 ltg01-fedora kernel: kmemleak: pointer 0xf24ad000:
Jul 11 15:40:13 ltg01-fedora kernel:   trace:
Jul 11 15:40:10 ltg01-fedora kernel:     c01735c2: <kmem_cache_alloc>
Jul 11 15:40:11 ltg01-fedora kernel:     c01205bc: <pgd_alloc>
Jul 11 15:40:12 ltg01-fedora kernel:     c01271df: <mm_init>
Jul 11 15:40:12 ltg01-fedora kernel:     c01273f1: <dup_mm>
Jul 11 15:40:11 ltg01-fedora kernel:     c01276b5: <copy_mm>
Jul 11 15:40:11 ltg01-fedora kernel:     c012853c: <copy_process>
Jul 11 15:40:12 ltg01-fedora kernel:     c0128c46: <do_fork>
Jul 11 15:40:13 ltg01-fedora kernel:     c0104cee: <sys_clone>
Jul 11 15:40:12 ltg01-fedora kernel: kmemleak: freeing orphan pointer 0xf24ad000
Jul 11 15:40:12 ltg01-fedora kernel:  [<c0106e09>] show_trace_log_lvl+0x54/0xff
Jul 11 15:40:11 ltg01-fedora kernel:  [<c0106ec1>] show_trace+0xd/0xf
Jul 11 15:40:13 ltg01-fedora kernel:  [<c0106f93>] dump_stack+0x17/0x19
Jul 11 15:40:12 ltg01-fedora kernel:  [<c017572c>] memleak_free+0x10e/0x183
Jul 11 15:40:11 ltg01-fedora kernel:  [<c01734c2>] __cache_free+0x1e/0x5a
Jul 11 15:40:12 ltg01-fedora kernel:  [<c0173a42>] kmem_cache_free+0x54/0x6e
Jul 11 15:40:13 ltg01-fedora kernel:  [<c028f9d9>] uhci_free_urb_priv+0x7a/0x82
Jul 11 15:40:12 ltg01-fedora kernel:  [<c0290803>] uhci_giveback_urb+0xb3/0x148
Jul 11 15:40:12 ltg01-fedora kernel:  [<c029093a>] uhci_scan_qh+0xa2/0x18f
Jul 11 15:40:46 ltg01-fedora kernel:  [<c0290b71>] uhci_scan_schedule+0x89/0x116
Jul 11 15:41:03 ltg01-fedora kernel:  [<c02916ce>] uhci_irq+0x108/0x120
Jul 11 15:42:16 ltg01-fedora kernel:  [<c0282568>] usb_hcd_irq+0x2a/0x53
Jul 11 15:42:29 ltg01-fedora kernel:  [<c0156cd8>] handle_IRQ_event+0x1f/0x4c
Jul 11 15:42:51 ltg01-fedora kernel:  [<c0156d92>] __do_IRQ+0x8d/0xe9
Jul 11 15:43:08 ltg01-fedora kernel:  [<c01086ee>] do_IRQ+0xc2/0xd4
Jul 11 15:46:22 ltg01-fedora kernel:  [<c010695d>] common_interrupt+0x25/0x2c
Jul 11 15:47:31 ltg01-fedora kernel:  [<c012ed44>] __do_softirq+0x65/0xea
Jul 11 15:47:43 ltg01-fedora kernel:  [<c01087f5>] do_softirq+0x60/0xc5
Jul 11 15:48:17 ltg01-fedora kernel:  [<c012ee11>] irq_exit+0x48/0x55
Jul 11 15:49:09 ltg01-fedora kernel:  [<c011a105>]
smp_apic_timer_interrupt+0x69/0x6c

http://www.stardust.webpages.pl/files/o_bugs/kml/kml-config4

> Thanks.
>
> --
> Catalin
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
