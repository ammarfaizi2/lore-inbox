Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVAHVit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVAHVit (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 16:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVAHVit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 16:38:49 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:29353 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261624AbVAHVir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 16:38:47 -0500
Subject: Re: Make pipe data structure be a circular list of pages, rather
	than
From: Lee Revell <rlrevell@joe-job.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Mike Waychison <Michael.Waychison@Sun.COM>,
       Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41DF1F3D.3030006@nortelnetworks.com>
References: <41DE9D10.B33ED5E4@tv-sign.ru>
	 <Pine.LNX.4.58.0501070735000.2272@ppc970.osdl.org>
	 <1105113998.24187.361.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0501070923590.2272@ppc970.osdl.org>
	 <Pine.LNX.4.58.0501070936500.2272@ppc970.osdl.org> <41DEF81B.60905@sun.com>
	 <41DF1F3D.3030006@nortelnetworks.com>
Content-Type: text/plain
Date: Sat, 08 Jan 2005 16:38:45 -0500
Message-Id: <1105220326.24592.98.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-07 at 17:46 -0600, Chris Friesen wrote:
> Mike Waychison wrote:
> 
> > This got me to thinking about how you can heuristically optimize away
> > coalescing support and still allow PAGE_SIZE bytes minimum in the
> > effective buffer.
> 
> While coalescing may be a win in some cases, there should also be some 
> way to tell the kernel to NOT coalesce, to handle the case where you 
> want minimum latency at the cost of some throughput.

Many latency critical apps use (tmpfs mounted) FIFO's for IPC; the Linux
FIFO being one of the fastest known IPC mechanisms.  Each client in the
JACK (http://jackit.sf.net) graph wakes the next one by writing a single
byte to a FIFO.  Ardour's GUI, control, and audio threads interact via a
similar mechanism.  How would you expect this change to impact the inter
thread wakeup latency?  It's confusing when people say "performance",
meaning "increased throughput albeit with more latency".  For many
people that's a regression.

These apps *certainly* care about performance, they just don't define it
in terms of throughput.

And yes we do know futexes are the right tool for this but they weren't
available at the time and aren't available on 2.4.

Lee

