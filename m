Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265181AbTFYXKX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 19:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265188AbTFYXKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 19:10:23 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:56331 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S265181AbTFYXKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 19:10:18 -0400
Message-ID: <3EFA2F97.5000705@techsource.com>
Date: Wed, 25 Jun 2003 19:26:15 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Edward Tandi <ed@efix.biz>
CC: joe briggs <jbriggs@briggsmedia.com>,
       Artur Jasowicz <kernel@mousebusiness.com>,
       Brian Jackson <brian@brianandsara.net>,
       Bart SCHELSTRAETE <Bart.SCHELSTRAETE@dhl.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: AMD MP, SMP, Tyan 2466
References: <BB1F47F5.17533%kernel@mousebusiness.com>	 <200306251501.14207.jbriggs@briggsmedia.com>	 <1056567378.31260.9.camel@wires.home.biz> <3EFA2939.2060005@techsource.com> <1056583075.31265.22.camel@wires.home.biz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Edward Tandi wrote:
> On Wed, 2003-06-25 at 23:59, Timothy Miller wrote:
> 
>>
>>DDR memory works very much like single data rate, except that data is 
>>transferred (in whichever direction it's going) on both edges of the 
>>clock, thus doubling the transfer rate.  The memory does not switch 
>>between reading and writing as you describe it.
>>
>>I believe registering is for reliability.  Data is transferred one clock 
>>cycle later but reduces signal loading.
> 
> 
> Thanks for the clarification. I do not profess to be an expert in the
> technology. Two writes or a read+write per clock cycle is close enough
> for the purpose of the discussion.
> 
> The point I was trying to make is that the registers are there to deal
> with an SMP race condition of some sort. Athlon MP motherboards fitted
> with two processors will not work properly without 'registered' RAM. I
> have hard experience of this and it this experience I am sharing with
> someone who is seeing the same symptoms.


It is my understanding that the registered memory requirement has 
nothing to do with SMP but instead with the amount of memory you have. 
The more memory chips you have, the greater the signal loading on the 
memory bus.  More input drivers means more capacitance which means you 
need your output drivers to put out data sooner (relative to the clock 
edge, so registered delays by one clock) and stronger (greater drive 
strength).

In an SMP system (besides NUMA), multiple processors will talk to the 
same memory through a shared memory controller (like in a Northbridge), 
so although there are multiple processors, there is still only one 
memory bus.  Pulling off one CPU isn't going to change that situation.


