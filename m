Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266576AbUBLUmO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 15:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266578AbUBLUmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 15:42:14 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:11012 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S266576AbUBLUmJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 15:42:09 -0500
Date: Thu, 12 Feb 2004 21:55:03 +0100
To: Valdis.Kletnieks@vt.edu
Cc: Michael Frank <mhf@linuxmail.org>, Nick Piggin <piggin@cyberone.com.au>,
       Giuliano Pochini <pochini@shiny.it>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: ext2/3 performance regression in 2.6 vs 2.4 for small interl
Message-ID: <20040212205503.GA13934@hh.idb.hist.no>
References: <XFMail.20040212104215.pochini@shiny.it> <402B5502.2010207@cyberone.com.au> <200402130105.22554.mhf@linuxmail.org> <200402121718.i1CHITFf018390@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402121718.i1CHITFf018390@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 12, 2004 at 12:18:29PM -0500, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 13 Feb 2004 01:05:20 +0800, Michael Frank said:
> 
> > What I am getting at is being annoyed with updatedb ___saturating___ 
> > the the disk so easily as the "ancient" method of renicing does not 
> > consider the fact that the CPU pwrformance has increased 20-50 fold 
> > over disk performace.
> > 
> > Bottom line: what about assigning "io niceness" to processes, which
> > would also help with actively scheduling io toward processes 
> > needing it.
> 
> The problem is that unlike CPU niceness, where you can literally rip the
> CPU away from a hog and give it to some more deserving process, it's not
> as easy to rip an active disk I/O away so somebody else can have it.
> 
You can't take the disk away, but you can be careful with it.
The anticipatory scheduler already does that - avoids seeking
away from a read for a while just in case the reader will submit
an adjacent read in short order. (Wonder if it ought to read ahead
a little instead of just waiting?)

Something similiar could be done for io niceness.  If we run out of
normal priority io, how about not issuing the low priority io
right away.  Anticipate there will be more high-priority io
and wait for some idle time before letting low-priority
requests through.  And of course some maximum wait to prevent
total starvation.

> If the updatedb issues a seek/read combo to the disk, and your process gets
> into the I/O queue even 200 nanoseconds later, it *still* has to wait for that
> I/O to finish before it can start its seeks and reads.
> 
Anticipatory io niceness might solve that.

> For an extreme example, consider those IDE interfaces where fixating or
> blanking a CD/RW will cause *all* the disks to lock up for the duration.
> No matter how high your priority is, you *cant* get that I/O out the door
> for the next 60-70 seconds unless you're willing to create a coaster.

There's no cure for truely stupid hw.  Sometimes I forget why I buy
these expensive scsi drives . . .  


Helge Hafting
