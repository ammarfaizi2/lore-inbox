Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbTFJTbN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 15:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbTFJTaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 15:30:00 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:15178 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262192AbTFJT1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 15:27:46 -0400
Date: Tue, 10 Jun 2003 12:37:32 -0700
From: Andrew Morton <akpm@digeo.com>
To: "John Stoffel" <stoffel@lucent.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Zwane Mwaikambo <zwane@holomorphy.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.5.70-mm3 - Oops and hang
Message-Id: <20030610123732.562e7b22.akpm@digeo.com>
In-Reply-To: <16101.55819.768909.143767@gargle.gargle.HOWL>
References: <16101.55819.768909.143767@gargle.gargle.HOWL>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jun 2003 19:41:25.0123 (UTC) FILETIME=[4716A530:01C32F88]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"John Stoffel" <stoffel@lucent.com> wrote:
>
> 
> Here's an oops and hang from /var/log/messages that happened the other
> evening.  It kicked in at 4am or so.  This was running 2.5.70-mm3 SMP,
> PREEMPT, no ACPI, RAID1 on one pair of disks, not root or /boot.
> 
> Here's the messages I got in the messages file.  The system was
> completely hung and needed to be reset to recover:
> 
> Unable to handle kernel paging request at virtual
>  address 6b6b6b6b
>  printing eip:
> c0133477
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPTSMP DEBUG_PAGEALLOC
> CPU:    1
> EIP:    0060:[detach_pid+23/304]    Not tainted VLI
> EIP:    0060:[<c0133477>]    Not tainted VLI
> EFLAGS: 00010046
> EIP is at detach_pid+0x17/0x130
> eax: dfd30050   ebx: 6b6b6b6b   ecx: dfd30100   edx: 6b6b6b6b
> esi: e3cc6000   edi: 00000000   ebp: 00000000   esp: e3cc7f08
> ds: 007b   es: 007b   ss: 0068
> Process makewhatis (pid: 2446, threadinfo=e3cc6000 task=e4117000)
> Stack: dfd30000 e3cc6000 00000000 c0123a79 dfd30000 c0123bb3 dfd30000 dfd30000 
>        dfd305c4 dfd30000 00000a07 bffff5c8 c01258cd dfd30000 ea854a74 bffff350 
>        dfd300a4 dfd30000 e4117000 00000000 c0125075 dfd30000 bffff5c8 00000000 
> Call Trace:
>  [__unhash_process+57/176] __unhash_process+0x39/0xb0
>  [<c0123a79>] __unhash_process+0x39/0xb0
>  [release_task+195/560] release_task+0xc3/0x230
>  [<c0123bb3>] release_task+0xc3/0x230
>  [wait_task_zombie+397/432] wait_task_zombie+0x18d/0x1b0
>  [<c01258cd>] wait_task_zombie+0x18d/0x1b0
>  [sys_wait4+357/640] sys_wait4+0x165/0x280
>  [<c0125c75>] sys_wait4+0x165/0x280
>  [default_wake_function+0/32] default_wake_function+0x0/0x20
>  [<c011da40>] default_wake_function+0x0/0x20
>  [default_wake_function+0/32] default_wake_function+0x0/0x20
>  [<c011da40>] default_wake_function+0x0/0x20
>  [syscall_call+7/11] syscall_call+0x7/0xb
>  [<c010af1f>] syscall_call+0x7/0xb
> 
> Code: 51 08 52 e8 8c cd fe ff 58 5b c3 89 f6 8d bc 27 00 00 00 00 57 56 53 89 d3 8d 14 9b 8d 04 d0 8d 88 b0 00 00 00 8b 59 08 8b 51 04 <39> 0a 74 08 0f 0b 8c 00 c8 8f 3a c0 8b 80 b0 00 00 00 39 48 04 

This appears to be a visitation from the Great Unsolved Bug of the 2.5
series.  Someone playing with a freed task_struct.

Correct me if I'm wrong, but this has only ever been seen with
CONFIG_PREEMPT=y?
