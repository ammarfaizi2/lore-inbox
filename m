Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310348AbSCGOkr>; Thu, 7 Mar 2002 09:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310170AbSCGOkc>; Thu, 7 Mar 2002 09:40:32 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:10886 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S293729AbSCGOkO>;
	Thu, 7 Mar 2002 09:40:14 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Peter =?iso-8859-1?q?W=E4chtler?= <pwaechtler@loewe-komp.de>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: furwocks: Fast Userspace Read/Write Locks
Date: Thu, 7 Mar 2002 09:41:11 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
In-Reply-To: <E16iwkE-000216-00@wagner.rustcorp.com.au> <3C875FD1.4040904@loewe-komp.de>
In-Reply-To: <3C875FD1.4040904@loewe-komp.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020307144006.B9D213FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 March 2002 07:40 am, Peter Wächtler wrote:
> Rusty Russell wrote:
> > This is a userspace implementation of rwlocks on top of futexes.
>
> With the futex approach in mind: Does anybody think it's desirable to have
>
> pthread_cond_wait/signal and pthread_mutex_* with inter process scope build
> into the kernel as system call?
>

Yes, I talked with Bill Abt from IBM's NPthreads package about it in 
December. Huge value as it would provide full POSIX compliants.
There are differences whether you have a 1:1 threading model or
a M:N threading model.

Eitherway this could be implemented using futexes. 
M:N is surely more tricky. The problem is that the calling process/kernel 
thread can not be blocked but has to return to user level to continue another 
user level thread. What needs to happen is something like a signaling 
mechanism.


> The only issue I see so far, is that libpthread should get a "reserved"
> namespace entry ( /dev/shm/.linuxthreads-locks ?) to hold all the
> PTHREAD_PROCESS_SHARE locks/condvars.
>
> OTOH Irix seems to implement inter process locks as syscall, so that the
> kernel does all the bookkeeping. That approach denies a malicious program
> to trash all locks in the system...
>
> Hmh, then we could implement a per user /dev/shm/.linuxthreads-lock-<uid>
> with tight permissions?
>
> What do you think?

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
