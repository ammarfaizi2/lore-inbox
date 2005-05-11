Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbVEKI5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbVEKI5c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 04:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbVEKI5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 04:57:22 -0400
Received: from palrel11.hp.com ([156.153.255.246]:35762 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261943AbVEKIzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 04:55:25 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17025.51314.585943.931944@napali.hpl.hp.com>
Date: Wed, 11 May 2005 01:55:14 -0700
To: Roland McGrath <roland@redhat.com>
Cc: davidm@hpl.hp.com, akpm@osdl.org, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] add arch_ptrace_stop() hook and use it on ia64
In-Reply-To: <200505110059.j4B0xkkM003452@magilla.sf.frob.com>
References: <17025.6719.837031.411067@napali.hpl.hp.com>
	<200505110059.j4B0xkkM003452@magilla.sf.frob.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 10 May 2005 17:59:46 -0700, Roland McGrath <roland@redhat.com> said:

  Roland> (This leads to threads in TASK_TRACED with a pending
  Roland> SIGKILL, that cannot be killed with repeated kill -9s, and
  Roland> live until the tracer uses PTRACE_CONT, detaches, or dies.)

Ah, yes, I see now that SIGKILL is a rather nasty special-case.

  Roland> When I suggested this change for ia64 originally, I
  Roland> overlooked the need to handle blocking in writing to user
  Roland> memory.  I'd like to give a little more thought to the
  Roland> general case.  As long as only uninterruptible waits are
  Roland> provoked by an arch hook, then I think it is reasonably
  Roland> solvable.  I think that SIGKILL races are the only ones that
  Roland> can arise, and those can be addressed with some signal
  Roland> bookkeeping changes.  I'd like to give it a little more
  Roland> thought.  I expect it will wind up being some core changes
  Roland> that make it safe for an arch hook to drop and reacquire the
  Roland> siglock if it's doing something that won't always complete
  Roland> quickly, and then this will all happen before changing
  Roland> state, unlocking, and deciding to block (which won't be done
  Roland> if there was an intervening SIGKILL).

OK, that sounds good to me.  Please keep me posted.  It would be nice
to have this hook in place, since it does fix a bug on ia64 and makes
the code simpler.

Thanks,

	--david

