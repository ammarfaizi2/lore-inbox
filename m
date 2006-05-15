Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751617AbWEORkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbWEORkJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 13:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbWEORkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 13:40:09 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:2964 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1751615AbWEORkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 13:40:07 -0400
Message-ID: <4468BCE3.3010005@myri.com>
Date: Mon, 15 May 2006 19:39:47 +0200
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Francois Romieu <romieu@fr.zoreil.com>, netdev@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>,
       "Andrew J. Gallatin" <gallatin@myri.com>
Subject: Re: [PATCH 4/6] myri10ge - First half of the driver
References: <446259A0.8050504@myri.com>	 <Pine.GSO.4.44.0605101438410.498-100000@adel.myri.com>	 <20060510231347.GC25334@electric-eye.fr.zoreil.com>	 <4463CE88.20301@myri.com> <1147712555.27252.269.camel@mindpipe>
In-Reply-To: <1147712555.27252.269.camel@mindpipe>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Fri, 2006-05-12 at 01:53 +0200, Brice Goglin wrote:
>   
>> Francois Romieu wrote:
>>     
>>>> +	spin_lock(&mgp->cmd_lock);
>>>> +	response->result = 0xffffffff;
>>>> +	mb();
>>>> +	myri10ge_pio_copy((void __iomem *) cmd_addr, buf, sizeof (*buf));
>>>> +
>>>> +	/* wait up to 2 seconds */
>>>>     
>>>>         
>>> You must not hold a spinlock for up to 2 seconds.
>>>   
>>>       
>> We are working on reducing the delay to about 15ms. It only occurs when
>> the driver is loaded or the link brought up.
>>     
>
> I think 15ms is quite a long time to hold a spinlock also - most
> spinlocks in the kernel are held for less than 500 microseconds.
>
> Can't you use a mutex?
>   

It looks like rtnl_lock protects us here. We are working on it.

Brice

