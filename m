Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318970AbSHSS14>; Mon, 19 Aug 2002 14:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318972AbSHSS14>; Mon, 19 Aug 2002 14:27:56 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:37693 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S318970AbSHSS1z>; Mon, 19 Aug 2002 14:27:55 -0400
Date: Mon, 19 Aug 2002 13:31:38 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) sys_exit(), threading, scalable-exit-2.5.31-A6
Message-ID: <61100000.1029781898@baldur.austin.ibm.com>
In-Reply-To: <Pine.LNX.4.44.0208192004110.30255-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0208192004110.30255-100000@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Monday, August 19, 2002 08:08:10 PM +0200 Ingo Molnar <mingo@elte.hu>
wrote:

> the problem is that the tracing task wants to do a wait4() on all traced
> children, and the only way to get that is to have the traced tasks in the
> child list. Eg. strace -f traces a random number of tasks, and after the
> PTRACE_CONTINUE call, the wait4 done by strace must be able to 'get
> events' from pretty much any of the traced tasks. So unless the ptrace
> interface is reworked in an incompatible way, i cannot see how this would
> work. wait4 could perhaps somehow search the whole tasklist, but that
> could be a pretty big pain even for something like strace.

It seems to me it would be worth adding list_heads in the task struct for
ptraced tasks and ptraced siblings if it gets rid of the reparenting.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

