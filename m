Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269664AbUICMtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269664AbUICMtX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 08:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269663AbUICMtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 08:49:23 -0400
Received: from pop.gmx.net ([213.165.64.20]:33721 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269664AbUICMtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 08:49:00 -0400
X-Authenticated: #4399952
Date: Fri, 3 Sep 2004 15:01:19 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, rlrevell@joe-job.com,
       felipe_alfaro@linuxmail.org
Subject: Re: lockup with voluntary preempt R0 and VP, KP, etc, disabled
Message-ID: <20040903150119.71e19576@mango.fruits.de>
In-Reply-To: <20040903115505.GB29493@elte.hu>
References: <20040903120957.00665413@mango.fruits.de>
	<20040903100946.GA22819@elte.hu>
	<20040903123139.565c806b@mango.fruits.de>
	<20040903103244.GB23726@elte.hu>
	<20040903135919.719db41d@mango.fruits.de>
	<20040903115505.GB29493@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12a (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sep 2004 13:55:05 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Florian Schmidt <mista.tapas@gmx.net> wrote:
> 
> > [<c0105e29>] do_signal+0x79/0x110
> > [<c01162a0>] default_wake_function+0x0/0x20
> >   c012fgd7   do_futex+0x47/0xa0
> >   c012fb20   sys_futex
> >   c0103f07   do_notify
> >   c01060e6   work_notifysig
> >
> > Code: 96 54 01 00 00 8e e0 8e e8 85 d2 74 11 c7 86 54 01 00 00 00 00
> > 00 00 89 d0 e8 bb e4 ff 8b 9e 5c 01 00 00 85 db 74 09 8b 45 0c <8b>
> > 40 20 48 78 08 8b 5d f8 8b 75 fc c9 c3 c7 86 56 01 00 00 00 
> > <6> note: scsynth exited with preempt count 1
> 
> it seems the first crash scrolled off and we dont really know what
> happened ... Could you apply the attached patch - it will shut the
> console off and freeze the box after printing the first oops.

Ok, i booted with a bigger vga console. btw: it seems with APIC and
nmi_watchdog, i actually need to quit my scsynth app to trigger the bug.
so maybe this is a different one than the one i saw befure _during_
scsynth running [and jackd of course].

Since this is lots of text i have again become lazy. It would be much
better if someone could reproduce this behaviour on a machine with
serial console. Or a digital camera would work, too, to make a
screenshot of the Ooops.

Anyways: the screen was divided by a -----cut here: --- line. Above
which i saw this trace:

Badness in __put_task_struct at kernel/fork.c:89
__put_task_struct
schedule
do_syslog
sub_preempt_couint
dnotify_parent
autoreceive_wake_function
kmsg_read
autoreceive_wake_funtion
kmsg_read
vfs_read
sys_read
syscall_call
-----cut here:----

then this:
Kernel Bug sat kernel/exit.c838
invalid operand 0000[#1]
PREEMPT
CPU:0
EIP: 0060:[<c011cb34>] not tainted VLI
eax: 0 ebx: 0 ecx: ef6d11b0 edx: 0 esi: 0 edi: e558f2f0  ebp: e55e3ea8
esp: e55e3e8c  ds:007b es:007b ss:0068
process scsynth (pid 2624), threadinfo=e55e2000 tak=e55f2f0

Stack [skipped]
Trace:
do_group_exit
get_singal_to_deliver
do_signal
default_wake_function
do_futex
sys_futex
do_notify_resume
work_notify_sig[nal??]

Hope i have got some useful info this time around.  It seems there was
another bug which scrolled off the screen. I used the patched kernel
though.. [i'm pretty sure at least]..

flo
