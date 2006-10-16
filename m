Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422841AbWJPTJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422841AbWJPTJT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 15:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422845AbWJPTJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 15:09:19 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:45495 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422841AbWJPTJS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 15:09:18 -0400
Subject: Re: [PATCH] i386 Time: Avoid PIT SMP lockups
From: john stultz <johnstul@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200610162042.27292.ak@suse.de>
References: <1160596462.5973.12.camel@localhost.localdomain>
	 <p73odsccqy5.fsf@verdi.suse.de> <20061016113937.a76f8d06.akpm@osdl.org>
	 <200610162042.27292.ak@suse.de>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 12:09:14 -0700
Message-Id: <1161025754.5442.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-16 at 20:42 +0200, Andi Kleen wrote:
> On Monday 16 October 2006 20:39, Andrew Morton wrote:
> > On 16 Oct 2006 15:48:02 +0200
> > Andi Kleen <ak@suse.de> wrote:
> > 
> > > Andrew Morton <akpm@osdl.org> writes:
> > > > 
> > > > Is there any actual need to hold xtime_lock while doing the port IO?  I'd
> > > > have thought it would suffice to do
> > > > 
> > > > 	temp = port_io
> > > > 	write_seqlock(xtime_lock);
> > > > 	xtime = muck_with(temp);
> > > > 	write_sequnlock(xtime_lock);
> > > > 
> > > > ?
> > > 
> > > That would be a good idea in general. The trouble is just that whatever race
> > > is there will be still there then, just harder to trigger (so instead of 
> > > every third boot it will muck up every 6 weeks). Not sure that is
> > > a real improvement.

It is an interesting idea that could be applied generally. There might
be some small races possible (where the cycle_last grabed within
xtime_lock might be ahead of the value pulled from the port_io), but
I'll put some time into seeing if it will work.


> > Confused.  What race are you referring to?
> 
> Sorry s/race/starvation/
> 
> > 
> > This is addressing a starvation problem which is due to the slowness of the
> > port-io (iirc).
> 
> Is it just sure to go away when the critical section is shorter?

Yea. I don't see the box hangs when the portio is removed. Although I
don't really feel I've narrowed it down completely to the starvation
theory. Its just the best theory I've got so far.

Currently my test box is busy with other things, but as soon as its free
I'll put some more time into this one.

thanks
-john

