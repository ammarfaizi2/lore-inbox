Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <156783-219>; Tue, 8 Dec 1998 09:41:00 -0500
Received: from lin.varel.bg ([212.50.6.9]:15694 "EHLO lin.varel.bg" ident: "TIMEDOUT") by vger.rutgers.edu with ESMTP id <161112-17165>; Tue, 8 Dec 1998 09:01:02 -0500
Message-ID: <366D5900.201AF930@varel.bg>
Date: Tue, 08 Dec 1998 18:51:12 +0200
From: Petko Manolov <petkan@varel.bg>
Organization: Varel Ltd.
X-Mailer: Mozilla 3.0 (X11; I; Linux 2.1.131 i586)
MIME-Version: 1.0
To: mingo@chiara.csoma.elte.hu
CC: linux-kernel@vger.rutgers.edu
Subject: Unlimited number of processes, x86, 2.1.131
References: <Pine.LNX.3.96.981208013108.1838A-100000@localhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

> sure. I've attached a cleartext version too. (it's my freshest version,
> one slight bug fixed and some debugging code removed)
> 
> feel free to ask questions and please Cc: linux-kernel too, so others see
> the questions too. (and thus i have to answer them only once :) 


Ok, the patch applied cleanly. Sadly there was a problem with compiling.
You'd forgot to comment mmu_cr4_features in arch/i386/mm/init.c and
linkker is moaning for duplicate. The variable is in
arch/i386/kernel/setup.c. Except this all went OK. I'm writing this
with your kernel running ;-).

If i understand correctly this can't be aplied for 2.0.xx series - 
you remove tr field from tss struct(as tss itself) - where we do
task switch thru TSS descriptor in GDT. But this is obviously not
necessery for 2.1.xxx where we do SW task switch.
 
I'm still not so familiar with the patch, but "soft_thread_struct" is
far smaller than task_struct and this should be an improvement for
clone().

All this is general change of concept (GDT, task structures, etc...)
and i'm curious what Linus will say about this ;-))

regards
-- 
Petko Manolov - petkan@varel.bg
http://www.varel.bg/~petkan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
