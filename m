Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265137AbUGIKnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265137AbUGIKnl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 06:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265163AbUGIKnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 06:43:41 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:61294 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265137AbUGIKna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 06:43:30 -0400
Message-ID: <40EE76CC.5070905@yahoo.com.au>
Date: Fri, 09 Jul 2004 20:43:24 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: FabF <fabian.frederick@skynet.be>
CC: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       nigelenki@comcast.net, linux-kernel@vger.kernel.org
Subject: Re: Autoregulate swappiness & inactivation
References: <40EC13C5.2000101@kolivas.org> <40EC1930.7010805@comcast.net>	 <40EC1B0A.8090802@kolivas.org> <20040707213822.2682790b.akpm@osdl.org>	 <cone.1089268800.781084.4554.502@pc.kolivas.org>	 <20040708001027.7fed0bc4.akpm@osdl.org>	 <cone.1089273505.418287.4554.502@pc.kolivas.org>	 <20040708010842.2064a706.akpm@osdl.org>	 <cone.1089275229.304355.4554.502@pc.kolivas.org>	 <1089284097.3691.52.camel@localhost.localdomain>	 <40EDEF68.2020503@kolivas.org> <1089366486.3322.10.camel@localhost.localdomain>
In-Reply-To: <1089366486.3322.10.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FabF wrote:

> 
> Here's an easy benchmark to demonstrate problem :
> 1.Run Mozilla
> 2.Minimize
> 3=>Mozilla Resident Size (mrs) : 24Mb
> 4.Run updatedb
> 5.=>mrs : 15Mb
> 6.updatedb ends up
> 7.mrs doesn't move at all (yes, it goes down as I'm typing this msg :)).
> 

How much RAM do you have? Does this happen with and without Con's
patch?

I don't have a problem here with your problem, however I'm running
my -np patchset, which has different use-once heuristics.

> So my question is :
> Don't we have a way to say "whose pages were reclaimed from and
>  reattribute its" ? (having in mind memory status per se).
> IOW flushing (I guess it's pdflush relevant ? ) do work for dead
> processes but doesn't care about applications alive...
> 

Page reclaim doesn't really know or care about processes, it
basically works on a global page pool.

pdflush is used to perform writeout of dirty data, so it has
no part in reducing Mozilla's RSS.

I don't really understand what you are asking though. Your basic
problem is that mozilla's resident memory gets evicted too easily,
is that right?
