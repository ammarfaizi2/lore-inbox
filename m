Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293326AbSCEPPG>; Tue, 5 Mar 2002 10:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293335AbSCEPOq>; Tue, 5 Mar 2002 10:14:46 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:23742 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S293326AbSCEPOp>; Tue, 5 Mar 2002 10:14:45 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Fast Userspace Mutexes III.
Date: Tue, 5 Mar 2002 10:15:44 -0500
X-Mailer: KMail [version 1.3.1]
Cc: davidel@xmailserver.org, rml@tech9.net, linux-kernel@vger.kernel.org
In-Reply-To: <1015271393.15277.112.camel@phantasy> <20020304154848.A1055@elinux01.watson.ibm.com> <20020305154838.66c82118.rusty@rustcorp.com.au>
In-Reply-To: <20020305154838.66c82118.rusty@rustcorp.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020305151439.457E03FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 March 2002 11:48 pm, Rusty Russell wrote:
> On Mon, 4 Mar 2002 15:48:48 -0500
>
> Hubertus Franke <frankeh@watson.ibm.com> wrote:
> > Also, the check on PROT_SEM is missing. I tried this before and glibc
> > filtered these flags out when set. But effectively, one still needs to
> > check whether semaphores are allowed during the sys_futex call.
>
> Neither arch I care about (ppc, x86) needs to do anything with PROT_SEM, so
> it's OK.  glibc will have to be fixed on any architectures which require
> help here, and a hook will be needed somewhere in the kernel for them.
>
> I didn't implement it because I don't *know* which archs will need
> something, and what they will need.  Hence my request for arch maintainers
> to step forward (Linus said they exist, and I believe him).
>
> Hope that clarifies this particular wart...
> Rusty.

Clarifies only partially.

I agree to put it there if its not used as a means to define whether
user locks are permitted or not. If that is the intention, then the current 
futex will need to check every access through find_vma(), which we
both know nobody wants to do.

So it can only be used for architectural hints, agreed ?

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
