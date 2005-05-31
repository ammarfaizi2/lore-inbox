Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261982AbVEaRTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbVEaRTU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 13:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbVEaRMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 13:12:20 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:38555 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S261994AbVEaQ77
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 12:59:59 -0400
Message-ID: <429C97EB.906@andrew.cmu.edu>
Date: Tue, 31 May 2005 12:59:23 -0400
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Nick Piggin <nickpiggin@yahoo.com.au>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <4299A98D.1080805@andrew.cmu.edu> <429ADEDD.4020805@yahoo.com.au> <429B1898.8040805@andrew.cmu.edu> <429B2160.7010005@yahoo.com.au> <20050530222747.GB9972@nietzsche.lynx.com> <429BBC2D.70406@yahoo.com.au> <20050531020957.GA10814@nietzsche.lynx.com> <429C2A64.1040204@andrew.cmu.edu> <429C2F72.7060300@yahoo.com.au> <429C4112.2010808@andrew.cmu.edu> <20050531111445.GA35122@muc.de>
In-Reply-To: <20050531111445.GA35122@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Are you sure it is not only disk IO? In theory updatedb shouldn't 
> need much CPU, but it eats a lot of memory and causes stalls 
> in the disk (or at least that was my interpration on the stalls I saw)
> If there is really a scheduling latency problem with updatedb
> then that definitely needs to be fixed in the stock kernel.

I don't know, Debian's updatedb always seemed to suck up most of the CPU 
for me.  I am using ReiserFS with tail-packing on, which certainly 
balances on the side of more CPU vs IO.  Also I wouldn't be surprised if 
other distros had some better approach than Debian's, which appears to 
be a series of "find | sort" commands.  As one would expect, find causes 
most of the system load and sort causes user load spikes.

That said, preempt-RT is certainly not free right now.  Sending network 
messages at 60Hz appears to load this 2GHz system by about 8%, while 
that workload barely shows up in stock.   I figure there's still some 
optimization work to be done, but obviously it's unlikely to ever be as 
  efficient as non-preempt-RT.  The more interesting question is whether 
it's any slower with the RT patch applied, but preemption turned off. 
 From the implementation approach, I don't think it will show any 
difference from stock, but it's certainly something we've got to test a 
fair amount to be sure.

  - Jim Bruce
