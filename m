Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262642AbUBZDSB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 22:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbUBZDQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 22:16:34 -0500
Received: from alt.aurema.com ([203.217.18.57]:39347 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S262642AbUBZDOt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 22:14:49 -0500
Date: Thu, 26 Feb 2004 14:14:34 +1100 (EST)
From: John Lee <johnl@aurema.com>
To: Pavel Machek <pavel@ucw.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
In-Reply-To: <20040225225159.GA1906@elf.ucw.cz>
Message-ID: <Pine.GSO.4.03.10402261339140.8776-100000@swag.sw.oz.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 25 Feb 2004, Pavel Machek wrote:

> > Usage rate caps are expressed as rational numbers (e.g. "1 / 2") and hard caps 
> > are signified by a "!" suffix.  The rational number indicates the proportion 
> > of a single CPU's capacity that the task may use. The value of the number must 
> > be in the range 0.0 to 1.0 inclusive for soft caps. For hard caps there is an 
> > additional restriction that a value of 0.0 is not permitted.  Tasks with a 
> > soft cap of 0.0 become true background tasks and only get to run when no other 
> > tasks are active.
> 
> Why not use something like percent, parts per milion or whatever?

Fair comment. Fine granularity with percentages would require decimal
points and a function in the kernel to parse that value - maybe I could
get around to doing that. But I suppose ppm could certainly be used. We
just chose rational numbers to start with.

> > When hard capped tasks exceed their cap they are removed from the run queues 
> > and placed in a "sinbin" for a short while until their usage rate decays to
> > within limits.
> 
> How do you solve this one?

The task is removed from the runqueue and a timer is scheduled to put it
back onto the runqueue. The delay period is the required amount of time
for that task's usage to decay to below its cap.

> I want to kill your system.
> 
> I launch task A, "semaphore grabber", that does filesystem
> operations. Those need semaphores. I run it as "true background".
> 
> I wait for A to grab some lock, then I run B, which is while(1);
> 
> A holds lock that can not be unlocked, and your system is dead.
> 
> This may happen randomly, even without me on your system.

Good point. We'll have to rethink background priorities.

John


