Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266518AbUBLQzt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 11:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266522AbUBLQzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 11:55:49 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:43188 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S266518AbUBLQzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 11:55:45 -0500
From: Michael Frank <mhf@linuxmail.org>
To: Nick Piggin <piggin@cyberone.com.au>, Giuliano Pochini <pochini@shiny.it>
Subject: Re: ext2/3 performance regression in 2.6 vs 2.4 for small interl
Date: Fri, 13 Feb 2004 01:05:20 +0800
User-Agent: KMail/1.5.4
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
References: <XFMail.20040212104215.pochini@shiny.it> <402B5502.2010207@cyberone.com.au>
In-Reply-To: <402B5502.2010207@cyberone.com.au>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402130105.22554.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 February 2004 18:27, Nick Piggin wrote:
> 
> Giuliano Pochini wrote:
> 
> >On 12-Feb-2004 Andrea Arcangeli wrote:
> >
> >
> >>the main difference is that 2.4 isn't in function of time, it's in
> >>function of requests, no matter how long it takes to write a request,
> >>so it's potentially optimizing slow devices when you don't care about
> >>latency (deadline can be tuned for each dev via
> >>/sys/block/*/queue/iosched/).
> >>
> >
> >IMHO it's the opposite. Transfer speed * seek time of some
> >slow devices is lower than fast devices. For example:
> >
> >Hard disk  raw speed= 40MB/s   seek time =  8ms
> >MO/ZIP     raw speed=  3MB/s   seek time = 25ms
> >
> >
> 
> I like accounting by time better because its accurate
> and fair for all types of devices, however I admit an
> auto tuning feature would be nice.
> 
> Say you allow 16 128K requests before seeking:
> The HD will run the requests for 50ms then seek (8ms).
> So this gives you about 86% efficiency.
> On your zip drive it takes 666ms, giving you 96%.
> 
> Now with AS, allowing 50ms of requests before a seek
> gives you the same for an HD, but only 66% for the MO
> drive. A CD-ROM will be much worse.
> 
> Auto tuning wouldn't be too hard. Just measure the time
> it takes for your seeking requests to complete and you
> can use the simple formula to allow users to specify a
> efficiency vs latency %age.
> 

This triggers me to ask about "io niceness" which has been on 
my mind for some time.

A disk intensive example is updatedb, which since the earlier 
days of linux on [34]86s, is usually reniced at 19. At that time a 
CPU did 10-50 bogomips and disks transfered  5-20MB at seek times of 
10ms or so.

Today, CPU's are 100 times as fast but disks are effectively only 
2-5 times as fast.

What I am getting at is being annoyed with updatedb ___saturating___ 
the the disk so easily as the "ancient" method of renicing does not 
consider the fact that the CPU pwrformance has increased 20-50 fold 
over disk performace.

Bottom line: what about assigning "io niceness" to processes, which
would also help with actively scheduling io toward processes 
needing it.

Michael

