Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbTDGSiV (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 14:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTDGSiV (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 14:38:21 -0400
Received: from palrel13.hp.com ([156.153.255.238]:12993 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263587AbTDGSiS (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 14:38:18 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16017.51280.497389.142672@napali.hpl.hp.com>
Date: Mon, 7 Apr 2003 11:49:52 -0700
To: "Robert Williamson" <robbiew@us.ibm.com>
Cc: davidm@hpl.hp.com, Andi Kleen <ak@suse.de>, aniruddha.marathe@wipro.com,
       linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: Re: Same syscall is defined to different numbers on 3 different archs(was
 Re: Makefile  issue)
In-Reply-To: <OFE1A01154.21E41A43-ON85256D01.0063E065-86256D01.00646C2E@pok.ibm.com>
References: <16017.48795.43569.182784@napali.hpl.hp.com>
	<OFE1A01154.21E41A43-ON85256D01.0063E065-86256D01.00646C2E@pok.ibm.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 7 Apr 2003 13:16:21 -0500, "Robert Williamson" <robbiew@us.ibm.com> said:

  Robert> The original note had the testcases in question, which uses
  Robert> _syscall3......but since this was left off I'll summarize.
  Robert> The author did use the following:

  Robert> _syscall3 (int, timer_create, clockid_t, which_clock, struct sigevent *,
  Robert> timer_event_spec, timer_t *, timer_id);

  Robert> but compilation failed with:

  Robert> timer_delete01.c: In function `timer_create':
  Robert> timer_delete01.c:86: `__NR_timer_create' undeclared (first use in this
  Robert> function)

  Robert> The only way we were able to resolve this was to either to
  Robert> add the kernel includes to the include path: "-I
  Robert> /usr/src/linux-2.5.66/include".  Obviously, this option will
  Robert> not work for the LTP and our users who frequently change
  Robert> kernel levels and install locations, we have to use "such
  Robert> ugly, platform-dependent code"

But you still can use syscall() instead of the non-portable syscallN()
macros.  Also, it should go something like this:

#include <sys/syscall.h>

#ifndef SYS_timer_create
# if defined(__i386)
#  define SYS_timer_create	259
# elif defined(...)
   ...
# endif
#endif

	--david
