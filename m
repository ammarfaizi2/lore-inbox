Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262196AbTC1ErH>; Thu, 27 Mar 2003 23:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262197AbTC1ErH>; Thu, 27 Mar 2003 23:47:07 -0500
Received: from [12.47.58.223] ([12.47.58.223]:53018 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id <S262196AbTC1ErG>; Thu, 27 Mar 2003 23:47:06 -0500
Date: Thu, 27 Mar 2003 20:59:12 -0800
From: Andrew Morton <akpm@digeo.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.5.66-mm1
Message-Id: <20030327205912.753c6d53.akpm@digeo.com>
In-Reply-To: <200303272106.05623.tomlins@cam.org>
References: <20030326013839.0c470ebb.akpm@digeo.com>
	<200303272106.05623.tomlins@cam.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Mar 2003 04:58:14.0323 (UTC) FILETIME=[A38AC030:01C2F4E6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson <tomlins@cam.org> wrote:
>
> Hi Andrew,
> 
> Got this opps after about 20 hours with mm1 (65-mm3 lasted 5 days
> until I rebooted).
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>  printing eip:
> c011516d
> *pde = 00000000
> Oops: 0002 [#1]
> CPU:    0
> EIP:    0060:[<c011516d>]    Not tainted VLI
> EFLAGS: 00010097
> EIP is at schedule+0x8d/0x3a0
> eax: 00000001   ebx: cf5e99c0   ecx: cf5e99c0   edx: ffffffff
> esi: 00000000   edi: c031de00   ebp: cf5ebf08   esp: cf5ebef0
> ds: 007b   es: 007b   ss: 0068
> Process newsplex (pid: 1205, threadinfo=cf5ea000 task=cf5e99c0)
> Stack: c011fbd7 c02bbc40 00000246 05261e41 cf5ebf14 cf5ebf50 cf5ebf3c c0120754 
>        cf5ebf14 c02bc538 c02bc538 05261e41 4b87ad6e c01206e0 cf5e99c0 c02bbc40 
>        c015abd6 000007d1 00000000 cf5ebf60 c015ac19 cf5ea000 cf5ea000 00000000 
> Call Trace:
>  [<c011fbd7>] add_timer+0x57/0xa0
>  [<c0120754>] schedule_timeout+0x54/0xa0
>  [<c01206e0>] process_timeout+0x0/0x20
>  [<c015abd6>] do_poll+0x56/0xc0
>  [<c015ac19>] do_poll+0x99/0xc0
>  [<c015ad88>] sys_poll+0x148/0x220
>  [<c013eb3b>] sys_mprotect+0x21b/0x22f
>  [<c01079ec>] sys_clone+0x2c/0x60
>  [<c015a200>] __pollwait+0x0/0xc0
>  [<c0109277>] syscall_call+0x7/0xb
> 
> Code: 40 17 04 75 4d 8b 03 85 c0 74 47 48 0f 84 da 02 00 00 ff 0d 00 de 31 c0 8b 43 68 ff 08 8b 03 83 f8 02 0f 84 b6 02 00 00 8b 73 28 <ff> 4e 00 8b 53 24 8b 43 20 89 50 04 89 02 8b 4b 18 8d 14 ce 8d 

That longer Code: line is really handy.

You died in schedule()->deactivate_task()->dequeue_task().

static inline void dequeue_task(struct task_struct *p, prio_array_t *array)
{
	array->nr_active--;

`array' is zero.

I'm going to Cc Ingo and run away.  Ed uses preempt.
	
