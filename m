Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265536AbUBFREA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 12:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265530AbUBFREA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 12:04:00 -0500
Received: from chaos.analogic.com ([204.178.40.224]:46976 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265536AbUBFRD5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 12:03:57 -0500
Date: Fri, 6 Feb 2004 12:05:55 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Hefty, Sean" <sean.hefty@intel.com>
cc: Troy Benjegerdes <hozer@hozed.org>,
       infiniband-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: RE: [Infiniband-general] Getting an Infiniband access layer in
 theLinux kernel
In-Reply-To: <C1B7430B33A4B14F80D29B5126C5E9470326258C@orsmsx401.jf.intel.com>
Message-ID: <Pine.LNX.4.53.0402061150100.3862@chaos>
References: <C1B7430B33A4B14F80D29B5126C5E9470326258C@orsmsx401.jf.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Feb 2004, Hefty, Sean wrote:

> On Thu, Feb 5, 2004 at 05:11:00PM -0800, Troy Benjegerdes wrote:
> >On Thu, Feb 05, 2004 at 02:26:46PM -0800, Hefty, Sean wrote:
> >> Personally, I'm amazed that professional developers have to discuss
> or
> >> defend modular, portable code.
> >
> >You're new to linux-kernel, aren't you? ;)
>
> I was not trying to be condescending.  My point was that I think that
> everyone on this list knows the purpose and benefits behind an
> abstraction layer.  It's not something that needed to be discussed any
> further.
>
> I also understand that code in the Linux 2.6 kernel does not need
> certain abstractions.  And I agree that because we are targeting the 2.6
> kernel specifically, the existing code, some of which was developed 3-5
> years ago, should be updated based on what the 2.6 kernel provides.
>
> We want to continue to discuss specific details about what's needed to
> add the code into the kernel.  Here's a list of modifications that I
> think are needed so far:
>
> * Update the code to make direct calls for atomic operations.
> * Verify the use of spinlock calls.
> * Reformat the code for tab spacing and curly brace usage.
> * Elimination of typedefs.
>
> And, yes, knowing some of these issues up front will save the trouble of
> submitting code that will be immediately rejected.

If some major changes are being considered, I think it's time
to get rid of the:

do {  } while(0) stuff that permiates a lot of MACROS and just
use the { } as they were designed.

Before everybody screams, think. It's perfectly correct to
start a new "program unit" without a conditional expression.
You just add a curley-brace, then close the brace when you
are though.

For example (from linux/wait.h):

/*
 * Debugging macros.  We eschew `do { } while (0)' because gcc can generate
 * spurious .aligns.
 */
#if WAITQUEUE_DEBUG
#define WQ_BUG()	BUG()
#define CHECK_MAGIC(x)		\
 do {								\
		if ((x) != (long)&(x)) {			\
			printk("bad magic %lx (should be %lx), ",	\
				(long)x, (long)&(x));			\
			WQ_BUG();					\
		}							\
    } while (0)

Surely, this was some kind of work-around for some compiler bug
in a compiler you are not even allowed to use anymore for the
newer kernels.

All you need is the '{}' and none of the 'do' stuff. Since we
are still allowed to use old compilers in old kernels, I'm
nor suggesting that the headers in 2.4.xxx be changed, just the
new stuff, 2.6

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


