Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282861AbRK0IGU>; Tue, 27 Nov 2001 03:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282851AbRK0IDo>; Tue, 27 Nov 2001 03:03:44 -0500
Received: from blount.mail.mindspring.net ([207.69.200.226]:41510 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S282860AbRK0IDJ>; Tue, 27 Nov 2001 03:03:09 -0500
Message-Id: <5.0.2.1.2.20011127022738.009f14b0@pop.mindspring.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Tue, 27 Nov 2001 03:04:27 -0500
To: <mingo@elte.hu>, Robert Love <rml@tech9.net>
From: Joe Korty <l-k@mindspring.com>
Subject: procfs bloat, syscall bloat [in reference to cpu affinity]
Cc: Ryan Cumming <bodnar42@phalynx.dhs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0111270930470.3061-100000@localhost.localdom
 ain>
In-Reply-To: <1006832357.1385.3.camel@icbm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An argument  of `it's bloat, don't do it!' against the addition of a new 
system call (or a new
procfs entry) is somewhat meaningless, as `bloat' is a word so broad and 
ill-defined that
applying it as an argument has the potential of stopping useful 
enhancements to the Linux
user interface, or preventing the best possible user interface from being 
implemented
at the outset.  If one is going to be concerned about bloat (as I am and as 
almost everyone
should be), one needs another yardstick to apply, one that can illuminate 
those proposals
which are Good (and hence non-bloating) and those which are Crud (and hence 
can be
safely condemned for the crime of bloat).

The yardstick I would like to apply here is: is the user's view of the new 
service something
that is simple and fundamental, unlikely to change as Linux moves from 
platform to platform
and evolves over time, or is it something quirky, tied to the current 
implementation and
exposes its complexities to the user in ways that the interface is 
guaranteed to change
as Linux evolves?  Examples of the first type of interface are read(2), 
write(2), open(2),
memcopy(3), cos(3).  These have been with us from the beginning of time and 
no one
imagines them going away or changing in any fundamental way.  On the other 
hand, the
IDE driver tuneables would be an example of the quirky second kind -- this 
interface
will change as new IDE controller chips become available, and have few (if 
any) connection
with, say, any equivalent SCSI tuneables, yet both control similiar kinds 
of devices.

So my rule is, services of the first kind, the ones that are simple and 
eternal, should be
system calls, while the quirky second kind should be consigned soley to the 
proc fs.

I feel that the cpu affinity services are of the first kind.  They are very 
simple, very
conceptual services that have absolutely no tie in to any architecture 
other than it
be SMP, and even on uniprocessors they reduce down gracefully to the null 
state.  Once
defined, if defined well, they have the potential of lasting forever much 
like pipe(2) etc
does today.  Part of what I see that makes affinity as being `eternal' is 
that there is
nothing about the user view of affinity that is even Linux specific -- one 
could see other unices having exactly the same services with exactly the 
same semantics, and perhaps
even radically different OSes such as NT easily supporting identical, or 
nearly identical
affinity services.  It is this universality that makes cpu affinity 
services likely syscall
candidates.

I am not against a proc interface per se, I would like a proc interface, 
especially for the
reading of affinity values.  But in my view the system call interface 
should also exist
and it should be the dominate way of communicating affinity to processes.

Joe

