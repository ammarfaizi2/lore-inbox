Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263305AbTCNNDz>; Fri, 14 Mar 2003 08:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263312AbTCNNDz>; Fri, 14 Mar 2003 08:03:55 -0500
Received: from chaos.analogic.com ([204.178.40.224]:12673 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S263305AbTCNNDx>; Fri, 14 Mar 2003 08:03:53 -0500
Date: Fri, 14 Mar 2003 08:16:18 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: latten@austin.ibm.com
cc: linux-kernel@vger.kernel.org
Subject: Re: eth0: Bus master arbitration failure
In-Reply-To: <200303132300.h2DN0M4k020390@faith.austin.ibm.com>
Message-ID: <Pine.LNX.3.95.1030314080825.4091A-100000@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Mar 2003 latten@austin.ibm.com wrote:

> I was wondering if anyone knew if this had been resolved
> or see this problem too. I am having the same problem. 
> However, I am using 2.5.64 kernel and I have tried 
> both an eepro100 and a 3com-tornado ethernet card.
> 
> I use netperf to create a load of packets, and within minutes
> I receive a few "eth0: Bus master arbitration failure, status ffff"
> and then the machine locks up. (This seems to only happen
> with a heavy load.)
> 
> I have no problems when I use 2.4.18-3 smp kernel (Redhat 8.0)
> and I have also used a 2.4.19 kernel a while back with no problems.
> 
> I am using a 2-way IBM Netfinity 4500 and a 4-way xSeries 350.
> No problems on a uniprocessor.
> 
> Thanks, for any info.
> 
> Regards,
> Joy
> 
> >Hello Andrea,
> >About 4 hours of heavy load on 2 of my boxs lead to hard lockup.
> >Before the lockup there are a lot of messages like:
> >"eth0: Bus master arbitration failure, status ffff"
> >There is no such problems on 2.4.18rc2aa1 and 2.4.19rc1aa2
> >Both Systems are IBM Netfinity 5100.
> >

I think the problem is probably all those "printk()" calls
within timing-sensitive code (really). A Bus master arbitration
failure is supposed to result in a retry. It is not supposed to
be fatal. For kicks, just comment out the printk() and see if
the box starts to work. If that makes it work, an appropriate
permanent fix would be to just keep track of the number of
such failures just like the dropped-packet and collision count.

If removing the printk() doesn't fix it, there may be a retained
spin-lock on an error exit path.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


