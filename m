Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272649AbRIGNX5>; Fri, 7 Sep 2001 09:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272655AbRIGNXv>; Fri, 7 Sep 2001 09:23:51 -0400
Received: from [195.89.159.99] ([195.89.159.99]:13301 "EHLO
	kushida.degree2.com") by vger.kernel.org with ESMTP
	id <S272652AbRIGNXk>; Fri, 7 Sep 2001 09:23:40 -0400
Date: Fri, 7 Sep 2001 02:38:33 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Orjan Friberg <orjan.friberg@axis.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sa_sigaction signal handler: third parameter?
Message-ID: <20010907023833.B7329@kushida.degree2.com>
In-Reply-To: <3B95F745.A1476AFD@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B95F745.A1476AFD@axis.com>; from orjan.friberg@axis.com on Wed, Sep 05, 2001 at 11:58:29AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Orjan Friberg wrote:
> I'm trying to make life easier for a user-defined SIGSEGV handler, the
> sa_sigaction one with 3 parameters.  The second parameter, the siginfo_t
> * one, is there.  Problem is, I would like to pass on additional
> information to the signal handler, more specifically information about
> whether there was a protection fault, read/write etc.  I've looked at
> some of the other ports (I'm working on the CRIS port BTW), and for
> example the i386 has fields in the task and sigcontext structs to keep
> this sort of information.  
> 
> Question is how to pass this information on to the signal handler. 
> Looking at the code, it seems the third parameter (void *) is being used
> to send a ucontext_t * in (at least) the arm and mips cases.  I followed
> a lot of threads in the archive, but couldn't find one that adressed
> what this third parameter is actually meant to be used for.  Obviously,
> sending a ucontext would solve my problem, since it contains the
> sigcontext struct.  Is there a Right Way to do it?

Whether or not there was a protection fault is indicated with
SEGV_MAPERR vs. SEGV_ACCERR.  Unfortunately, the siginfo_t doesn't have
any place to indicate whether it's a read or a write fault.  *How could
they have left that out?*

The Right Way, IMHO, would be to find some acceptable,
standard-compatible way to get the read/write flag into the siginfo_t.

cheers,
-- Jamie
