Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310304AbSCGMli>; Thu, 7 Mar 2002 07:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310303AbSCGMl2>; Thu, 7 Mar 2002 07:41:28 -0500
Received: from mail.loewe-komp.de ([62.156.155.230]:50952 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S310300AbSCGMlX>; Thu, 7 Mar 2002 07:41:23 -0500
Message-ID: <3C875FD1.4040904@loewe-komp.de>
Date: Thu, 07 Mar 2002 13:40:49 +0100
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010923
X-Accept-Language: de, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel@vger.kernel.org, Hubertus Franke <frankeh@watson.ibm.com>,
        lse-tech@lists.sourceforge.net
Subject: Re: furwocks: Fast Userspace Read/Write Locks
In-Reply-To: <E16iwkE-000216-00@wagner.rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:

> This is a userspace implementation of rwlocks on top of futexes.
> 

With the futex approach in mind: Does anybody think it's desirable to have

pthread_cond_wait/signal and pthread_mutex_* with inter process scope build
into the kernel as system call?

The only issue I see so far, is that libpthread should get a "reserved" namespace
entry ( /dev/shm/.linuxthreads-locks ?) to hold all the PTHREAD_PROCESS_SHARE
locks/condvars.

OTOH Irix seems to implement inter process locks as syscall, so that the kernel does
all the bookkeeping. That approach denies a malicious program to trash all locks
in the system...

Hmh, then we could implement a per user /dev/shm/.linuxthreads-lock-<uid> with
tight permissions?

What do you think?

