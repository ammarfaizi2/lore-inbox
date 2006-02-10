Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWBJHzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWBJHzp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 02:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWBJHzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 02:55:45 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:20455 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751181AbWBJHzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 02:55:44 -0500
Date: Fri, 10 Feb 2006 02:55:34 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: omkar lagu <omkarlagu@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: How to call a function in a module from the kernel code !!!
 (Linux kernel)
In-Reply-To: <383FCBAC-AB8E-4DFA-8716-D7BBF6409FDA@mac.com>
Message-ID: <Pine.LNX.4.58.0602100244110.20605@gandalf.stny.rr.com>
References: <20060209192510.32377.qmail@web50307.mail.yahoo.com>
 <383FCBAC-AB8E-4DFA-8716-D7BBF6409FDA@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 9 Feb 2006, Kyle Moffett wrote:

> It would help a lot if you could post a link to your source code.

Not really.  The question is pretty straight forward, so no source is
really necessary.  Are you just asking this because you want to stress the
next point.

> Let me point out (in case you don't know this already) that if you do
> what you describe and distribute the result, you are automatically
> licensing your ll.c file under the GPLv2.  By distributing a
> derivative of both the Linux kernel and your proprietary module (You
> are taking Linux kernel sources and modifying them explicitly for
> your module), the result must be GPL.

Well, just because something is under the GPL, doesn't mean you need to
post a link for all to have.  You only need to give the source to those
that you distribute it to.  For example, if you give GPL code to someone
that paid a hell of a lot to get it (the distribution, not paying for the
code) then those that have paid might not want to give it away either. So
yes, you can have closed GPL if all that get the binary and code don't
distribute it to anyone else.  Of course once one that has it does give it
away (since no one can prevent them from doing so) then the code will be
opened.

>  Also, I think what you are
> describing is basically impossible.  I believe what you want to do is
> this:
>
> /* in shm.c */
> unsigned long long (*ptr1)(int);
> EXPORT_SYMBOL(ptr1);
>
> However this makes it impossible to reliably remove your module,
> because a process could race entering the function as the module
> loader is trying to remove the module.

Not really impossible.  As I have done in my (yes GPL) logdev module
http://www.kihontech.com/logdev/logdev-2.6.15-rt16.patch
I have a "hooks" file that has all the functions I need for the loadable
module.  But to call any of the hooks, you must call wrapper functions
that grabs a spinlock before calling the function.  This spinlock is also
used to reset the function pointer when removing the module.  Yes, I know
that this is inefficient, but when the module is compiled into the kernel,
those wrapper functions also turn into direct functions without the need
of the spinlock, or redirected function pointers.

-- Steve
