Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130380AbRCIA0z>; Thu, 8 Mar 2001 19:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130381AbRCIA0q>; Thu, 8 Mar 2001 19:26:46 -0500
Received: from barrichello.cs.ucr.edu ([138.23.169.5]:29446 "HELO
	barrichello.cs.ucr.edu") by vger.kernel.org with SMTP
	id <S130380AbRCIA0k>; Thu, 8 Mar 2001 19:26:40 -0500
Date: Thu, 8 Mar 2001 16:26:11 -0800 (PST)
From: David Watson <dwatson@cs.ucr.edu>
To: <camm@enhanced.com>
Cc: <linux-kernel@vger.kernel.org>, <brett@cs.ucr.edu>, <dwatson@cs.ucr.edu>
Subject: Re: 2.2.x kernels not filling in siginfo_t.si_addr on SEGV?
Message-ID: <Pine.LNX.4.30.0103081610400.31071-100000@hill.cs.ucr.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-AntiVirus: scanned for viruses by AMaViS perl-6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Greetings!  Shouldn't a SIGSEGV fill in th si_addr member of the
> siginfo_t structure passed to a signal handler?  Here is what I see

Our group ran into this problem last summer while we were developing the
Oasis+ DSM system.  We worked around it by utilizing the following code
fragment:

void fault_handler(int sig, siginfo_t *sip, ucontext_t *ucp)
{
	void *addr;

	addr = (void *) ucp->uc_mcontext.cr2;

	...
}

Hope that helps.

Regards,
David

-- 
The theory of groups is a branch of Mathematics in which one does
something to something and then compares the result with the result
obtained from doing the same thing to something else, or something else to
the same thing.
J. R. Newman

