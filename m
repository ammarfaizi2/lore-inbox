Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263576AbTDGSFj (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 14:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263577AbTDGSFj (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 14:05:39 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:25262 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263576AbTDGSFf (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 14:05:35 -0400
In-Reply-To: <16017.48795.43569.182784@napali.hpl.hp.com>
Subject: Re: Same syscall is defined to different numbers on 3 different archs(was
 Re: Makefile  issue)
To: davidm@hpl.hp.com
Cc: Andi Kleen <ak@suse.de>, aniruddha.marathe@wipro.com,
       linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
X-Mailer: Lotus Notes Release 6.0 September 26, 2002
Message-ID: <OFE1A01154.21E41A43-ON85256D01.0063E065-86256D01.00646C2E@pok.ibm.com>
From: "Robert Williamson" <robbiew@us.ibm.com>
Date: Mon, 7 Apr 2003 13:16:21 -0500
X-MIMETrack: Serialize by Router on D01ML076/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 04/07/2003 02:16:46 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The original note had the testcases in question, which uses
_syscall3......but since this was left off I'll summarize.  The author did
use the following:

_syscall3 (int, timer_create, clockid_t, which_clock, struct sigevent *,
      timer_event_spec, timer_t *, timer_id);

but compilation failed with:

timer_delete01.c: In function `timer_create':
timer_delete01.c:86: `__NR_timer_create' undeclared (first use in this
function)

The only way we were able to resolve this was to either to add the kernel
includes to the include path: "-I /usr/src/linux-2.5.66/include".
Obviously, this option will not work for the LTP and our users who
frequently change kernel levels and install locations, we have to use "such
ugly, platform-dependent code"

- Robbie

Robert V. Williamson <robbiew@us.ibm.com>
Linux Test Project
IBM Linux Technology Center
Phone: (512) 838-9295   T/L: 678-9295
Fax: (512) 838-4603
Web: http://ltp.sourceforge.net
IRC: #ltp on freenode.irc.net
====================
"Only two things are infinite, the universe and human stupidity, and I'm
not sure about the former." -Albert Einstein


                                                                                                                                      
                      David Mosberger                                                                                                 
                      <davidm@napali.hp        To:       Robert Williamson/Austin/IBM@IBMUS                                           
                      l.hp.com>                cc:       Andi Kleen <ak@suse.de>, aniruddha.marathe@wipro.com,                        
                                                linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net                          
                      04/07/2003 01:08         Subject:  Re: Same syscall is defined to different numbers on 3 different archs(was    
                      PM                        Re: Makefile  issue)                                                                  
                      Please respond to                                                                                               
                      davidm                                                                                                          
                                                                                                                                      




>>>>> On Mon, 7 Apr 2003 11:26:49 -0500, "Robert Williamson"
<robbiew@us.ibm.com> said:

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
  Robert> tst_resm(TCONF,"This system call is not defined for this
architecture.");
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




