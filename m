Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266517AbUHaE2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266517AbUHaE2M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 00:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266519AbUHaE2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 00:28:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:51098 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266517AbUHaE2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 00:28:09 -0400
Date: Mon, 30 Aug 2004 21:27:54 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland McGrath <roland@redhat.com>
cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cleanup ptrace stops and remove notify_parent
In-Reply-To: <200408310411.i7V4B8Vs027772@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0408302119110.2295@ppc970.osdl.org>
References: <200408310411.i7V4B8Vs027772@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 30 Aug 2004, Roland McGrath wrote:
> 
> This adds a new state TASK_TRACED that is used in place of TASK_STOPPED
> when a thread stops because it is ptraced.  Now ptrace operations are only
> permitted when the target is in TASK_TRACED state, not in TASK_STOPPED.
> This means that if a process is stopped normally by a job control signal
> and then you PTRACE_ATTACH to it, you will have to send it a SIGCONT before
> you can do any ptrace operations on it.  (The SIGCONT will be reported to
> ptrace and then you can discard it instead of passing it through when you
> call PTRACE_CONT et al.)

Ok, I definitely agree with the approach (I've not become schizofrenic
yet, but as others can attest, I obviously change my mind occasionally, so 
sometimes I disagree even with my own suggestions ;)

Looks pretty clean as an implementation. The question is whether we should 
aim for 2.6.9 or 2.6.10 - if the first, then I should probably take it 
now, otherwise it should go into -mm first and be merged early after 2.6.9 
has been released, for the first -rc.

I _looks_ pretty safe, and it's hopefully much less likely to have subtle
bugs and races than our old approach had, but I have a hard time judging. 
I assume you ran all your gdb tests on the result? What's your gut feel?

		Linus
