Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268551AbTGLVeL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 17:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268552AbTGLVeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 17:34:11 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:60811 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S268551AbTGLVeJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 17:34:09 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sat, 12 Jul 2003 14:41:25 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Eric Varsanyi <e0206@foo21.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch][RFC] epoll and half closed TCP connections
In-Reply-To: <20030712211941.GD15643@srv.foo21.com>
Message-ID: <Pine.LNX.4.55.0307121436460.4720@bigblue.dev.mcafeelabs.com>
References: <20030712181654.GB15643@srv.foo21.com> <20030712194432.GE10450@mail.jlokier.co.uk>
 <20030712205114.GC15643@srv.foo21.com> <Pine.LNX.4.55.0307121346140.4720@bigblue.dev.mcafeelabs.com>
 <20030712211941.GD15643@srv.foo21.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jul 2003, Eric Varsanyi wrote:

> I guess my only argument would be that edge triggered mode isn't really
> workable with TCP connections if there's no way to solve the ambiguity
> between EOF and no data in buffer (at least w/o an extra syscall). I just
> realized that the race you mention in the man page (reading data from
> the 'next' event that hasn't been polled into user mode yet) will lead to
> the same issue: how do you know if you got this event because you consumed
> the data on the previous interrupt or if this is an EOF condition.

(Sorry, I missed this)
You can work that out very easily. When your read/write returns a lower
number of bytes, it means that it is time to stop processing this fd. If
events happened meanwhile, you will get them at the next epoll_wait(). If
not, the next time they'll happen. There's no blind spot if you follow
this simple rule, and you do not even have the extra syscall with EAGAIN.



- Davide

