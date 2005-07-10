Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbVGJFlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVGJFlm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 01:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVGJFlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 01:41:42 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:53033 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261855AbVGJFll convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 01:41:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ii9YLw0PyCA0OIbHgGz9SvN7/T3FMyg+IwqClGzFTzfDPGYqGfKYjP/kRPw9Ma1BwXL7Se5NVtItgZQAFDyV2ru8S40ql58UsYTweezAD9IqiJB2ADSiGjfa2p/cTqdaVYSAAEpTsH6OD0u9lbYPYvEbTgc90Ge6F1/rz/JVieg=
Message-ID: <d73ab4d005070922413fb0dbba@mail.gmail.com>
Date: Sun, 10 Jul 2005 13:41:40 +0800
From: guorke <gourke@gmail.com>
Reply-To: guorke <gourke@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: I confused about diff(simple question)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

like:

 /*
@@ -220,9 +232,8(HERE: why not -220,9 +220,8) @@ fastcall notrace void
do_page_fault(stru
       struct vm_area_struct * vma;
       unsigned long address;
       unsigned long page;
-       int write;
-       siginfo_t info;
-
+       int write, si_code;
+
       /* get the address */
       __asm__("movl %%cr2,%0":"=r" (address));
       trace_special(regs->eip, error_code, address);
@@ -236,7 +247,7 (HERE: why not -236,7,+236,7) @@ fastcall notrace
void do_page_fault(stru

       tsk = current;

-       info.si_code = SEGV_MAPERR;
+       si_code = SEGV_MAPERR;

       /*
        * We fault-in kernel-space virtual memory on-demand. The
@@ -316,7 +327,7 (HERE -316,7, +316,7) @@ fastcall notrace void
do_page_fault(stru
 * we can handle it..
 */
 good_area:
-       info.si_code = SEGV_ACCERR;
+       si_code = SEGV_ACCERR;
       write = 0;
       switch (error_code & 3) {
               default:        /* 3: write, present */
@@ -390,11 +401,7 (HERE:why not -390,11,+390,11) @@ bad_area_nosemaphore:
               /* Kernel addresses are always protection faults */
               tsk->thread.error_code = error_code | (address >= TASK_SIZE);
               tsk->thread.trap_no = 14;
-               info.si_signo = SIGSEGV;
-               info.si_errno = 0;
-               /* info.si_code has been set above */
-               info.si_addr = (void __user *)address;
-               force_sig_info(SIGSEGV, &info, tsk);
+               force_sig_info_fault(SIGSEGV, si_code, address, tsk);
               return;
       }

@@ -500,11 +507,7(HERE: why not -500,11,+500,7) @@ do_sigbus:
       tsk->thread.cr2 = address;
       tsk->thread.error_code = error_code;
       tsk->thread.trap_no = 14;
-       info.si_signo = SIGBUS;
-       info.si_errno = 0;
-       info.si_code = BUS_ADRERR;
-       info.si_addr = (void __user *)address;
-       force_sig_info(SIGBUS, &info, tsk);
+       force_sig_info_fault(SIGBUS, BUS_ADRERR, address, tsk);
       return;

...

in :-220,9 +232,8
 I think the old file from the line 220,and have 9 lines,then the
newfile have 8 lines
so must delete one line. but why +232,it from the line 232 ?
like this..

maybe it's very very simple.but i really confused it.wishes helps,

Thanks

--------
guorke
