Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265197AbSKRXMk>; Mon, 18 Nov 2002 18:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265201AbSKRXMk>; Mon, 18 Nov 2002 18:12:40 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:24969 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265197AbSKRXMf>; Mon, 18 Nov 2002 18:12:35 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 18 Nov 2002 15:20:01 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Andrew Morton <akpm@digeo.com>
cc: Dave Hansen <haveblue@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Robert Love <rml@tech9.net>,
       <riel@surriel.com>
Subject: Re: unusual scheduling performance
In-Reply-To: <3DD97336.40326A65@digeo.com>
Message-ID: <Pine.LNX.4.44.0211181514010.979-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Andrew Morton wrote:

> Dave Hansen wrote:
> >
> > As Andrew suggested, I put a dump_stack() in rwsem_down_write_failed().
> >
> > This was actually in a 2.5.47 bk snapshot, so it has eventpoll in it.
>
> So printk("hey!\n") would have worked.  Looks like it would have
> talked to you, too...
>
> > kksymoops is broken, so:
> > dmesg | tail -20 | sort | uniq | ksymoops -m /boot/System.map
> >
> > Trace; c01c5757 <rwsem_down_write_failed+27/170>
> > Trace; c01220c6 <update_wall_time+16/50>
> > Trace; c01223ee <do_timer+2e/c0>
> > Trace; c0166bd3 <.text.lock.eventpoll+6/f3>
> > Trace; c0146568 <__fput+18/c0>
> > Trace; c010ae9a <handle_IRQ_event+2a/60>
> > Trace; c0144a05 <filp_close+85/b0>
> > Trace; c0144a8d <sys_close+5d/70>
> > Trace; c0108fab <syscall_call+7/b>
> >
>
> So it would appear that eventpoll_release() is the problem.
> How odd.  You're not actually _using_ epoll there, are you?

Could you pls use 2.5.48 ...
This is wierd, the code is straight forward.



- Davide


