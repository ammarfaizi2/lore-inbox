Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278667AbRJ3XEY>; Tue, 30 Oct 2001 18:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278712AbRJ3XEQ>; Tue, 30 Oct 2001 18:04:16 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:33778
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S278667AbRJ3XD5>; Tue, 30 Oct 2001 18:03:57 -0500
Date: Tue, 30 Oct 2001 15:04:29 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Proposal For A More Scalable Scheduler ...
Message-ID: <20011030150429.E490@mikef-linux.matchmail.com>
Mail-Followup-To: Davide Libenzi <davidel@xmailserver.org>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20011030034058.B21884@mikef-linux.matchmail.com> <Pine.LNX.4.40.0110300900190.1495-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0110300900190.1495-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 09:02:54AM -0800, Davide Libenzi wrote:
> On Tue, 30 Oct 2001, Mike Fedyk wrote:
> 
> > On Mon, Oct 29, 2001 at 09:38:07PM -0800, Davide Libenzi wrote:
> > > 2) My Linux Scheduler Stuff Page:
> > > 	http://www.xmailserver.org/linux-patches/lnxsched.html
> > >
> >
> > Anyone know if this is preempt safe?  It's using processor specific lists,
> > and might not be.
> 
> Processor specific lists ?
> The mss scheduler patch in for x86 but it's trivial ( about 10 lines of
> code ) to port it to other arcs.
> 

>From the origional:
The proposed implementation uses a runqueue-per-cpu scheduler where,
inside each CPU, the scheduler code is exactly the same of the current one.
The big runqueue_lock has been substituted by locks that protects CPU run
queues.
By having separate run queues the length/cost of the goodness() loop
has been divided by N ( N == number of CPUs ) and the presence of
per-runqueue locks gives the scheduler a full parallelism between the CPUs.

-------------

Looking at this again, it probably is preempt safe... I probably merged it
wrong.

I'll try to fit it into my next kernel...
