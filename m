Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263906AbTLCSUJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 13:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264144AbTLCSUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 13:20:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:38550 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263906AbTLCSUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 13:20:06 -0500
Date: Wed, 3 Dec 2003 10:19:37 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
cc: vatsa@in.ibm.com, Raj <raju@mailandnews.com>, linux-kernel@vger.kernel.org,
       lhcs-devel@lists.sourceforge.net
Subject: Re: kernel BUG at kernel/exit.c:792!
In-Reply-To: <3FCE217E.1080007@colorfullife.com>
Message-ID: <Pine.LNX.4.58.0312031015000.6950@home.osdl.org>
References: <20031203153858.C14999@in.ibm.com> <3FCDCEA3.1020209@mailandnews.com>
 <20031203182319.D14999@in.ibm.com> <3FCE217E.1080007@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Dec 2003, Manfred Spraul wrote:
>
> But I don't understand the oops:
> __exit_sighand clears current->sighand, and then in the next line
> __unhash_process removes the thread from the task list. But that's under
> write_lock_irq(&tasklist_lock), and get_tid_list runs under
> read_lock(&tasklist_lock). It should be impossible that ->sighand is
> NULL and the task is still listed in the task list.

The /proc filesystem will keep pointers to processes alive, and can reach
them even if the process is otherwise gone.

This is why /proc ends up doing tests like "if (tsk->mm)" etc - because it
literally can see processes after they are dead.

		Linus
