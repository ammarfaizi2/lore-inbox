Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318018AbSHHVv3>; Thu, 8 Aug 2002 17:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318019AbSHHVv3>; Thu, 8 Aug 2002 17:51:29 -0400
Received: from mons.uio.no ([129.240.130.14]:45034 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S318018AbSHHVv2>;
	Thu, 8 Aug 2002 17:51:28 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15698.59577.788998.300262@charged.uio.no>
Date: Thu, 8 Aug 2002 23:55:05 +0200
To: Dave McCracken <dmccr@us.ibm.com>
Cc: trond.myklebust@fys.uio.no, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.30+] Second attempt at a shared credentials patch
In-Reply-To: <81390000.1028837464@baldur.austin.ibm.com>
References: <23130000.1028818693@baldur.austin.ibm.com>
	<shsofcdfjt6.fsf@charged.uio.no>
	<44050000.1028823650@baldur.austin.ibm.com>
	<15698.41542.250846.334946@charged.uio.no>
	<52960000.1028829902@baldur.austin.ibm.com>
	<15698.52455.437254.428402@charged.uio.no>
	<81390000.1028837464@baldur.austin.ibm.com>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dave McCracken <dmccr@us.ibm.com> writes:

     > --On Thursday, August 08, 2002 09:56:23 PM +0200 Trond
     > Myklebust <trond.myklebust@fys.uio.no> wrote:

    >> ... which begs the question: are you saying that there are no
    >> SMP issues with CLONE_CRED and setting/reading the 'struct
    >> cred' members?

     > Yes, I'm saying there are no SMP issues with the shared cred
     > structure.  I looked for them and failed to find any.
     > Credentials are not set cross-task, and are always done via
     > atomic ops.  I also failed to find any broader race conditions
     > that would require a lock.

What if one thread is doing an RPC call while the other is changing
the 'groups' entry?

Given that the first thread wants both to copy and/or compare the
groups entry what prevents scenarios of the form?

  Thread 1                       Thread 2

                                change cred->ngroups
  copy cred->ngroups
  copy cred->groups
                                change cred->groups


Cheers,
  Trond
