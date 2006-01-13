Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964981AbWAMPxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbWAMPxa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 10:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbWAMPxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 10:53:30 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:61113 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964981AbWAMPx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 10:53:29 -0500
Subject: Re: RT question : softirq and minimal user RT priority
From: Steven Rostedt <rostedt@goodmis.org>
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <200601131527.00828.Serge.Noiraud@bull.net>
References: <200601131527.00828.Serge.Noiraud@bull.net>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 10:53:20 -0500
Message-Id: <1137167600.7241.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 15:27 +0100, Serge Noiraud wrote:
> Hi,
> 
> 	I was testing 2.6.15-rt3. During my tests, I tried to run a program which made a loop at
> RT priority 10 and 30.

So you have two programs running, one at priority 10 and 30 right?

> I was very happy to see that after the tests, I can't use any command except those already in memory.

So, are these programs still running?  Are they in busy loops?

> My filesystems were in read-only after the test. I was unable to shutdown the machine : 

How did the filesystems go into read-only?  Did the tests do that?

> top => command not found
> <CTRL><ALT><DEL> => INIT: cannot execute "/sbin/shutdown"
> /sbin/reboot   => Input/Output error
> I had to push the reset button.

I'll need more info to understand these.

> 
> My questions are : 
> Did I find a bug ?

Don't know yet.

> Is the smallest usable real-time priority greater than the highest real-time softirq ?

Nope, you can use any rt priority you want.  It's up to you whether you
want to preempt the softirqs or not. Be careful, timers may be preempted
from delivering signals to high priority processes.  I have a patch to
fix this, but I'm waiting on input from either Thomas Gleixner or Ingo.

> In this case could we forbid priority lesser than the highest softirq priority ?

No need.

-- Steve


