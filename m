Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVCNEk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVCNEk1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 23:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVCNEk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 23:40:27 -0500
Received: from smtp110.mail.sc5.yahoo.com ([66.163.170.8]:21343 "HELO
	smtp110.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261248AbVCNEkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 23:40:19 -0500
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Christian Schmid <webmaster@rapidforum.com>
Cc: Ben Greear <greearb@candelatech.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4231F112.60403@rapidforum.com>
References: <4229E805.3050105@rapidforum.com>
	 <422BAAC6.6040705@candelatech.com>	<422BB548.1020906@rapidforum.com>
	 <422BC303.9060907@candelatech.com>	<422BE33D.5080904@yahoo.com.au>
	 <422C1D57.9040708@candelatech.com>	<422C1EC0.8050106@yahoo.com.au>
	 <422D468C.7060900@candelatech.com>	<422DD5A3.7060202@rapidforum.com>
	 <422F8A8A.8010606@candelatech.com>	<422F8C58.4000809@rapidforum.com>
	 <422F9259.2010003@candelatech.com>	<422F93CE.3060403@rapidforum.com>
	 <20050309211730.24b4fc93.akpm@osdl.org> <4231B95B.6020209@rapidforum.com>
	 <4231ED18.2050804@candelatech.com>  <4231F112.60403@rapidforum.com>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 15:40:15 +1100
Message-Id: <1110775215.5131.17.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-11 at 20:27 +0100, Christian Schmid wrote:
> Ben Greear wrote:
> > 
> > For what it's worth, I was running dual-xeon systems with HT turned on.
> > 
> > But, I have a single process, single-threaded application, so there is 
> > not much
> > scheduling to be done.  If you have a large number of threads or processes,
> > then it would make more sense for turning off HT to have an affect.
> 
> This effect appeared on 1 task and on 200 tasks. I dont know what it is, but with HT off it doesnt 
> appear anymore. The slow-down still appears when lower_zone_protection is set to 0 but the peak at 
> 80 MB disappeared when set to 1024. I am now running at 95 MB/Sec smoothly.
> 

OK well that is a good result for you. Thanks for sticking with it.
Unfortunately you'll probably not want to test any patches on your
production system, so the cause of the problem will be difficult to
fix.

I am working on patches which improve HT performance in some
situations though, so with luck they will cure your problems too.
Basically I think SMP "balancing" is too aggressive - and this may
explain why 2.6.10 was worse for you, it had patches to *increase*
the aggressiveness of balancing.

The other thing that worries me is your need for lower_zone_protection.
I think this may be due to unbalanced highmem vs lowmem reclaim. It
would be interesting to know if those patches I sent you improve this.
They certainly improve reclaim balancing for me... but again I guess
you'll be reluctant to do much experimentation :\

Thanks,
Nick



