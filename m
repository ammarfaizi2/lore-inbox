Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262519AbVAUVeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262519AbVAUVeU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 16:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbVAUVch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 16:32:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15260 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262517AbVAUVb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 16:31:56 -0500
Date: Fri, 21 Jan 2005 13:31:46 -0800
Message-Id: <200501212131.j0LLVkJ8013886@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
X-Fcc: ~/Mail/linus
Cc: Andrea Arcangeli <andrea@cpushare.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: seccomp for 2.6.11-rc1-bk8
In-Reply-To: Ingo Molnar's message of  Friday, 21 January 2005 13:55:58 +0100 <20050121125558.GA5596@elte.hu>
X-Zippy-Says: I have accepted Provolone into my life!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> maybe this could even be fit into existing ptrace semantics, without any
> need for PTRACE_ATTACH_JAIL. What we need is to catch the case where a
> ptraced child is running (i.e. the signal_wake_up() has already been
> done, and the parent is waiting for the child to stop again), and the
> ptrace parent is killed unexpectedly.  Would it be a correct fix to just
> unconditionally stop the child in this case (and leave it hanging in
> such a state)? Or to kill it right away?

That's the same as the case of the debugger dying or being killed by hand.
When gdb has a bug, people want to be able to kill it and get on with using
their program, not have their program always be killed too.

If you add this feature, it makes most sense IMHO to use PTRACE_SETOPTIONS
as the way to request it.  


Thanks,
Roland
