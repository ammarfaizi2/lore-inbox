Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265993AbUGILYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265993AbUGILYq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 07:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265994AbUGILYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 07:24:45 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:40546 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265993AbUGILYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 07:24:42 -0400
Message-ID: <40EE8075.6060700@yahoo.com.au>
Date: Fri, 09 Jul 2004 21:24:37 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: FabF <fabian.frederick@skynet.be>
CC: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       nigelenki@comcast.net, linux-kernel@vger.kernel.org
Subject: Re: Autoregulate swappiness & inactivation
References: <40EC13C5.2000101@kolivas.org> <40EC1930.7010805@comcast.net>	 <40EC1B0A.8090802@kolivas.org> <20040707213822.2682790b.akpm@osdl.org>	 <cone.1089268800.781084.4554.502@pc.kolivas.org>	 <20040708001027.7fed0bc4.akpm@osdl.org>	 <cone.1089273505.418287.4554.502@pc.kolivas.org>	 <20040708010842.2064a706.akpm@osdl.org>	 <cone.1089275229.304355.4554.502@pc.kolivas.org>	 <1089284097.3691.52.camel@localhost.localdomain>	 <40EDEF68.2020503@kolivas.org>	 <1089366486.3322.10.camel@localhost.localdomain>	 <40EE76CC.5070905@yahoo.com.au> <1089371646.3322.38.camel@localhost.localdomain>
In-Reply-To: <1089371646.3322.38.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FabF wrote:
> On Fri, 2004-07-09 at 12:43, Nick Piggin wrote:

>>pdflush is used to perform writeout of dirty data, so it has
>>no part in reducing Mozilla's RSS.
> 
> Oops ... kswapd then ?
> 

Yep.

> 
>>I don't really understand what you are asking though. Your basic
>>problem is that mozilla's resident memory gets evicted too easily,
>>is that right?
>>
> 
> Not at all.My problem is mozilla has some MB to recover when
> reactivating; meanwhile, I consider there was sufficient resource to
> share with it _before_ reactivation as I'm waiting some minutes after an
> heavy process (e.g updatedb) to be done and over.
> 

You could try my -np7 patch, which would hopefully fix the problem
for you.

It may take some time and work before (if ever) the memory management
patches in it are merged though.

> AFAICS, Con's patches are about auto-regulation, not about anticipation
> (?)
> 

Yep. Con's patch changes the conditions that are required to start
reclaiming mapped pages. Basically: when to start swapping.
