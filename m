Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbVLZRjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbVLZRjr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 12:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbVLZRjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 12:39:47 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:51692 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932070AbVLZRjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 12:39:46 -0500
Subject: Re: [patch 0/9] mutex subsystem, -V4
From: Lee Revell <rlrevell@joe-job.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       mingo@elte.hu, zippel@linux-m68k.org, hch@infradead.org,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, arjanv@infradead.org, nico@cam.org,
       jes@trained-monkey.org, zwane@arm.linux.org.uk, oleg@tv-sign.ru,
       dhowells@redhat.com, bcrl@kvack.org, rostedt@goodmis.org, ak@suse.de,
       rmk+lkml@arm.linux.org.uk
In-Reply-To: <5.2.1.1.2.20051226175652.00be31b8@pop.gmx.net>
References: <1135593776.2935.5.camel@laptopd505.fenrus.org>
	 <20051222114147.GA18878@elte.hu> <20051222153014.22f07e60.akpm@osdl.org>
	 <20051222233416.GA14182@infradead.org>
	 <200512251708.16483.zippel@linux-m68k.org>
	 <20051225150445.0eae9dd7.akpm@osdl.org> <20051225232222.GA11828@elte.hu>
	 <20051226023549.f46add77.akpm@osdl.org>
	 <1135593776.2935.5.camel@laptopd505.fenrus.org>
	 <5.2.1.1.2.20051226175652.00be31b8@pop.gmx.net>
Content-Type: text/plain
Date: Mon, 26 Dec 2005 12:44:52 -0500
Message-Id: <1135619093.8293.43.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-26 at 18:15 +0100, Mike Galbraith wrote:
> At 03:11 AM 12/26/2005 -0800, Andrew Morton wrote:
> >Arjan van de Ven <arjan@infradead.org> wrote:
> > >
> > >
> > > > hm.  16 CPUs hitting the same semaphore at great arrival rates.  The cost
> > > > of a short spin is much less than the cost of a sleep/wakeup.  The 
> > machine
> > > > was doing 100,000 - 200,000 context switches per second.
> > >
> > > interesting.. this might be a good indication that a "spin a bit first"
> > > mutex slowpath for some locks might be worth implementing...
> >
> >If we see a workload which is triggering such high context switch rates,
> >maybe.  But I don't think we've seen any such for a long time.
> 
> Hmm.  Is there a real workload where such a high context switch rate is 
> necessary?  Every time I've seen a high (100,000 - 200,000 is beyond absurd 
> on my little box, but...) context switch rate, it's been because something 
> sucked.

I can trivially produce 20K per second on my little sub Ghz box so 100K
on a busy server is certainly plausible.  Especially if for the purposes
of this discussion we are also worried about -rt + IRQ threading where
each IRQ costs two context switches (more if it raises a softirq).

Lee

