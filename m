Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbTEAAkP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 20:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbTEAAkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 20:40:15 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:35743 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262593AbTEAAkO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 20:40:14 -0400
To: Robert Love <rml@tech9.net>
cc: viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@digeo.com>,
       Rick Lindsley <ricklind@us.ibm.com>, solt@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org, frankeh@us.ibm.com
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: must-fix list for 2.6.0 
In-reply-to: Your message of 30 Apr 2003 20:09:13 EDT.
             <1051747753.17629.44.camel@localhost> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30559.1051750296.1@us.ibm.com>
Date: Wed, 30 Apr 2003 17:51:36 -0700
Message-Id: <E19B2IS-0007wx-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Apr 2003 20:09:13 EDT, Robert Love wrote:
> On Wed, 2003-04-30 at 19:47, viro@parcelfarce.linux.theplanet.co.uk
> wrote:
> 
> > Excuse me, but WTF do they spin on the sched_yield() in the first place?
> > _That_ sounds like utterly broken...
> 
> I agree it is broken, but it was considered a method of implementing
> user-space locking for a long time..
> 
> The problem is in LinuxThreads mostly, I guess, according to Andrew.

Which affects JVM in most cases.  NPTL based JVMs will possibly
obviate that problem.  My guess is that in the JVM case, they have
a bad locking model (er, a simpler 2-tier locking model instead of
a more correct and complex 3-tier locking model) for their threading
operations.  As a result, they use either sched_yield() or used
to use pause() to relinquish the processor so the world could change
and they could acquire the locks they wanted.

Sounds stupid, but that was the most obvious linuxthreads implementation.
Futexes are also likely to help here, btw...

Of course, all of this is my own heresay, so if anyone has better
details, feel free to add them.

gerrit
