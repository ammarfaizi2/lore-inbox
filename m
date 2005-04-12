Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262072AbVDLJ2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbVDLJ2r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 05:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbVDLJ2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 05:28:47 -0400
Received: from unthought.net ([212.97.129.88]:15545 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S262072AbVDLJ2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 05:28:45 -0400
Date: Tue, 12 Apr 2005 11:28:43 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Greg Banks <gnb@melbourne.sgi.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bdflush/rpciod high CPU utilization, profile does not make sense
Message-ID: <20050412092843.GB17359@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Greg Banks <gnb@melbourne.sgi.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050409213549.GW347@unthought.net> <1113083552.11982.17.camel@lade.trondhjem.org> <20050411074806.GX347@unthought.net> <1113222939.14281.17.camel@lade.trondhjem.org> <20050411134703.GC13369@unthought.net> <1113230125.9962.7.camel@lade.trondhjem.org> <20050411144127.GE13369@unthought.net> <1113232905.9962.15.camel@lade.trondhjem.org> <20050411154211.GG13369@unthought.net> <1113267809.1956.242.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113267809.1956.242.camel@hole.melbourne.sgi.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 11:03:29AM +1000, Greg Banks wrote:
> On Tue, 2005-04-12 at 01:42, Jakob Oestergaard wrote:
> > Yes, as far as I know - the Broadcom Tigeon3 driver does not have the
> > option of enabling/disabling RX polling (if we agree that is what we're
> > talking about), but looking in tg3.c it seems that it *always*
> > unconditionally uses NAPI...
> 
> I've whined and moaned about this in the past, but for all its
> faults NAPI on tg3 doesn't lose packets.  It does cause a huge
> increase in irq cpu time on multiple fast CPUs.  What irq rate
> are you seeing?

Around 20.000 interrupts per second during the large write, on the IRQ
where eth0 is (this is not shared with anything else).

[sparrow:joe] $ cat /proc/interrupts
           CPU0       CPU1
...
169:    3853488  412570512   IO-APIC-level  eth0
...


But still, guys, it is the *same* server with tg3 that runs well with a
2.4 client but poorly with a 2.6 client.

Maybe I'm just staring myself blind at this, but I can't see how a
general problem on the server (such as packet loss, latency or whatever)
would cause no problems with a 2.4 client but major problems with a 2.6
client.

-- 

 / jakob

