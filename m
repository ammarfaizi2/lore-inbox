Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266305AbUGAV7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266305AbUGAV7Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 17:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266311AbUGAV7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 17:59:25 -0400
Received: from mail2.speakeasy.net ([216.254.0.202]:23782 "EHLO
	mail2.speakeasy.net") by vger.kernel.org with ESMTP id S266305AbUGAV7X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 17:59:23 -0400
Date: Thu, 1 Jul 2004 14:59:20 -0700
Message-Id: <200407012159.i61LxKBw022917@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Daniel Jacobowitz <dan@debian.org>
X-Fcc: ~/Mail/linus
Cc: Davide Libenzi <davidel@xmailserver.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, mingo@redhat.com, cagney@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86 single-step (TF) vs system calls & traps
In-Reply-To: Daniel Jacobowitz's message of  Thursday, 1 July 2004 16:34:56 -0400 <20040701203455.GA22888@nevyn.them.org>
Emacs: or perhaps you'd prefer Russian Roulette, after all?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am not the originator of PTRACE_O_TRACESYSGOOD, I just had the bad
> luck to touch it.

My apologies.

> I think reporting the system call using 0x80|SIGTRAP when you
> PTRACE_SINGLESTEP over the trap instruction makes excellent good sense.

If you are not concerned about existing users of PTRACE_O_TRACESYSGOOD
calling PTRACE_SINGLESTEP and then being confused, then I have no objection.
I consider you to be the authority on any such users there might be.

In that case, I'm happy to endorse Davide's original patch.
I will look into extending it to cover x86-64's ia32 support as well.

I still wonder if anyone has any insight into why this issue does not arise
for native x86-64's syscall/sysret.  From my reading of the AMD64 manual, I
would expect it to happen there as well.  That is, sysret is the instruction
that sets TF, and the manual says that the instruction after the one that
sets TF gets executed before the trap.  It would be convenient if sysret
were a special case for this rule, since it makes it do what is best for the
system call case.  But I haven't found a mention of that in the manual.



Thanks,
Roland
