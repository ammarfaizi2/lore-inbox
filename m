Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267310AbTAMIBk>; Mon, 13 Jan 2003 03:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267313AbTAMIBk>; Mon, 13 Jan 2003 03:01:40 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:44691 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267310AbTAMIBg>;
	Mon, 13 Jan 2003 03:01:36 -0500
Date: Mon, 13 Jan 2003 13:42:33 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andi Kleen <ak@muc.de>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Fixing the tty layer was Re: any chance of 2.6.0-test*?
Message-ID: <20030113081233.GA15525@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030110165441$1a8a@gated-at.bofh.it> <20030110165505$38d9@gated-at.bofh.it> <20030112094007$1647@gated-at.bofh.it> <m3iswuk7xm.fsf_-_@averell.firstfloor.org> <20030113064131.GB14996@in.ibm.com> <20030113072539.GA2197@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030113072539.GA2197@averell>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 08:25:39AM +0100, Andi Kleen wrote:
> > Oh, yes, I have spent hours and hours trying to untangle tty locking
> > and it isn't simple.
> 
> Oops. Could you quickly summarize your findings so far ?

I only found more confusions - I can't figure how tty_files list
is locked - sure files_lock is supposed to protect it but there
are deletions done without any lock. Another thing that needs
looking into is to avoid or reduce use of the tasklist_lock there.

> > What does that BKL protect ? I can't seem to ever figure our if
> > all the races are plugged or not.
> 
> Well, one has to start somewhere. Just starting by plugging most of the
> obvious races, then the more subtle ones can be attacked later.
> 
> The idea of the BKL was to protect the protect context code against
> itself (code lock) and also the few global data structures that 
> are only accessed from process context (like the tty drivers list)

In that case would it not be better to replace all BKLs by a single tty
lock ?

> 
> I attached my current patch, it isn't too well tested however and needs
> more work.
> 
> Mostly just adds lock_kernel()s to the high level code so far and a few comments.

Cool, I will start off by testing this stuff.

Thanks
Dipankar
