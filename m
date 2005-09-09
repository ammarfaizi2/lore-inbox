Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030235AbVIIK6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbVIIK6Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 06:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbVIIK6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 06:58:25 -0400
Received: from mail.suse.de ([195.135.220.2]:63648 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030235AbVIIK6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 06:58:24 -0400
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [discuss] [PATCH] allow CONFIG_FRAME_POINTER for x86-64
Date: Fri, 9 Sep 2005 12:58:12 +0200
User-Agent: KMail/1.8
Cc: Jan Beulich <JBeulich@novell.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
References: <43207D28020000780002451E@emea1-mh.id2.novell.com> <4321749202000078000248C5@emea1-mh.id2.novell.com> <Pine.LNX.4.61.0509091133180.5937@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0509091133180.5937@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509091258.13300.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 September 2005 12:45, Hugh Dickins wrote:
> On Fri, 9 Sep 2005, Jan Beulich wrote:
> > > But why would anyone want frame pointers on x86-64?
> >
> > I'd put the question differently: Why should x86-64 not allow what
> > other architectures do?
> >
> > But of course, I'm not insisting on this patch to get in, it just
> > seemed an obvious inconsistency...
>
> I'm with Jan on this.  I use a similar patch for frame pointers on
> x86_64 most of the time, in the hope of getting more accurate backtraces.

It won't give more accurate backtraces, not even on i386 because show_stack
doesn't have any code to follow frame pointers.


> Is x86_64 somehow more likely to give you a less noisy backtrace than
> i386?  Fewer of those stale return addresses from earlier trips down
> the stack?

I have a plan to fix this - basically Jan's NLKD has
code to read the unwind information and then do an accurate backtrace
without frame pointers. The plan is to port that code over
(it currently requires too much infrastructure from the debugger
and needs some coding style fixes) and then add something like
CONFIG_RUNTIME_UNWIND_INFO that puts the unwind information into
the running kernel. Then you'll get accurate backtraces without 
frame pointers.

The NLKD code would work on i386 too so it could be later enabled
there then too.

IA64 works similar already BTW but the code is not really usable
for other architectures.

> Frame pointers are imperfect on all(?) the supported architectures,
> but I can't see any good reason to exclude them from x86_64.  Just a
> couple of weeks ago LKML had a bug where enabling frame pointers on
> x86_64 helped Ingo to pinpoint the origin of the problem.

They are useless because the core kernel doesn't have any code
to follow them. That's true on i386 and on x86-64.

The only reason to use them would be external debuggers, but those
don't need them on x86-64 neither.

-Andi
