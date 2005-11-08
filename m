Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030276AbVKHU5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbVKHU5h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 15:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030345AbVKHU5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 15:57:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60375 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030276AbVKHU5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 15:57:36 -0500
Date: Tue, 8 Nov 2005 12:55:55 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Wright <chrisw@osdl.org>
cc: Oleg Nesterov <oleg@tv-sign.ru>, paulmck@us.ibm.com,
       Roland McGrath <roland@redhat.com>, George Anzinger <george@mvista.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       mingo@elte.hu, suzannew@cs.pdx.edu
Subject: Re: [PATCH] fix de_thread() vs send_group_sigqueue() race
In-Reply-To: <20051108203621.GS5856@shell0.pdx.osdl.net>
Message-ID: <Pine.LNX.4.64.0511081255210.3247@g5.osdl.org>
References: <20051105013650.GA17461@us.ibm.com> <436CDEAF.E236BC40@tv-sign.ru>
 <20051106010004.GB20178@us.ibm.com> <436E1401.920A83EE@tv-sign.ru>
 <436F991B.97AFC4C5@tv-sign.ru> <20051108203621.GS5856@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 8 Nov 2005, Chris Wright wrote:

> * Oleg Nesterov (oleg@tv-sign.ru) wrote:
> > When non-leader thread does exec, de_thread calls release_task(leader) before
> > calling exit_itimers(). If local timer interrupt happens in between, it can
> > oops in send_group_sigqueue() while taking ->sighand->siglock == NULL.
> > 
> > However, we can't change send_group_sigqueue() to check p->signal != NULL,
> > because sys_timer_create() does get_task_struct() only in SIGEV_THREAD_ID
> > case. So it is possible that this task_struct was already freed and we can't
> > trust p->signal.
> > 
> > This patch changes de_thread() so that leader released after exit_itimers()
> > call.
> 
> Nice catch.  As soon as Linus picks it up we'll put it in -stable as
> well.

Gaah. For some reason I was pretty much the only one not cc'd on the 
original patch ;)

Found it on linux-kernel.

		Linus
