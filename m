Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbTLCUz4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 15:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbTLCUz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 15:55:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:63116 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261276AbTLCUzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 15:55:52 -0500
Date: Wed, 3 Dec 2003 12:55:23 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Manfred Spraul <manfred@colorfullife.com>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>, Raj <raju@mailandnews.com>,
       linux-kernel@vger.kernel.org, lhcs-devel@lists.sourceforge.net
Subject: Re: kernel BUG at kernel/exit.c:792!
In-Reply-To: <Pine.LNX.4.58.0312032122420.6622@earth>
Message-ID: <Pine.LNX.4.58.0312031254590.2055@home.osdl.org>
References: <20031203153858.C14999@in.ibm.com> <3FCDCEA3.1020209@mailandnews.com>
 <20031203182319.D14999@in.ibm.com> <Pine.LNX.4.58.0312032059040.4438@earth>
 <Pine.LNX.4.58.0312031203430.7406@home.osdl.org> <3FCE453D.9080701@colorfullife.com>
 <Pine.LNX.4.58.0312032122420.6622@earth>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Dec 2003, Ingo Molnar wrote:
>
> On Wed, 3 Dec 2003, Manfred Spraul wrote:
>
> > It's wrong, because next_thread() relies on
> >
> >     task->pids[PIDTYPE_TGID].pid_chain.next
> >
> > That pointer is not valid after detach_pid(task, PIDTYPE_TGID), and
> > that's called within __unhash_process.  Thus next_thread() fails if it's
> > called on a dead task. Srivatsa's second patch is the right change: If
> > pid_alive() is wrong, then break from the loop without calling
> > next_thread().
>
> yes. And for thread groups this can only happen for the thread group
> leader if all 'child' threads have exited.

Ok, color me convinced. Will apply,

		Linus
