Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265065AbTBJUlm>; Mon, 10 Feb 2003 15:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265096AbTBJUlm>; Mon, 10 Feb 2003 15:41:42 -0500
Received: from ishtar.tlinx.org ([64.81.58.33]:36564 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id <S265065AbTBJUla> convert rfc822-to-8bit;
	Mon, 10 Feb 2003 15:41:30 -0500
From: "LA Walsh" <law@tlinx.org>
To: <linux-kernel@vger.kernel.org>
Subject: RE: [BK PATCH] LSM changes for 2.5.59
Date: Mon, 10 Feb 2003 12:51:11 -0800
Message-ID: <004701c2d146$24c26230$1403a8c0@sc.tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <3E471F21.4010803@wirex.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 
> >  Some security people were banned from the kernel
> >devel. summit because their thoughts were deemed 
> 'dangerous': fear was they
> >were too persuasive about ideas that were deemed 'ignorant' and would
> >fool those poor kernel lambs at the summit.
> >
> Internal SGI politics.
---
	Nope... external -- the conference organizer was the one selecting and specifically disallowing certain attendees.  It
appeared important to weed out anyone who didn't think like him.

> 
> >	Also unsupported: The "no-security" model -- where all security 
> >is thrown out (to save memory space and cycles) that was 
> desired for embedded work.
> >
> False: capabilities is now a removable module, which is what 
> Linus asked 
> for.
---
	FALSE?  Are you telling us that you believe the only security in the kernel concerns capabilities?  Most security people
would acknowledge that Discretionary Access Control (DAC) by user-id and privilege control via
the binary "(UID==0)" would qualify as a "security" model.  Even the "Mandatory Access Control" bits, "immutable" and "append-only",
are a security model.  Capabilities are an almost insignificant part of security compared to the code for DAC and UID==0 checks.
Your statement
is misdirecting like a response to a question about a car: "How does 
it run?  Reliability?  Look at those tires! You won't see tires like 
that anywhere!" 



  
> 
> >	LSM also doesn't support standard LSPP-B1 style graded security
> >where mandatory access checks are logged as security 
> violations before
> >DAC checks are even looked at for an object.
> >
> Because doing so would have required approx. 6-10X as many 
> LSM hooks as 
> the current LSM. Speak up if you think LSM should be 10X bigger to be 
> able to support Common Criteria standards compliant audit logging ...
---
	I don't have current figures, but in the 2.4.2 kernel from Apr, 01,
I noted that the LSM patch yielded 179 patches to 35 source files
in 68 different procedures of which 33 are system calls."

The 2.4.2 audit patch had about 130 different procedure's "hooked" with
maybe twice that many data collection calls depending on the route taken through the code.  Additionally exit calls were required
for each
procedure (with exact number depending on how many different exit points
existed/procedure).  This was before any work combining exit targets that often simplified code to 'unroll' state.

	On IRIX, compiler pragmas like "execute_frequency_hint NEVER"
made sure that mainline cache wasn't harmed in the normal case and
required that even code computing audit masks was done 'out of line'.  
On a P4, this could be similar to hinting to the processor what to
optimize it's pipeline for -- meaning virtually no execution impact when audit was compiled in but turned off because the pipeline
would already be started on the post branch code.  But these intricacies are a matter of 
compiler technology.

	A pre-LSM version of audit existed and completely compiled out when not explicitly selected as a kernel build option.  When
enabled, _FULL_ auditing of a kernel build on a 2PIIx400 machine measured about 10% overhead, typically, for the 2.4.[12] series
(single HD, ~3-5Mb/s record
rate).  Compiled in but turned off, impact was *questionably* measurable (<.3%) and turned on but "no events" was still in noise
range (<1%) with typical monitoring sets being <3% overhead.  This was with no specific performance tuning -- just SMP stress
testing.

> >	At one point a plan was proposed (by Casey Schaufler, SGI) and 
> >_\implemented\_ (team members & prjct lead Linda Walsh) to move all
> >security checks out of the kernel into a 'default policy' module.
> >The code to implement this was submitted to the LSM list in 
> June [2001].
> >
> And I actually like that plan. But I still believe it to be 
> too radical for 2.6.
---
	The kernel was at version 2.4.[2-4].  At that time,  2.5 didn't even exist.  Whether or not it would be too much for 2.6
wasn't even on the table. The code had been tested and was ready but rejected -- because,
you said, the "kernel developers" would never accept it.  You proposed
a 2-stage process to Casey that lsm would first get it's head inside
the tent with hooks for the existing policies already in lsm, then
in the 2nd stage, you'd push for audit hooks.  I felt that the 2nd stage
would be pushed off until some vague, nebulous date, too far in the future to be of any use to SGI.  Casey disagreed and went
forward supporting you.
Over a year later, after going through contortions to get audit to work with
(in spite of?) lsm hooks by hooking all system calls (fulfilling Linus's stereotype of "stupid" designs) to get around lsm's
shortcomings, the 
project was shelved.  It had taken too long.  As for performance?  Even 
questions, about performance, were declared "off-limits".

> It has many nice properties, but is much more 
> invasive to the 
> kernel. 
---
	"More invasive".  Sorta like water is more invasive to our 
bodies than Helium.  Almost any security text will claim that security
has to be built in at the lowest levels -- even as far as designing it
in from the beginning to be successful.  You would expect good security
to _not_ be integral to a secure kernel?  


> I think it is a very interesting idea for 2.7, and should be 
> floated past the maintainers who will be impacted to see if it has a 
> hope in hell.
---
	I tried to float it past several maintainers in July 01 after
multiple people on the lsm list said they wouldn't consider it without
"pre-buyin" of the "kernel developers".  When I attempted to question
"them", a response to the question was reposted to the lkml.  You
complained to Casey who removed me from the project to mollify you in
hopes you would make good on your promises to include audit in the vague,
nebulous, "too-late", stage 2.

	You blew away a working implementation of a completely modular
security prototype because your first priority was to your specific
security policy -- not to what Linus had desired in having a "truly generic"
policy.  This type of bias, along with the considerable weight given
to the needs of SELinux (then the "darling" of linux security -- before
it was pointed out that it used privately held patents that would likely prohibit any commercial use of the security model) only
highlights problems when corporate and commercial interests are placed ahead of good design.

-l


	This

