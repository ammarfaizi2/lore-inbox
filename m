Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbVIOXLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbVIOXLK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 19:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbVIOXLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 19:11:09 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:9201 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1750896AbVIOXLH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 19:11:07 -0400
Subject: Re: 2.6.13-rt6, ktimer subsystem
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: george@mvista.com
Cc: tglx@linutronix.de, john stultz <johnstul@us.ibm.com>,
       Nish Aravamudan <nish.aravamudan@gmail.com>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>,
       "'high-res-timers-discourse@lists.sourceforge.net'" 
	<high-res-timers-discourse@lists.sourceforge.net>
In-Reply-To: <4329F733.2090604@mvista.com>
References: <20050913100040.GA13103@elte.hu>  <43287C52.7050002@mvista.com>
	 <1126751140.6509.474.camel@tglx.tec.linutronix.de>
	 <4329F733.2090604@mvista.com>
Content-Type: text/plain
Organization: MontaVista
Date: Thu, 15 Sep 2005 16:09:56 -0700
Message-Id: <1126825796.4576.31.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-15 at 15:35 -0700, George Anzinger wrote:
> 
> In the early HRT patches the whole timer list was replaced with a hashed 
> list.  It was O(N/M) on insertion where we could easily choose M (for a 
> while it was even a config option).  Removal was just an unlink, same as 
> the cascade list.
> 
> To be clear on my take on this, as I understand it the rblist is 
> something like O(N*somelog 2).  What is left out here is the fixed 
> overhead of F which is there even if N = 1.  So we have something like 
> (F+O(f(N)) for a list.  For the most part we don't look at F, but as 
> list complexity grows, it gets larger thus pushing out the cross over 
> point to a higher "N" when comparing two lists.  I considered the rbtree 
> when doing the secondary list for HRT and concluded that "N" was small 
> enough that a simple O(N/2) list would do just fine as it would only 
> contain timers set to expire in the next jiffie.

The fact that we know in advance that a system is only going to a very
small number of these timers should be noted. You could just use a
regular list , and limit the total number of timers . I would hesitate
to stick a big data structure in when your only dealing with one or two
timers on average..

George, what's largest number of highres timers that someone might
need/want?

Daniel

