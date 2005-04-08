Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262950AbVDHUiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262950AbVDHUiZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 16:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262951AbVDHUiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 16:38:25 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:10488 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262950AbVDHUiX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 16:38:23 -0400
Subject: Re: 'BUG: scheduling with irqs disabled' when umounting NFS volume
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
In-Reply-To: <1112991311.11000.37.camel@mindpipe>
References: <1112991311.11000.37.camel@mindpipe>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1112992701.26296.16.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 08 Apr 2005 13:38:21 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I submitted a fix for this a while ago, I think ..
interruptible_sleep_on()'s are broken .. 


Daniel

On Fri, 2005-04-08 at 13:15, Lee Revell wrote:
> Kernel is 2.6.12-rc1-RT-V0.7.43-05.
> 
> BUG: scheduling with irqs disabled: umount/0x00000000/20612
> caller is schedule_timeout+0x63/0xc0
>  [<c01033d3>] dump_stack+0x23/0x30 (20)
>  [<c02b4f5a>] schedule+0xea/0x140 (36)
>  [<c02b5b23>] schedule_timeout+0x63/0xc0 (64)
>  [<c02b5744>] interruptible_sleep_on_timeout+0x74/0xe0 (64)
>  [<c01cf898>] lockd_down+0xb8/0x140 (24)
>  [<c01c2137>] nfs_kill_super+0x77/0x80 (16)
>  [<c016033c>] deactivate_super+0x8c/0xb0 (28)
>  [<c0178bc1>] sys_umount+0x41/0x90 (88)
>  [<c0178c2e>] sys_oldumount+0x1e/0x20 (16)
>  [<c0102dee>] syscall_call+0x7/0xb (-8124)
> ---------------------------
> | preempt count: 00000001 ]
> | 1-level deep critical section nesting:
> ----------------------------------------
> .. [<c01320ad>] .... print_traces+0x1d/0x60
> .....[<c01033d3>] ..   ( <= dump_stack+0x23/0x30)
> 
> Lee
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

