Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265670AbTAJRJO>; Fri, 10 Jan 2003 12:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265675AbTAJRJO>; Fri, 10 Jan 2003 12:09:14 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47376 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265670AbTAJRJM>; Fri, 10 Jan 2003 12:09:12 -0500
Date: Fri, 10 Jan 2003 09:11:23 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Gabriel Paubert <paubert@iram.es>
cc: Ingo Molnar <mingo@elte.hu>, Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Ulrich Drepper <drepper@redhat.com>, <davej@codemonkey.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <Pine.LNX.4.33.0301101202020.1743-100000@gra-lx1.iram.es>
Message-ID: <Pine.LNX.4.44.0301100909100.12833-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Jan 2003, Gabriel Paubert wrote:
> 
> We cannot rely either on userspace not setting NT bit in eflags. While
> it won't cause an oops since the only instruction which ever depends on
> it, iret, has a handler (which needs to be patched, see below),
> I'm absolutely not convinced that all code paths are "NT safe" ;-)

It shouldn't matter.

NT is only tested by "iret", and if somebody sets NT in user space they 
get exactly what they deserve. 

> For example, set NT and then execute sysenter with garbage in %eax, the
> kernel will try to return (-ENOSYS) with iret and kill the task. As long
> as it only allows a task to kill itself, it's not a big deal. But NT is
> not cleared across task switches unless I miss something, and that looks
> very dangerous.

It _is_ cleared by task-switching these days. Or rather, it's saved and 
restored, so the original NT setter will get it restored when resumed. 

> I'm no Ingo, unfortunately, but you'll need at least the following patch
> (the second hunk is only a typo fix) to the iret exception recovery code,
> which used push and pops to get the smallest possible code size.

Good job. 

		Linus

