Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263162AbSJBQuK>; Wed, 2 Oct 2002 12:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263166AbSJBQuK>; Wed, 2 Oct 2002 12:50:10 -0400
Received: from packet.digeo.com ([12.110.80.53]:7817 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263162AbSJBQuJ>;
	Wed, 2 Oct 2002 12:50:09 -0400
Message-ID: <3D9B2503.7A186D7F@digeo.com>
Date: Wed, 02 Oct 2002 09:55:31 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Sigh, any ideas for a "dump_stack" name?
References: <20021002105933.A24770@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Oct 2002 16:55:32.0181 (UTC) FILETIME=[84FCF850:01C26A34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> Ok,
> 
> Still not got 2.5.40 to build...
> 
> ARM has, since the year dot, used "dump_stack()" to display any threads
> stack, and has the following prototype:
> 
> static void dump_stack(struct task_struct *tsk, unsigned long sp)
> 
> However, somewhere in the 2.5.34 -> 2.5.40 development, "dump_stack" got
> used as a way to call "show_stack" with a value of zero on x86 (which is
> another externally visible function.)
> 
> Firstly, "dump_stack" is misnamed.  It dumps stack and call trace
> information.

Sorry about that chief.   Daniel very sensibly suggested that the
new one should be called `backtrace();'

> Secondly, it creates a small problem - we're running out of names
> to describe a function that displays _just_ stack contents without
> any call trace information.
> 
> So, I propose to change the ARM version to the following, unless someone
> else can come up with another name or a fix the poliferation of stack-
> displaying functions that the generic kernel seems to require.

The generic kernel should only require two of these functions:
dump_stack() (aka backtrace()) and show_task_trace() - which
traces a different thread.
