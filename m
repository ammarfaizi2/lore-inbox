Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155326AbQEBSKF>; Tue, 2 May 2000 14:10:05 -0400
Received: by vger.rutgers.edu id <S155333AbQEBSIh>; Tue, 2 May 2000 14:08:37 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:29770 "EHLO deliverator.sgi.com") by vger.rutgers.edu with ESMTP id <S155335AbQEBRyR>; Tue, 2 May 2000 13:54:17 -0400
Message-ID: <390F1802.F8A2294A@sgi.com>
Date: Tue, 02 May 2000 11:01:38 -0700
From: Linda Walsh <law@sgi.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm+eric@ccr.net>
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: [PATCH] (for 2.3.99pre6) audit_ids system calls
References: <390DCCB6.257F3CC6@sgi.com> <m1hfch3qeq.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

"Eric W. Biederman" wrote:
> What bug does adding two new system calls fix?
> Aren't we in a deep feature freeze at the moment.
> 
> It isn't even terribly obvious what they are for.
> The luid I think I have heard of the sess_id I haven't....
> What bug does adding these fix?
---
	The bug is that any major commercial operating system provides
at least "C2" or "CAPP" level 'trust' (including MS NT).  One of the requirements for this level of 'trust' is that audit actions be able to be
written corresponding to the appropriate 'authenticated' (as in they
gave a "password" (literal password or other biometric)).  Currently,
none of the uid values can be guaranteed to remain constant for
a login session.  Thus the luid fix.  

	Additionally, all of the major
systems companies provide systems (at a substantial premium) that 
meet the "B1" or "LSPP" trust levels (except MS which isn't really
a systems company anyway).  LSPP requires all the features of CAPP
and more.  The US Dod will "prefer" evaluated systems that
meet "CAPP" or above by Jan 1, 2001 and "require" such systems
by July 1, 2002.  In accordance with plans for Linux OS world domination,
infiltration of governments is vital (:-)).  

	To be on the "preferred"
list, Linux needs to have the feature set of and be evaluated to meet the 
"Controlled Access Protection Profile".  Some of our _*Engineering*_ goals
are to have CAPP in eval by early 2001 and the LSPP evaluation complete 
by 01, Jul, 2002.  It is also SGI's desire that all of this work goes
into the main Linux base for any and everyone to make use of.  Toward
this effort, we released a 'reference' B1 implementation (non-funcional
due to removal of code we didn't have full ownership of) on
http://oss.sgi.com/projects/ob1 from the IRIX/Trusted IRIX source.  Our
hope is that people will take ideas and code and help Linux to get to
those levels of "trust" (it isn't all kernel work).

	Other people proposed sess_id for the purpose of tracking
which particular session of a luid did the auditable action.  For
example, you could have more than one person logged in at the same
time.  sessid's can be guaranteed to be unique not only for the time
the computer is running -- but if stored and restored over reboots, 
over the life of the computer -- even if you generated 1/millisecond,
you'd still have to do that for about a 1000 years by my guestimation
and they are only supposed to be generated at the beginning of a 
session.

	For more information on the CAPP profile and the Common Criteria
for trusted computing systems, see www.commoncriteria.org.  Currently
about 8 member countries (Australia, Canada, France, Germany, Netherlands, New Zealand, UK and US) accept comupter systems evaluated at CAPP, LSPP
or any PP at EAL4 and below evaluated in any of the member countries.
In a separate agreement, there is a group of European-only countries
that accept CAPP, LSPP and any system up to EAL7 evaluated in one of
their member countries.  For more information on requirments you 
can also look at "www.itsec.gov.uk" and "radium.nscs.mil/tpep" and
the US Nat. Inst. of Comp. Security at
"http://csrc.nist.gov/topics/welcome.html".

Thank-you for asking! :-)

-linda

-- 
Linda A Walsh                    | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
