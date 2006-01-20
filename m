Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWATLGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWATLGO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 06:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWATLGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 06:06:14 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:38070 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750824AbWATLGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 06:06:13 -0500
Date: Fri, 20 Jan 2006 14:02:30 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: kus Kusche Klaus <kus@keba.com>
Cc: John Ronciak <john.ronciak@gmail.com>, Adrian Bunk <bunk@stusta.de>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       john.ronciak@intel.com, ganesh.venkatesan@intel.com,
       jesse.brandeburg@intel.com, netdev@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: My vote against eepro* removal
Message-ID: <20060120110230.GA24815@2ka.mipt.ru>
References: <AAD6DA242BC63C488511C611BD51F367323325@MAILIT.keba.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AAD6DA242BC63C488511C611BD51F367323325@MAILIT.keba.co.at>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 20 Jan 2006 14:02:31 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 11:19:20AM +0100, kus Kusche Klaus (kus@keba.com) wrote:
> From: Evgeniy Polyakov
> > Each MDIO read can take upto 2 msecs (!) and at least 20 
> > usecs in e100,
> > and this runs in timer handler.
> > Concider attaching (only compile tested) patch which moves 
> > e100 watchdog
> > into workqueue.
> 
> Hmmm, I don't think moving it around is worth the trouble
> (nevertheless, I will test later if I find time).
> 
> For a full preemption kernel, both timer code and workqueue code
> are executed in a thread of their own. If I know that there is a
> 500 us piece of code in either of them, I have to adjust the prio
> of the corresponding thread (and all others) accordingly anyway.
> 
> For a non-full preemption kernel, your patch moves the 500 us 
> piece of code from kernel to thread context, so it really 
> improves things. But is 500 us something to worry about in a
> non-full preemption kernel?

In the worst case it will be milliseconds, which is not very nice
timeout for timer handler...

P.S. above patch works without problems with my e100 card.

> -- 
> Klaus Kusche                 (Software Development - Control Systems)
> KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
> Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
> E-Mail: kus@keba.com                                WWW: www.keba.com

-- 
	Evgeniy Polyakov
