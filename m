Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263839AbTDDQlp (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 11:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263834AbTDDQk6 (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 11:40:58 -0500
Received: from siaag2ab.compuserve.com ([149.174.40.132]:55446 "EHLO
	siaag2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263836AbTDDQhU (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 11:37:20 -0500
Date: Fri, 4 Apr 2003 11:46:02 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [BUG?][2.5.66] was: Re: How to fix the ptrace flaw without
  rebooting
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304041148_MC3-1-32FC-A9A9@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:

.>>    # echo 'x'>/proc/sys/kernel/modprobe
.>>    bash: /proc/sys/kernel/modprobe: No such file or directory

.>Thats not a sufficient fix except for people blindly running the
.>example exploit

I know that -- it's why I wrote pt_fix after seeing the problems
people were having coming up with a stopgap.

BTW putting a "ud2a" instruction at the
entry point to sys_ptrace causes problems on SMP 2.5.66.
On uniprocessor, all attempts to use strace fail with SIGSEGV as
expected, but on SMP only the first time does.  Further
attempts to use strace result in a zombie strace child process hung
up at the end of do_exit() (hand copied from sysrq-t):

        do_exit+0x2f7/0x310
        die+0x7f/0x90
        do_invalid_op+0x0/0xa0
        do_invalid_op+0x87/0xa0
        sys_ptrace+0x0/0x6c0
        do_page_fault+0x120/0x426
        error_code+0x2d/0x38
        sys_ptrace+0x0/0x6c0
        syscall_call+0x7/0xb

2.4.21pre6 handles this OK.

--
 Chuck
