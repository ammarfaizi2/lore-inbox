Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbTKIKEu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 05:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbTKIKEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 05:04:50 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:64234 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S262251AbTKIKEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 05:04:45 -0500
Date: Sun, 9 Nov 2003 02:04:24 -0800
From: Frank Cusack <fcusack@fcusack.com>
To: Robert Love <rml@tech9.net>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org
Subject: Re: preemption when running in the kernel
Message-ID: <20031109020424.A801@google.com>
References: <20031107040427.A32421@google.com> <200311081402.07345.ioe-lkml@rameria.de> <1068337385.27320.203.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1068337385.27320.203.camel@localhost>; from rml@tech9.net on Sat, Nov 08, 2003 at 07:23:05PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 08, 2003 at 07:23:05PM -0500, Robert Love wrote:
> On Sat, 2003-11-08 at 08:01, Ingo Oeser wrote:
> 
> > While having preemption disabled or while actually holding a spinlock,
> > preemption is disabled.
> > 
> > Disabling preemption is modifying a count, which must reach 0 again to
> > have preemption enabled and trigger an reschedule, if needed.
> > 
> > Think of it roughly as a "counter of reasons to not preempt". If there
> > are no reasons anymore, then we preempt.
> 
> Hi, Ingo.
> 
> This is an accurate description of 2.6, but Frank said for 2.4.
> 
> So, Frank, this is correct for 2.6 or 2.4 with the preempt-kernel patch,
> but not a stock 2.4 kernel.  A stock 2.4 kernel will never preempt a
> task running inside the kernel.

Thank you for the clarification.

That leads me to 2 followup questions.

If a task in the kernel is preempted, is a membar issued?  (I believe
so -- running another task means that the scheduler must have run,
which will grab and release various locks thus giving us the membars.)

When the preempted task resumes, is it guaranteed to run on the same CPU?
(I wouldn't expect so, unless the task was specifically told to do that
via hard affinity.  But maybe a task preempted in the kernel is different
then a task preempted in userland.)

/fc
