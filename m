Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273463AbRI3M7u>; Sun, 30 Sep 2001 08:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273467AbRI3M7k>; Sun, 30 Sep 2001 08:59:40 -0400
Received: from staff.cs.usyd.edu.au ([129.78.8.1]:52182 "helo
	staff.cs.usyd.edu.au") by vger.kernel.org with SMTP
	id <S273463AbRI3M72>; Sun, 30 Sep 2001 08:59:28 -0400
Date: Sun, 30 Sep 2001 22:47:06 +1100
From: bruce@cs.usyd.edu.au (Bruce Janson)
Subject: the fault address of a traced process
To: linux-kernel@vger.kernel.org
Message-Id: <20010930125931Z273463-760+18683@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One process traces another.
When the traced process tries to read, write or execute an unmapped
address it is stopped with a SIGSEGV signal.
The tracer now wants to determine the traced process' faulted address.
According to the (2.2.19) kernel source

  .../arch/i386/mm/fault.c:do_page_fault()

such a fault in user mode causes the offending address and error code to
be saved in

  tsk->tss.cr2

and

  tsk->tss.error_code

respectively.  There do not appear to be ptrace() or /proc hooks
to extract this data directly.  In earlier unices extraction of this
data would have required grubbing around in /dev/kmem using the
kernel namelist as a guide.
How should a tracer extract this information under a current
(2.2.*, 2.4.*) Linux?
