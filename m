Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262689AbSI1DQ6>; Fri, 27 Sep 2002 23:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262691AbSI1DQ6>; Fri, 27 Sep 2002 23:16:58 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:4362 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S262689AbSI1DQ5>; Fri, 27 Sep 2002 23:16:57 -0400
Date: Fri, 27 Sep 2002 20:21:13 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Robert Love <rml@tech9.net>
cc: Andrew Morton <akpm@digeo.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Sleeping function called from illegal context...
In-Reply-To: <1033182396.22584.22.camel@phantasy>
Message-ID: <Pine.LNX.4.10.10209272013370.13669-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Sep 2002, Robert Love wrote:

> On Fri, 2002-09-27 at 22:04, Andre Hedrick wrote:
> 
> > See in trying to move to a spinlock it goes totally south.
> > So now that you know the where, and why ... please go fix.
> > See I am off working with AC on the issues for 2.4.
> > 
> > Also with PREMPT, bah never mind.
> 
> Sigh... I do not want to start this but this problem has nothing to do
> with preemption and everything to do with you sleeping while holding a
> lock.  It exists whether preempt is on or off.

Robert,

Glad we agree on the lock issue, thanks for confirming the point!
There is an issue of interrupt acknowledgement and when one can pre-empt.
I would like to resolve the issue, but I need a global caller/notifier api
from you so I can block IO in a safe spot on the 'data transfer' state
bar.  Yeah, blah blah on underfined terms.

Some how I need to figure out how to address the pre-empt and keep the
driver data stable.  Initially I would suggest throttling back on the
request size to maybe 4k or 8k regardless.  I may not sound right but it
will serve the purpose.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

