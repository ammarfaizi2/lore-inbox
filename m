Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261839AbSIXWtA>; Tue, 24 Sep 2002 18:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261840AbSIXWs7>; Tue, 24 Sep 2002 18:48:59 -0400
Received: from momus.sc.intel.com ([143.183.152.8]:39126 "EHLO
	momus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S261839AbSIXWs4>; Tue, 24 Sep 2002 18:48:56 -0400
Message-ID: <D9223EB959A5D511A98F00508B68C20C0A5389DC@orsmsx108.jf.intel.com>
From: "Rhoads, Rob" <rob.rhoads@intel.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Some Initial Comments on DDH-Spec-0.5h.pdf
Date: Tue, 24 Sep 2002 15:53:40 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Andy Pfiffer [mailto:andyp@osdl.org]
> 
> 
> [ these are my initial comments on the draft release spec -- Andy ]
> 
> Re: DDH-Spec-0.5h.pdf
> 
>   Comment:
> 	I'm not sure I fully understand the problem/feature that is
> 	attempting to be addressed by this specification.  I 
> have a hunch,
> 	but I don't see it expressed clearly and unambiguously
> 	at the beginning of the document.

Agreed, it is confusing. Let me attempt to answer what problem
we were trying to address:

Problem Statement:
=================
Drivers fail and have bugs. The bugs are fixed, new features are added,
the cycle repeats.

We are trying to do two things with the current doc:

1.  Provide guidelines to help the driver creation process such that
    drivers stabalize faster and that trouble-case errors are called
    out to developers so they watch for them.

2.  In the event of a failure or indication that a failure will occur,
    enable drivers and user space applications to take actions to reduce
    the amount of time required for recovery.

Discussion:
==========
Carrier grade systems are all about up time. You want them to fail
infrequently, and when they do fail you want to be able to recover from
the failure as quickly as possible. 

In some instances, hardware provides statistics that are indicative
that a failure WILL occur in the near term future.  Running routine 
device Diagnostics may be helpful in this as well. Right now there
is no standard mechanism to expose that data to user space applications.
(Hooking into driverfs, sounds like the ultimate solution.)

I see all new drivers needing the first part.
I see all drivers needing that second part--it doesn't exist right now.

If there is a good document on 'gotchas' to watch out for, then any
current driver can be reviewed by anyone using that guideline and
see how it stacks up.

Not every driver will need to have changes made.


> 
> 	The specification implies that the major problem with "regular"
> 	drivers is that they:
> 
> 		1. are not written with good programming practices.
> 		2. do not report errors.
> 		3. do not fail gracefully when hardware errors are
> 		   detected.
> 
> 	Is that correct?  It would be most helpful if there were
> 	real-world examples (or statistics) cited to indicate that
> 	non-hardended drivers were the obstacle for carrier-grade
> 	use of Linux, or references to existing drivers that could be
> 	used as examples of items 1), 2), and 3).  We all have differing
> 	experiences with bad drivers, bad hardware, bad fans, bad power
> 	supplies, and so on; it would be relevant to see any historical
> 	data that confirms or refutes the specification's assumptions.
> 

We are not saying that, nor are we implying that existing drivers have
these problems. But you can't prove that any particular driver handles
all fault conditions either. IOW unless every error condition is tested 
on a driver, you don't know that it behaves correctly. I don't think
you can test every fault, because you can't predict every fault.

Sooner or later & no matter how well you've tested your driver: 
the HW will fail or the driver will stumble across a bug, in ways 
that weren't anticipated. In which case we need to address #2 above
in the problem statement. Then we need to fix the bug in the original 
driver. But fixing the bug in the original driver, doesn't help on a
system already deployed for a mission critical application.

So, in the problem domain of high availability, we need mechanisms 
in place to reduce the recovery time. 

Yes, real world example would help (a lot). Without them we
are just blowing smoke. :-)


> 	Generic question: why not just fix the "bad" drivers?

My answer: We will. With that said, we need to help with the 
kernel janitors project.

> 
> 	Generic question: why not focus the "hardening effort" on the
> 	edges of the kernel interfaces, rather than on a 
> driver-by-driver
> 	basis?  Specifically: why not put the "professional paranoia"
> 	into all of the kernel code that calls into drivers, and all
> 	of the routines commonly called by drivers?  One could move
> 	from a model of "this driver is hardened" to "all drivers
> 	are suspect until proven otherwise."  Wouldn't that address
> 	90% of the perceived problem up front, rather than spending 100%
> 	effort to "harden" one driver at a time?

