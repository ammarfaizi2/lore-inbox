Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129115AbRCID3r>; Thu, 8 Mar 2001 22:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129567AbRCID3h>; Thu, 8 Mar 2001 22:29:37 -0500
Received: from enhanced.ppp.eticomm.net ([206.228.183.5]:31470 "EHLO
	intech19.enhanced.com") by vger.kernel.org with ESMTP
	id <S129115AbRCID31>; Thu, 8 Mar 2001 22:29:27 -0500
To: David Watson <dwatson@cs.ucr.edu>
Cc: <linux-kernel@vger.kernel.org>, <brett@cs.ucr.edu>
Subject: Re: 2.2.x kernels not filling in siginfo_t.si_addr on SEGV?
In-Reply-To: <Pine.LNX.4.30.0103081610400.31071-100000@hill.cs.ucr.edu>
From: Camm Maguire <camm@enhanced.com>
Date: 08 Mar 2001 22:28:39 -0500
In-Reply-To: David Watson's message of "Thu, 8 Mar 2001 16:26:11 -0800 (PST)"
Message-ID: <54itljvcwo.fsf@intech19.enhanced.com>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings, and thank you so much for your helpful reply!  Was this on
an i386?  I'm specifically looking for a way to do his on arm, alpha,
and sparc, and I don't believe they have the cr2 member of struct
sigcontext.  Any info you might have, including where you found this
solution, would be appreciated!

Take care,

David Watson <dwatson@cs.ucr.edu> writes:

> > Greetings!  Shouldn't a SIGSEGV fill in th si_addr member of the
> > siginfo_t structure passed to a signal handler?  Here is what I see
> 
> Our group ran into this problem last summer while we were developing the
> Oasis+ DSM system.  We worked around it by utilizing the following code
> fragment:
> 
> void fault_handler(int sig, siginfo_t *sip, ucontext_t *ucp)
> {
> 	void *addr;
> 
> 	addr = (void *) ucp->uc_mcontext.cr2;
> 
> 	...
> }
> 
> Hope that helps.
> 
> Regards,
> David
> 
> -- 
> The theory of groups is a branch of Mathematics in which one does
> something to something and then compares the result with the result
> obtained from doing the same thing to something else, or something else to
> the same thing.
> J. R. Newman
> 
> 
> 

-- 
Camm Maguire			     			camm@enhanced.com
==========================================================================
"The earth is but one country, and mankind its citizens."  --  Baha'u'llah
