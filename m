Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S.rDDWK160511>; Sat, 15 May 1999 00:31:18 -0400
Received: by vger.rutgers.edu id <S.rD641160883>; Fri, 14 May 1999 16:03:15 -0400
Received: from hqinbh1.ms.com ([205.228.12.71]:49310 "EHLO hqinbh1.ms.com") by vger.rutgers.edu with ESMTP id <S.rD0bv284257>; Fri, 14 May 1999 09:49:47 -0400
Message-ID: <373C34F8.5DE45537@ms.com>
Date: Fri, 14 May 1999 15:36:40 +0100
From: Jan-Simon Pendry <jsp@ms.com>
X-Mailer: Mozilla 4.5 [en] (X11; I; Linux 2.3.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jakub Jelinek <jj@sunsite.ms.mff.cuni.cz>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.rutgers.edu
Subject: Re: [PATCH][2.3.0] Read-write locks instead semaphores on UTS structures
References: <Pine.LNX.4.10.9905121645430.498-200000@freak.conectiva> <373B07EF.58664F9B@ms.com> <19990514123456.R3172@mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu
X-UIDL: 926742673.455407.3615

Jakub Jelinek wrote
> 
> Huh? His patch uses read-write locks and not normal spin-locks, so I don't
> understand what you find wrong on it.

read-write locks are a variant of spin locks.  you can deadlock
the system if you go to sleep holding holding any spin lock.
the only exception is the kernel lock which has special code
to deal with it in schedule().

ideally the spinlock code (spin_lock and read_lock et al)
would have debug versions that counted how many locks were
held (in some per-cpu data structure), and have schedule()
check that this number was zero before putting the process
to sleep.

jan-simon.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