Great suggestion. Anymore suggestions on what kernel code we can apply
our "professional paranoia" to?

> 
> 	General comment: the specification, as written, does not address
> 	an way to enforce compliance, largely because the Stability
> 	and Reliability section is based upon the list of Good Coding
> 	Practices.

I don't think you can enforce it, because they are a list of guidelines.
Further I think the list of Good Coding Practices and everything in 
Stability and Reliability should be moved into a separate "Driver 
Hardening HOWTO" document (i.e. NOT a spec). 

> 
> 
> Re: What is a Hardened Driver?
> 
>   "fault handling"
> 
>   "fault recovery"
> 
>   "fault prediction"
> 
>   "fault analysis"
> 
> 	I'd recommend moving this closer to the beginning of the
> 	specification.  My hunch is that "driver hardening" is
> 	really about just these four items.

Makes sense to me.

> 
> 
>   Quote:
> 	"A typical device driver design focuses on the normal,
> 	 proper operation of the hardware; attention to driver
> 	 behavior in the event of hardware faults is often minimal."

I would strike this passage and replace it with a real problem 
statement, backed with real examples.

> 
>   Comment:
> 	A broad generalization that isn't backed by an example.
> 
> 	I could also state with the same basis in fact: "attention
> 	to correct driver behavior in a multiprocessor environment
> 	is often minimal", or "attention to correct handling of
> 	critical sections is often minimal."
> 
> Re: Driver Hardening Categories
> 
> 	"Stability and Reliability"
> 
> 	Comment:
> 	I consider a "good driver" to have the following attributes:
> 	1. does not cause, directly or indirectly, fatal exceptions.
> 	2. does not cause, directly or indirectly, the system to hang.
> 	3. satisfies the relevant functions as specified,
> 	   with "good performance" characteristics
> 	4. detects errors in configuration, operation, or other aspects
> 	   of the hardware (or software) functions that are managed by
> 	   the driver.
> 	5. is expressed in a maintainable form.
> 
> 	If I map that to the the categories listed in this section,
> 	what I see is that a "hardened driver" has all of the attributes
> 	of a "good driver" plus the following (verbatim):
> 
> 		Stability and reliability:
> 		- "provide for fault injection testing"

I think this is really good and I agree. Again I think everything in 
this section should go into a HOWTO and NOT a spec. This whole idea of
a spec, IMHO was a bad one.

> 
> 		Instrumentation:
> 		N/A: any of these functions should be considered part of
> 		     the driver's requirements;  if it doesn't meet the
> 		     requirements it's not a "good driver."

This may not meet the req's for a "good driver", but address the
concerns that I bring out in #2 of the problem statement above. 
Which is why it is in the document in the first place. But yes, 
I agree it doesn't have much to do with "Hardening Drivers", if 
I may use that term instead of "good drivers". 

I would also add that each of the items in the Instrumentation 
section should be broken out, as separate items and addressed
in separate projects or out right killed. I never said that our
doc was a final solution, just a starting point for a discussion.

I would further comment on this section of the document:

Any mention of POSIX Event Logging, should be struck/removed. 
Sorry to those who hold it dear, but it isn't going to fly. 
Read the LKML, if you must know why. Now there is a discussion
going on now about an alternative event logging mechanism. There
seems to be some need for it.

There also appears to be a need for some sort of driver diagnostics,
again judging by response on the LKML. I recommend that is be
killed as any part of HDD effort. We need to work with the 
linux-diag project on this and not part of this project.

IMHO Statistics should be better handled in user-space 
and NOT kernel space. Again, should be its own separate
project.

> 
> 		High Availability:
> 		N/A: also part of the driver's specifications

Most of the section on High Availability should be axed.

The big exception being "fault injection testing". I see value in 
keeping FI testing.


> 
> 	My opinion after reading this section that a "hardened driver"
> 	is equivalent to a "good driver", and that "hardened 
> with diagnostics"
> 	is equivalent to a "good driver with standard diagnostics", and
> 	"hardened with instrumentation" is a "good driver with standard
> 	instrumentation."

I agree.

> 
> 	The one item I couldn't bin: "fault injection testing."

I agree.

> 
> 
> 
