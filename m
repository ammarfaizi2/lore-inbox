Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267678AbUG3M47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267678AbUG3M47 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 08:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267669AbUG3M47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 08:56:59 -0400
Received: from posti5.jyu.fi ([130.234.4.34]:42689 "EHLO posti5.jyu.fi")
	by vger.kernel.org with ESMTP id S267680AbUG3M4j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 08:56:39 -0400
Date: Fri, 30 Jul 2004 15:56:10 +0300 (EEST)
From: Pasi Sjoholm <ptsjohol@cc.jyu.fi>
X-X-Sender: ptsjohol@silmu.st.jyu.fi
To: Robert Olsson <Robert.Olsson@data.slu.se>
cc: Francois Romieu <romieu@fr.zoreil.com>,
       H?ctor Mart?n <hector@marcansoft.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <netdev@oss.sgi.com>, <brad@brad-x.com>, <shemminger@osdl.org>
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic (maybe
 RLT-8139 related)
In-Reply-To: <16650.4736.456106.603065@robur.slu.se>
Message-ID: <Pine.LNX.4.44.0407301530130.23039-100000@silmu.st.jyu.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Checked: by miltrassassin
	at posti5.jyu.fi; Fri, 30 Jul 2004 15:56:15 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jul 2004, Robert Olsson wrote:

> You should monitor the the user app (gettimeofday()monitoring for starvation
> this is the most important measure and what we are trying to improve.

I can do that after couple of days.. I have to get married tomorrow and 
spend some time with my wife. =)
 
> We can hardly expect softirq's alone to give us the balance of load we wish. 
> At overload something has to get less resources. Even we defer all softirq's 
> to scheduler context there is no way making any distinguish between them 
> unless we run them in separate processes i.e one RX_SOFIRQ, TX_SOFIRQ etc. 
> This could solve some problem I just discussed with Jamal where the RX 
> softirq overruns the TX softirq and causes drop at egress (qdisc) when bus 
> BW is saturated. Running softirq's under schedules context's can cause other 
> delays and other problems.

Ok, I understand that you can't do 110% if you have only 100% so someone 
has to wait. It would not matter if networks speed would slow down to 
1/100 from the maximum speed if it would still somehow work and not 
crashing the whole userspace.

I don't remember if I have said this but when the ksoftirqd has started to 
take all the cpu-time there is no way to stop it excluding booting 
computer. You can kill or stop all the processes which are taking your 
cpu-time (ie. source compiling) but network wont start to work or neither 
there is no free cpu-time for use because ksoftirqd won't stop eating it.

Actually, for now I would not care how much the kernel would slow down but 
we have to get some stability. Restarting your computer everytime this 
happens is not a solution.

> So most ksoftirq's runs most softirq's which is good. Without this you would 
> not be able to type any commands at all. Also we see some effects from the 
> path. Can you monitor userland starvation here too?

Sure.. 

> > - When the ksoftirqd starts to eat cpu-time time_squeeze-value (3rd 
> > column) starts growing (in both cases it's same thing). 
> This OK as we have to throttle.

Sure, but we should not crash the whole userspace. Why does kernel 
suddenly think that it won't give any time for softirq's. Or it 
does because I can write commands and etc. but the network won't work at all.
 
> > - Total-column's value stops growing although network file transfers 
> > are still on. (1st column)
> Well ksoftirqd now runs RX softirq and competes heavily with other processes 
> for your CPU you may have to adjust priorities to get your desired balance.
> Can you experiment a bit?

There is nothing to priorise after I have killed/quitted the jobs which we 
taking all the cpu-time. Nothing more left than ksoftirqd and it will eat 
all the cpu-time.

Of course I could try something like "nice make -j3" and see if it will 
still do the same shit.
  
--
Pasi Sjöholm

