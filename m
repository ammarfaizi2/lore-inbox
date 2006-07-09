Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161223AbWGIXkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161223AbWGIXkI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 19:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161224AbWGIXkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 19:40:07 -0400
Received: from liaag2ae.mx.compuserve.com ([149.174.40.156]:56752 "EHLO
	liaag2ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1161223AbWGIXkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 19:40:06 -0400
Date: Sun, 9 Jul 2006 19:34:04 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: use thread_info flags for debug regs and IO
   bitmaps
To: Linus Torvalds <torvalds@osdl.org>, Stephane Eranian <eranian@hpl.hp.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Message-ID: <200607091936_MC3-1-C489-B862@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <Pine.LNX.4.64.0607081425430.3869@g5.osdl.org>

On Sat, 8 Jul 2006 14:26:53 -0700, Linus Torvalds wrote:
> 
> On Fri, 7 Jul 2006, Chuck Ebbert wrote:
> >
> > From: Stephane Eranian <eranian@hpl.hp.com>
> > 
> > Use thread info flags to track use of debug registers and IO bitmaps.
> >  
> >     - add TIF_DEBUG to track when debug registers are active
> >     - add TIF_IO_BITMAP to track when I/O bitmap is used
> >     - modify __switch_to() to use the new TIF flags
> 
> Can you explain what the advantages of this are?

Stephane's perfmon2 patch adds yet another special-case to the
switch_to() code, so Andi suggested this change.  It will allow
the perfmon2 patch to have no performance impact on normal
task-switching, since it will just use another flag.

After I saw a ~7% gain in task-switch performance, I like it now
even without perfmon2 in there.

> I don't see it. It's just creating new state to describe state that we 
> already had, and as far as I can tell, it's just a way to potentially have 
> more new bugs thanks to the new state getting out of sync with the old 
> one?

Well yeah, there is that.  But Andi and I both reviewed it and he's
already put the x86_64 version into his tree.  Testing in -mm should
show whether there are any problems.

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
