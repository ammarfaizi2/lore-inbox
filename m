Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbTKMAdq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 19:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbTKMAdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 19:33:46 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:40612 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261817AbTKMAdo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 19:33:44 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 12 Nov 2003 16:32:55 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: bill davidsen <davidsen@tmr.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: So, Poll is not scalable... what to do?
In-Reply-To: <boufjm$k9v$1@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0311121548470.2017-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Nov 2003, bill davidsen wrote:

> In article <20031112053207.GA9634@alpha.home.local>,
> Willy Tarreau  <willy@w.ods.org> wrote:
> | On Tue, Nov 11, 2003 at 05:52:42PM -0600, kirk bae wrote:
> | > If poll is not scalable, which method should I use when writing 
> | > multithreaded socket server?
> | 
> | Honnestly, if you're using threads (I mean lots of threads, such as one
> | per connection), I don't think that poll performance will be your worst
> | ennemy. The first thing to do is to handle the task switching yourself
> | either with a publicly available coroutine library or with one of your own.
> 
> It's not clear that with 2.6 this is necessary or desirable. I'll let
> someone who worked on the new thread and/or futex development say more
> if they will, but I'm reasonable convinced that in most cases the kernel
> will do it better.

Pros & Cons:

*) Coroutines cost is basically its stack (8-16Kb). Threads there's a 
little bit more under the hood

*) No locks at all with coroutines

*) Coroutine context switch time was about 20 times faster last time I 
tried. I used this:

http://www.xmailserver.org/libpcl.html

against O(1)

*) Coroutines require a more careful coding then threads, expecially 
stackwise

*) Achieving SMP scalability/balancing with coroutines is not trivial 
while with threads it comes along (well, almost)


Coroutines are not the only alternative though. I/O driven state machines 
can make you save some stack space at expenses of less trivial coding.



- Davide





