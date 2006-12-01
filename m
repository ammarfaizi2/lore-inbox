Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759295AbWLAJxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759295AbWLAJxc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 04:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759296AbWLAJxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 04:53:31 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:58286 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1759295AbWLAJxa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 04:53:30 -0500
Date: Fri, 1 Dec 2006 12:53:07 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: David Miller <davem@davemloft.net>
Cc: nickpiggin@yahoo.com.au, mingo@elte.hu, wenji@fnal.gov, akpm@osdl.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] - Potential performance bottleneck for Linxu TCP
Message-ID: <20061201095306.GA21232@2ka.mipt.ru>
References: <20061130095232.GA8990@2ka.mipt.ru> <456EAD6E.6040709@yahoo.com.au> <20061130102205.GA20654@2ka.mipt.ru> <20061130.121443.116355312.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20061130.121443.116355312.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 01 Dec 2006 12:53:10 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2006 at 12:14:43PM -0800, David Miller (davem@davemloft.net) wrote:
> > It steals timeslices from other processes to complete tcp_recvmsg()
> > task, and only when it does it for too long, it will be preempted.
> > Processing backlog queue on behalf of need_resched() will break
> > fairness too - processing itself can take a lot of time, so process
> > can be scheduled away in that part too.
> 
> Yes, at this point I agree with this analysis.
> 
> Currently I am therefore advocating some way to allow
> full input packet handling even amidst tcp_recvmsg()
> processing.

Isn't it a step in direction of full tcp processing bound to process
context? :)

-- 
	Evgeniy Polyakov
