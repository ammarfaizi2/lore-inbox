Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbTGKPZT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 11:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263398AbTGKPZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 11:25:19 -0400
Received: from netrider.rowland.org ([192.131.102.5]:53255 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S263407AbTGKPZI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 11:25:08 -0400
Date: Fri, 11 Jul 2003 11:39:51 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: "David D. Hagood" <wowbagger@sktc.net>, <hzhong@cisco.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Style question: Should one check for NULL pointers?
In-Reply-To: <Pine.LNX.4.53.0307111039400.2708@chaos>
Message-ID: <Pine.LNX.4.44L0.0307111127140.22455-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jul 2003, Richard B. Johnson wrote:

> On Fri, 11 Jul 2003, David D. Hagood wrote:
> 
> > But consider the following code:
> >
> > sscanf(0,0);
> >
> > That IS an error condition - both the string to scan and the format
> > string are NULL. In this case sscanf should return EITHER 0 (no items
> > matched) or better still -1 (error).
> >
> 
> But it does neither. Instead, it seg-faults your code!
> 
> The problem lies with the original question. The question
> referred to "Style" (look at the subject-line). It is
> not a question about style, but a question about utility
> and design. Style has nothing to do with it.

This isn't really an example of the sort of thing I was asking about.  I
was referring specifically to kernel code, not general-purpose userspace C
library routines like sscanf.

But maybe you mean the kernel's internal implementation of sscanf.  If 
someone in the kernel did write "sscanf(0,0);" then that would definitely 
be an error in the source.  It should be brought to the author's attention 
as soon as possible, and a segfault (or BUG_ON) is a much more effective 
way of doing so than simply returning -1.

> If you are writing code for an embedded system, the code
> must always run even if RAM got trashed from alpha particles
> or EMP. In that case, you trap every possible condition and
> force a restart off a hardware timer, refreshing everything in
> RAM from PROM or NVRAM.

Okay, but there's no way at the source level to protect against all kinds
of events like alpha particles changing a stored value.  And what's the
point in checking just _some_ of them in the source if you're going to
have to check _all_ of them at a lower (hardware) level anyway?

> If you are writing code to examine the contents of sys_errlist[],
> prior to adding another error-code, then you don't check anything
> and it's file-name is probably a.out, compiled from xxx.c.

I don't understand that comment.

> So, the extent to which one checks for exceptions and provides
> utility for handling exceptions depends upon the code design, not
> it's style.

But the kernel already provides a utility for handling exceptions and has 
a fairly fixed design.  The extent to which one writes exception checks of 
dubious value is indeed a stylistic issue, at least in this one setting.

Alan Stern

