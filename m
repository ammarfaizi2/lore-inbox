Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbTDGR5L (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 13:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263576AbTDGR5L (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 13:57:11 -0400
Received: from palrel12.hp.com ([156.153.255.237]:56251 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S263573AbTDGR5K (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 13:57:10 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16017.48795.43569.182784@napali.hpl.hp.com>
Date: Mon, 7 Apr 2003 11:08:27 -0700
To: "Robert Williamson" <robbiew@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, aniruddha.marathe@wipro.com,
       linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: Re: Same syscall is defined to different numbers on 3 different archs(was
 Re: Makefile  issue)
In-Reply-To: <OFA555B9E6.223C91CB-ON85256D01.00582D99-86256D01.005A64CB@pok.ibm.com>
References: <p73vfxqxpz4.fsf@oldwotan.suse.de>
	<OFA555B9E6.223C91CB-ON85256D01.00582D99-86256D01.005A64CB@pok.ibm.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 7 Apr 2003 11:26:49 -0500, "Robert Williamson" <robbiew@us.ibm.com> said:

  Robert> Hmmm...so I guess the only viable solution for a single test
  Robert> to cover as many archs as possible, is to explicitly define
  Robert> the number for each arch.

  Robert> Here's how I would do it Aniruddha:
  Robert> ------------------------------------------
  Robert> #ifdef __i386__
  Robert> #define __NR_timer_create 259
  Robert> #endif

  Robert> #ifdef __x86_64__
  Robert> #define __NR_timer_create 222
  Robert> #endif

  Robert> #if defined(__ppc__) || defined(__ppc64__)
  Robert> #define __NR_timer_create 240
  Robert> #else /* Not defined on this architecture */

  Robert> #include "test.h"
  Robert> #include "usctest.h"

  Robert> int TST_TOTAL = 0;      /* Total number of testcases */

  Robert> int main()
  Robert> {
  Robert> tst_resm(TCONF,"This system call is not defined for this architecture.");
  Robert> tst_exit();
  Robert> /* NOT REACHED */
  Robert> return(0);
  Robert> }
  Robert> #endif /* Not defined on this architecture */

  Robert> <REST OF TEST HERE>
  Robert> ------------------------------------------

  Robert> Any comments???

Why use such ugly, platform-dependent code when syscall(3) will do it
just fine?  (AFAIK, there is no man-page for syscall(3), but the glibc
info manual documents it in detail.)

	--david
