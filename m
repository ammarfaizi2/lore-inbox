Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbTBJCxP>; Sun, 9 Feb 2003 21:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261286AbTBJCxP>; Sun, 9 Feb 2003 21:53:15 -0500
Received: from ishtar.tlinx.org ([64.81.58.33]:24513 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id <S261173AbTBJCxN> convert rfc822-to-8bit;
	Sun, 9 Feb 2003 21:53:13 -0500
From: "LA Walsh" <law@tlinx.org>
To: "'Crispin Cowan'" <crispin@wirex.com>,
       "'Christoph Hellwig'" <hch@infradead.org>
Cc: <torvalds@transmeta.com>, <linux-security-module@wirex.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [BK PATCH] LSM changes for 2.5.59
Date: Sun, 9 Feb 2003 19:02:12 -0800
Message-ID: <001001c2d0b0$cf49b190$1403a8c0@sc.tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <3E4702CE.3040403@wirex.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Crispin Cowan
>
> Christoph Hellwig wrote:
> 
> LSM does have a careful design. The design goal was to permit loadable 
> kernel modules to mediate access to critical kernel objects by user 
> level processes. By providing such a facility, LSM enables arbitrary 
> security policies and policy management engines to be implemented as 
> loadable modules. This solves the "make one size fit all" problem of 
> diverse interests lobbying Linus to adopt one security model or another 
> as the Linux standard. The LSM design saves Linus from having to make 
> such a  choice by allowing end-users to make their own choice, meeting a 
> goal stated by Linus nearly two years ago.
====
	A security model that mediates access to security objects by
logging all access and blocking access if logging cannot continue is
unsupportable in any straight forward, efficient and/or non-kludgy, ugly
way.  
	LSM is a collection of hack & hooks thrown together in an ad-hoc
manner to support those people who were able to lobby their specific
security policies.  Some security people were banned from the kernel
devel. summit because their thoughts were deemed 'dangerous': fear was they
were too persuasive about ideas that were deemed 'ignorant' and would
fool those poor kernel lambs at the summit.

	Also unsupported: The "no-security" model -- where all security 
is thrown out (to save memory space and cycles) that was desired for embedded work.

	LSM also doesn't support standard LSPP-B1 style graded security
where mandatory access checks are logged as security violations before
DAC checks are even looked at for an object.

	At one point a plan was proposed (by Casey Schaufler, SGI) and 
_\implemented\_ (team members & prjct lead Linda Walsh) to move all
security checks out of the kernel into a 'default policy' module.
The code to implement this was submitted to the LSM list in June 1991.
  
	This plan was shot down as "too radical".  It wasn't what the "kernel
programmers" wanted.  "They" would never accept it and therefore, LSM wouldn't accept it without prior approval from the "kernel
programmers".
When such approval was sought, the seeking party was drawn and quartered
for having the temerity to actually ask the question (since asking the question pointed out the failings of LSM to meet its original
design
goals).

> 
> >The real problem is adding mess to the kernel.
> >
> Christoph's problem is likely that he doesn't like the design. Fair 
> enough, can't please everyone, but a lot of effort went into that 
> design.
---
	True...alot of effort went into building the Titanic as well.

	The modular security model was implemented via macros and cleaned
up the logic of the kernel code by moving toward single exit points
that could allow consistent release of acquired data structures and locks
depending on where failure occurred.  That alone made the code more
readily understandable and maintainable.  Removing security policy
from the code into separate modules also made validation of security
considerably easier.

	So...of course, it wasn't wanted.

	LSM may implement some number of policies, but it is neither robust
nor easy to use.  Only recently was it decided not to require that every
security module to know about every hook.  That was also suggested almost
2 years ago because the current setup makes the implementation of 
security policies *MUCH* more complicated...and, theoretically, inherently
less provably secure.

l. walsh


