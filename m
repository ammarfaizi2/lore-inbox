Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265560AbUBBCak (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 21:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265563AbUBBCak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 21:30:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:16545 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265560AbUBBCaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 21:30:39 -0500
Date: Sun, 1 Feb 2004 18:30:27 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Roland McGrath <roland@redhat.com>, Daniel Jacobowitz <dan@debian.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: More waitpid issues with CLONE_DETACHED/CLONE_THREAD
In-Reply-To: <20040202032023.A28264@pclin040.win.tue.nl>
Message-ID: <Pine.LNX.4.58.0402011824270.3405@home.osdl.org>
References: <200402012225.i11MPEN1009925@magilla.sf.frob.com>
 <Pine.LNX.4.58.0402011653230.2229@home.osdl.org> <20040202032023.A28264@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 2 Feb 2004, Andries Brouwer wrote:
> 
> So, I think what happens is that PTRACE_KILL immediately after the PTRACE_CONT
> works because there is no schedule in between, so the effect of PTRACE_KILL
> is still seen by the (grand)child.

Well, Duh! You'r eobviously right.

PTRACE_KILL is a special case, since it's supposed to work _regardless_ of 
whether the process being traced is actually stopped for tracing or not.

And Roland is correct that PTRACE_KILL works fine _if_ it is stopped. 

But for the case where it isn't (and Daniel's program isn't, since it did 
the PTRACE_CONT), PTRACE_KILL does nothing.

> Maybe there is no bug.

No, I do believe that PTRACE_KILL is supposed to kill the child even if it 
wasn't synchronized. See the special case for "ptrace_check_attach()", 
which allows a PTRACE_KILL to happen even for a nonsynchronized target.

		Linus
