Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267938AbTB1PHZ>; Fri, 28 Feb 2003 10:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267941AbTB1PHZ>; Fri, 28 Feb 2003 10:07:25 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:58641 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267938AbTB1PHY>; Fri, 28 Feb 2003 10:07:24 -0500
Date: Fri, 28 Feb 2003 16:17:45 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Software Suspend Functionality in 2.5
Message-ID: <20030228151744.GB14927@atrey.karlin.mff.cuni.cz>
References: <1046238339.1699.65.camel@laptop-linux.cunninghams> <20030227181220.A3082@in.ibm.com> <1046369790.2190.9.camel@laptop-linux.cunninghams> <20030228121725.B2241@in.ibm.com> <20030228130548.GA8498@atrey.karlin.mff.cuni.cz> <20030228190924.A3034@in.ibm.com> <20030228134406.GA14927@atrey.karlin.mff.cuni.cz> <20030228204831.A3223@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030228204831.A3223@in.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Atomic snapshots are what we'd like for dump too, since we desire 
> > > accurate dumps (minimum drift), so its not a conflicting requirement. 
> > > The difference is that while you could do i/o (e.g to flush pages 
> > > to free up memory) before initiating an atomic snapshot, we can't.
> > 
> > OTOH "best-effort-atomic" is probably okay for you, while it is not
> > acceptable for swsusp. Hopefully the code is not going to get too
> > complicated by "must be atomic" and "must work with crashed system"
> > requirements...
> > 
> For the kind of atomicity you need there probably are two
> steps:
> 1) Quiesce the system - get to a point of consistency (when you
>    can take a resumable snapshot)
> 2) Perform an atomic copy / snapshot
> 
> Step (1) would be different for swsusp and crash dump (not
> intended to be common ). But for Step (2), do you think
> what you need/do is complicated by crashed system requirements ?

Well, I guess count_and_copy_data_pages() is easy to share, OTOH it is
really small piece of code. Also do you think you can free half of
memory in crashed system? Thats what swsusp currently does...

[I need really little about LKCD... But you are going to need modified
disk drivers etc, right? I'd like to get away without that in swsusp,
at least in 2.6.X.]

								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
