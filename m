Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266070AbUAQQMX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 11:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266074AbUAQQMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 11:12:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27326 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266070AbUAQQMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 11:12:03 -0500
Subject: Re: smp dead lock of io_request_lock/queue_lock patch
From: Doug Ledford <dledford@redhat.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Arjan Van de Ven <arjanv@redhat.com>,
       Martin Peschke3 <MPESCHKE@de.ibm.com>, Jens Axboe <axboe@suse.de>,
       Peter Yao <peter@exavio.com.cn>, linux-kernel@vger.kernel.org,
       linux-scsi mailing list <linux-scsi@vger.kernel.org>, ihno@suse.de
In-Reply-To: <400951E0.9030509@tmr.com>
References: <20040112194829.A7078@infradead.org>
	 <1073937102.3114.300.camel@compaq.xsintricity.com>
	 <4006CB42.3040005@tmr.com>
	 <1074345146.13198.29.camel@compaq.xsintricity.com>
	 <400951E0.9030509@tmr.com>
Content-Type: text/plain
Message-Id: <1074355641.13198.32.camel@compaq.xsintricity.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Sat, 17 Jan 2004 11:07:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-01-17 at 10:16, Bill Davidsen wrote:
> Doug Ledford wrote:
> > On Thu, 2004-01-15 at 12:17, Bill Davidsen wrote:
> > 
> >>Doug Ledford wrote:
> >>
> >>
> >>>More or less.  But part of it also is that a lot of the patches I've
> >>>written are on top of other patches that people don't want (aka, the
> >>>iorl patch).  I've got a mlqueue patch that actually *really* should go
> >>>into mainline because it solves a slew of various problems in one go,
> >>>but the current version of the patch depends on some semantic changes
> >>>made by the iorl patch.  So, sorting things out can sometimes be
> >>>difficult.  But, I've been told to go ahead and do what I can as far as
> >>>getting the stuff out, so I'm taking some time to try and get a bk tree
> >>>out there so people can see what I'm talking about.  Once I've got the
> >>>full tree out there, then it might be possible to start picking and
> >>>choosing which things to port against mainline so that they don't depend
> >>>on patches like the iorl patch.
> >>
> >>If it leads to a more stable kernel, I don't see why iorl can't go in 
> >>(user perspective) because RH is going to maintain it instead of trying 
> >>to find a developer who is competent and willing to do the boring task 
> >>of backfitting bugfixes to sub-optimal code.
> > 
> > 
> > We actually intended to leave it out of RHEL3.  But, once we started
> > doing performance testing of RHEL3 vs. AS2.1, it was obvious that if we
> > didn't put the patch back in we could kiss all of our benchmark results
> > goodbye.  Seriously, it makes that much difference on server systems.
> 
> I'm running 30+ usenet servers, currently on older RH versions. Better 
> performance would certainly be a plus, although stability WRT lockups 
> has been an issue, as has operation when the number of threads gets very 
> high. First tests of RHEL looked very promising for stability, I'm 
> hoping to get the okay to do serious production testing next week.

Well, when you think about it, the iorl patch makes lockups less likely,
and when they do occur they are likely to effect a smaller subset of the
scsi subsystem.  When you have one lock and you get a lockup, the whole
system stops.  When you have one lock per device and one lock per
controller, when they deadlock, they only deadlock a subset of the scsi
subsystem.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc.
         1801 Varsity Dr.
         Raleigh, NC 27606


