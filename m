Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263954AbTJOS3x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 14:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263945AbTJOS3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 14:29:08 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:45839 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263932AbTJOS1u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 14:27:50 -0400
Date: Wed, 15 Oct 2003 20:37:10 +0200
To: Greg Stark <gsstark@mit.edu>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, Joel Becker <Joel.Becker@oracle.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
Message-ID: <20031015183710.GA1371@hh.idb.hist.no>
References: <Pine.LNX.4.44.0310120909050.12190-100000@home.osdl.org> <878ynq3y7n.fsf@stark.dyndns.tv> <3F8A661B.80909@aitel.hist.no> <200310151525.40470.ioe-lkml@rameria.de> <87llrmbl1g.fsf@stark.dyndns.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87llrmbl1g.fsf@stark.dyndns.tv>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 11:03:23AM -0400, Greg Stark wrote:
> Ingo Oeser <ioe-lkml@rameria.de> writes:
> 
> > On Monday 13 October 2003 10:45, Helge Hafting wrote:
> > 
> > > This is easier than trying to tell the kernel that the job is
> > > less important, that goes wrong wether the job runs too much
> > > or too little.  Let that job  sleep a little when its services
> > > aren't needed, or when you need the disk bandwith elsewhere.
> 
> Actually I think that's exactly backwards. The problem is that if the
> user-space tries to throttle the process it doesn't know how much or when.
> The kernel knows exactly when there are other higher priority writes, it can
> schedule just enough writes from vacuum to not interfere.
> 
Isn't those higher-priority writes issued from userspace?
I am of course assuming that source for _everything_ is available.
So the process with the high-priority write can tell vacuum to
take a nap until its transaction completes.

> So if vacuum slept a bit, say every 64k of data vacuumed. It could end up
> sleeping when the disks are actually idle. Or it could be not sleeping enough
> and still be interfering with transactions.
> 
It can run at full speed normally, take voluntary pauses if it ever
detects a "nothing to do now" condition. And it can be paused
(forcibly or through cooperation) when there are important transactions
to sync. 

> Though actually this avenue has some promise. It would not be nearly as ideal
> as a kernel based solution that could take advantage of the idle times between
> transactions, but it would still work somewhat as a work-around.
> 
Don't that other process know when it is about to submit important transactions?

> > The questions are: How IO-intensive vacuum? How fast can a throttling
> > free disk bandwidth (and memory)?
> 

Helge Hafting
