Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbTEYL0b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 07:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbTEYL0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 07:26:31 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:57729
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S261869AbTEYL03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 07:26:29 -0400
Date: Sun, 25 May 2003 07:29:25 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Manfred Spraul <manfred@colorfullife.com>
cc: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [RFC][PATCH][2.5] Possible race in wait_task_zombie and
 finish_task_switch
In-Reply-To: <3ED0A7CF.9040803@colorfullife.com>
Message-ID: <Pine.LNX.4.50.0305250720440.19617-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0305251226170.25774-100000@localhost.localdomain>
 <Pine.LNX.4.50.0305250625050.19617-100000@montezuma.mastecende.com>
 <3ED0A248.10308@kolumbus.fi> <3ED0A7CF.9040803@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 May 2003, Manfred Spraul wrote:

> - the reference for the stack itself, acquired by setting usage to 2, 
> dropped by schedule_tail.
> - the reference for wait4, acquired by setting usage to 2, dropped by 
> wait_task_zombie.
> - references for the pid structures, maintained by pid.c
> - temporary references for looking at tsk->{fs,mm,files,tty}, used by 
> /proc, ptrace, tty.

it's the one dropped by wait_task_zombie, the task coming out from 
schedule_tail is fine.

> 
> >kernel BUG at kernel/sched.c:746!
> >  
> >
> Hmm. What is schedule.c:746? There is no BUG in that area in the bk tree.

It's in finish_arch_switch at the put_task_struct()

> Zwane, is it easy to reproduce the crash? I could write a patch that 
> adds 4 refcounters, then we could find out in which area we must look.

I haven't found a direct way of triggering it, so far it's just been 
cropping up ~6 times over a period of 2days with the box normally taking a 
fatal one and dying completely.

	Zwane
-- 
function.linuxpower.ca
