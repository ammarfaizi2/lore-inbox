Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292901AbSCFB2I>; Tue, 5 Mar 2002 20:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292958AbSCFB16>; Tue, 5 Mar 2002 20:27:58 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:29967 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S292901AbSCFB1p>; Tue, 5 Mar 2002 20:27:45 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: frankeh@watson.ibm.com
Cc: davidel@xmailserver.org, rml@tech9.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fast Userspace Mutexes III. 
In-Reply-To: Your message of "Tue, 05 Mar 2002 10:15:44 CDT."
             <20020305151439.457E03FE06@smtp.linux.ibm.com> 
Date: Wed, 06 Mar 2002 12:31:01 +1100
Message-Id: <E16iQGk-0005ds-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020305151439.457E03FE06@smtp.linux.ibm.com> you write:
> I agree to put it there if its not used as a means to define whether
> user locks are permitted or not. If that is the intention, then the current 
> futex will need to check every access through find_vma(), which we
> both know nobody wants to do.
> 
> So it can only be used for architectural hints, agreed ?

Yes.  It *might* work if you don't PROT_SEM the page the semaphore is
on, but it's still a bug waiting to happen.  OTOH, it'd be nice if
PROT_SEM returns EINVAL was a reliably indicator of no futex support.
This way you actually need to call the futex syscall once to see if it
works.

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
