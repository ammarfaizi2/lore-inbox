Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314447AbSDRUL5>; Thu, 18 Apr 2002 16:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314448AbSDRUL4>; Thu, 18 Apr 2002 16:11:56 -0400
Received: from mta01-svc.ntlworld.com ([62.253.162.41]:65510 "EHLO
	mta01-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S314447AbSDRULz>; Thu, 18 Apr 2002 16:11:55 -0400
Date: Thu, 18 Apr 2002 21:13:29 +0100
From: Malcolm Beattie <mbeattie@clueful.co.uk>
To: Larry McVoy <lm@work.bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux on s/390 is cute
Message-ID: <20020418211329.A8618@clueful.co.uk>
In-Reply-To: <20020418082636.O2710@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy writes:
> I'd really like to see the IBM guys let the walls between the linux
> instances down a bit.  If I could mmap the other linux instances
> memory, that's a kickass system.

The situation is analagous to that of mapping memory between tasks in
Linux. Instead of one task mapping another's address space directly,
the usual design is to have both tasks do a shared mmap() of an
underlying file. Similarly, with multiple Linux guests under VM, you
can have them both map a shared pre-created Named Saved Segment (NSS).

Such an NSS is created by a guest with appropriate privileges via the
CP command DEFSEG and then, once mapped and primed with its initial
content, saved with SAVESEG. After that, other (permitted) guests can
access and map it into their (perceived real) address space via the
DIAGNOSE X'64' API. For details, see the manuals
"CP Command and Utility Reference" (SC24-6008-02) and
"CP Programming Services" (SC24-6001-01) available in PDF form from
    http://www.vm.ibm.com/pubs/pdf/vm420bas.html

There's also DIAG X'248' ("Copy-to-Primary Service") which lets you
copy memory from the address space of another guest into your own
address space (obviously, the other guest must have set access
controls to let you do it...). Nobody has yet published nice Linuxy
interfaces to use either of these APIs but it's somewhere low down my
ToDo list and I've a feeling someone else that's been looking at this
stuff will probably beat me to it anyway.

> Anyway, kudos to the people who did the Linux/390 stuff, we'll
> include it in our list of supported platforms next release.

I'll check and see if it gets added to the Linux/390 software
availability list.

--Malcolm

-- 
Malcolm Beattie <mbeattie@clueful.co.uk>
Linux Technical Consultant
IBM EMEA Enterprise Server Group...
...from home, speaking only for myself
