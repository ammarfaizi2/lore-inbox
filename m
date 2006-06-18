Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWFRDQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWFRDQx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 23:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbWFRDQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 23:16:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65426 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751076AbWFRDQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 23:16:52 -0400
Message-ID: <4494C592.6090601@osdl.org>
Date: Sat, 17 Jun 2006 20:16:34 -0700
From: Stephen Hemminger <shemminger@osdl.org>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Harry Edmon <harry@atmos.washington.edu>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
References: <4492D5D3.4000303@atmos.washington.edu>	<20060617153511.53a129a3.akpm@osdl.org>	<44948EF6.1060201@atmos.washington.edu> <20060617165611.2c478723.akpm@osdl.org>
In-Reply-To: <20060617165611.2c478723.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Sat, 17 Jun 2006 16:23:34 -0700
> Harry Edmon <harry@atmos.washington.edu> wrote:
>
>   
>> Andrew Morton wrote:
>>     
>>> On Fri, 16 Jun 2006 09:01:23 -0700
>>> Harry Edmon <harry@atmos.washington.edu> wrote:
>>>
>>>       
>>>> I have a system with a strange network performance degradation from 
>>>> 2.6.11.12 to most recent kernels including 2.6.16.20 and 2.6.17-rc6.   
>>>> The system is has Dual single core Xeons with hyperthreading on.   The 
>>>> application is the LDM system from UCAR/Unidata 
>>>> (http://www.unidata.ucar.edu/software/ldm).   This system requests 
>>>> weather data from a variety of systems using RPC calls over a reserved 
>>>> TCP port (388), puts them into a memory mapped queue file, and then 
>>>> sends the data out to a variety of downstream requesting systems, again 
>>>> using RPC calls.  When the load is heavy, the 2.6.16.20 kernel falls way 
>>>> behind with the data ingestion.  The 2.6.11.12 kernel does not.   I have 
>>>> tried an experiment with a 2.6.17-rc6 system where it just does the 
>>>> ingestion, and not the downstream distribution, and it is able to keep 
>>>> up.   I would really appreciate any pointers as to where the problem may 
>>>> be and how to diagnose it.  I have attached the config files from both 
>>>> kernels and the sysctl.conf file I am using.   I have also included the 
>>>> output from "netstat -s" on the 2.6.16.20 system during a time when it 
>>>> was having problems.
>>>>
>>>>         
>>> (added netdev)
>>>
>>> A quick grep indicates that it isn't using TCP_NODELAY - we've had problems
>>> with that in the past.
>>>
>>> Perhaps a tcpdump of the net traffic will help to determine what's going on.
>>>       
>
> [ edit, edit - please don't top-post ]
>
>   
>> I assume you are talking about using TCP_NODELAY as a socket option within the 
>> LDM software.  I could give that a try.
>>     
>
> The use of TCP_NODELAY caused problems with the JVM debugger.  I'm not
> suggesting that enabling it will fix anything here.
>
>   
>> There is a lot of traffic on this node, on the order of 2000 packets in and out 
>> per second, so the tcpdump output will grow pretty fast.  How long a tcpdump 
>> would be useful, and what options would you suggest?
>>     
>
> I don't know, frankly - first one needs to develop some sort of theory,
> then use the diagnostic tools to prove or disprove that theory.  And I
> don't have a theory.
>
> I guess a simple one-second bare `tcpdump -i eth0' would be a starting
> point.  Perhaps compare the output of that with the output from a
> correctly-operating kernel, see if anything suggests itself.  That might
> also give us something which the networking developers can use.
>
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   
Does this fix it?
    # sysctl -w net.ipv4.tcp_abc=0

