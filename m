Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263301AbUDUXtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263301AbUDUXtR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 19:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263308AbUDUXtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 19:49:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:14043 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263301AbUDUXtP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 19:49:15 -0400
Date: Wed, 21 Apr 2004 16:50:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adam Litke <agl@us.ibm.com>
Cc: roland@topspin.com, mlxk@mellanox.co.il, linux-kernel@vger.kernel.org
Subject: Re: stack dumps, CONFIG_FRAME_POINTER and i386 (was Re: sysrq shows
 impossible call stack)
Message-Id: <20040421165059.4579e64d.akpm@osdl.org>
In-Reply-To: <1082590136.715.190.camel@agtpad>
References: <408545AA.6030807@mellanox.co.il>
	<52ekqizkd2.fsf@topspin.com>
	<40855F95.7080003@mellanox.co.il>
	<5265buzgfn.fsf_-_@topspin.com>
	<1082492730.716.76.camel@agtpad>
	<52llkqw5me.fsf@topspin.com>
	<20040420183915.4eee560c.akpm@osdl.org>
	<20040420184109.6876b3d9.akpm@osdl.org>
	<1082590136.715.190.camel@agtpad>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Litke <agl@us.ibm.com> wrote:
>
> On Tue, 2004-04-20 at 18:41, Andrew Morton wrote:
> > Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > Roland Dreier <roland@topspin.com> wrote:
> > >  >
> > >  >     Adam> This problem was annoying me a few months ago so I coded up
> > >  >     Adam> a stack trace patch that actually uses the frame pointer.
> > >  >     Adam> It is currently maintained in -mjb but I have pasted below.
> > >  >     Adam> Hope this helps.
> > >  > 
> > >  > Thanks, that looks really useful.  What is the chance of this moving
> > >  > from -mjb to mainline?
> > > 
> > >  Good, but it needs to be updated to do the right thing with 4k stacks when
> > >  called from interrupt context.
> 
> The show_trace() for the CONFIG_FRAME_POINTER case will now be called
> the same way as the existing code.

I still don't see any code in there to handle the transition from the
interrupt stack page to the non-interrupt stack page in the 4k-stacks case?

> This brings up a question though. 
> It doesn't appear to me that anyone is actually calling
> show_trace_task() yet.  Am I missing something or should we change all
> the callers of show_trace() to use show_trace_task()?

You're right - we've killed off all of its callers.  Neat.  I shall
administer the coup de grace.

