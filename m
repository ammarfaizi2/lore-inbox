Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWDQRcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWDQRcQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 13:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWDQRcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 13:32:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36571 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751184AbWDQRcP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 13:32:15 -0400
Date: Mon, 17 Apr 2006 10:32:11 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: George Nychis <gnychis@cmu.edu>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: want to randomly drop packets based on percent
Message-ID: <20060417103211.24115952@localhost.localdomain>
In-Reply-To: <4443CAD1.9050701@cmu.edu>
References: <444345F9.4090100@cmu.edu>
	<20060417091915.67e28361@localhost.localdomain>
	<4444171B.90507@cmu.edu>
	<20060417094634.7191fea5@localhost.localdomain>
	<4443CAD1.9050701@cmu.edu>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

O
> >>>>I wanted to insert artificial packet loss based on a percent so i found:
> >>>>network emulab qdisc could do it, so i compiled support into the kernel 
> >>>>and tried:
> >>>>tc qdisc change dev eth0 root netem loss .1%
> >>>>        
> >>>>
> >             ^^^^^^
> >
> >You need to do add not change. Add will set the queue discipline
> >to netem (default is pfifo_fast).  Change is for changing netem parameters
> >after it is loaded.
> >
> >  
> >
> bahhh I see... the wiki has "change" instead of add.  Now i'm running 
> into another problem, I have an XCP qdisc that I have already added via:
> tc qdisc add dev ath0 root xcp capacity 54Mbit size 500
> 

Wiki reads as a set of examples.  First uses, "add" after that "change".


> therefore when I also try to incorperate loss:
> tcq disc add dev ath0 root netem loss .1%
> 
> I get:
> RTNETLINK answers: File exists
> 
> Is it possible to use two qdiscs on the same interface?
> 

No, but netem is "classful" so you can put xcp inside netem.
Look at the token bucket example on the wiki.
