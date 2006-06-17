Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbWFQXXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWFQXXq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 19:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbWFQXXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 19:23:45 -0400
Received: from dew1.atmos.washington.edu ([128.95.89.41]:7818 "EHLO
	dew1.atmos.washington.edu") by vger.kernel.org with ESMTP
	id S1751069AbWFQXXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 19:23:45 -0400
Message-ID: <44948EF6.1060201@atmos.washington.edu>
Date: Sat, 17 Jun 2006 16:23:34 -0700
From: Harry Edmon <harry@atmos.washington.edu>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
References: <4492D5D3.4000303@atmos.washington.edu> <20060617153511.53a129a3.akpm@osdl.org>
In-Reply-To: <20060617153511.53a129a3.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.599 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I assume you are talking about using TCP_NODELAY as a socket option within the 
LDM software.  I could give that a try.

There is a lot of traffic on this node, on the order of 2000 packets in and out 
per second, so the tcpdump output will grow pretty fast.  How long a tcpdump 
would be useful, and what options would you suggest?

I should also note that my network interfaces are Intel, using the latest e1000 
driver.


Andrew Morton wrote:
> On Fri, 16 Jun 2006 09:01:23 -0700
> Harry Edmon <harry@atmos.washington.edu> wrote:
> 
>> I have a system with a strange network performance degradation from 
>> 2.6.11.12 to most recent kernels including 2.6.16.20 and 2.6.17-rc6.   
>> The system is has Dual single core Xeons with hyperthreading on.   The 
>> application is the LDM system from UCAR/Unidata 
>> (http://www.unidata.ucar.edu/software/ldm).   This system requests 
>> weather data from a variety of systems using RPC calls over a reserved 
>> TCP port (388), puts them into a memory mapped queue file, and then 
>> sends the data out to a variety of downstream requesting systems, again 
>> using RPC calls.  When the load is heavy, the 2.6.16.20 kernel falls way 
>> behind with the data ingestion.  The 2.6.11.12 kernel does not.   I have 
>> tried an experiment with a 2.6.17-rc6 system where it just does the 
>> ingestion, and not the downstream distribution, and it is able to keep 
>> up.   I would really appreciate any pointers as to where the problem may 
>> be and how to diagnose it.  I have attached the config files from both 
>> kernels and the sysctl.conf file I am using.   I have also included the 
>> output from "netstat -s" on the 2.6.16.20 system during a time when it 
>> was having problems.
>>
> 
> (added netdev)
> 
> A quick grep indicates that it isn't using TCP_NODELAY - we've had problems
> with that in the past.
> 
> Perhaps a tcpdump of the net traffic will help to determine what's going on.


-- 
  Dr. Harry Edmon			E-MAIL: harry@atmos.washington.edu
  206-543-0547				harry@u.washington.edu
  Dept of Atmospheric Sciences		FAX:	206-543-0308
  University of Washington, Box 351640, Seattle, WA 98195-1640
