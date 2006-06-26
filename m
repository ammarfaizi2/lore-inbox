Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWFZSAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWFZSAw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 14:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWFZSAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 14:00:51 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:25529 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932228AbWFZSAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 14:00:49 -0400
Message-ID: <44A020CD.30903@watson.ibm.com>
Date: Mon, 26 Jun 2006 14:00:45 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jay Lan <jlan@sgi.com>, jlan@engr.sgi.com, balbir@in.ibm.com,
       csturtiv@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com>	<20060609010057.e454a14f.akpm@osdl.org>	<448952C2.1060708@in.ibm.com>	<20060609042129.ae97018c.akpm@osdl.org>	<4489EE7C.3080007@watson.ibm.com>	<449999D1.7000403@engr.sgi.com>	<44999A98.8030406@engr.sgi.com>	<44999F5A.2080809@watson.ibm.com>	<4499D7CD.1020303@engr.sgi.com>	<449C2181.6000007@watson.ibm.com>	<20060623141926.b28a5fc0.akpm@osdl.org>	<449C6620.1020203@engr.sgi.com>	<20060623164743.c894c314.akpm@osdl.org>	<449CAA78.4080902@watson.ibm.com>	<20060623213912.96056b02.akpm@osdl.org>	<449CD4B3.8020300@watson.ibm.com>	<44A01A50.1050403@sgi.com> <20060626105548.edef4c64.akpm@osdl.org>
In-Reply-To: <20060626105548.edef4c64.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>On Mon, 26 Jun 2006 10:33:04 -0700
>Jay Lan <jlan@sgi.com> wrote:
>
>  
>
>>>Will that work for everyone ?
>>>      
>>>
>>As long as the per-pid delayacct struct has a pointer to the per-tgid
>>data struct and deoes not need to go through the loop on every exit.
>>    
>>
>
>My brain is wilting, and time is moving along.
>
>Balbir, are you able to summarise where we stand wrt
>per-task-delay-accounting-* now?
>  
>
Andrew,

I'm maintaining per-task delay accouting and taskstats interface patches 
so I'll take the liberty to reply :-)

>What problem have we identified?  How close are we to finding agreeable
>solutions to them?
>  
>
The main problems identified are:

1. extra sending of per-tgid stats on every thread exit
2. unnecessary send of per-tgid stats when there are no listeners
3. unnecessary linkage of delayacct accumalation into per-tgid stats 
with sending out of taskstats

All three have an acceptable solution.
1. & 3. are going to be addressed in a patch I'm sending out shortly.
2. in a separate patch also being sent out shortly.

>My general sense is that there's some rework needed, and that rework will
>affect the userspace interfaces, which is a problem for a 2.6.18 merge.
>  
>
The rework will affect the number of per-tgid records that userspace 
sees (fewer), not the format or any of the
other details regarding the genetlink interface.
Will that be a problem for userspace ?

--Shailabh

