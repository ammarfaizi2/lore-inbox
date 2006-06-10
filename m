Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751500AbWFJMVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbWFJMVG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 08:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWFJMVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 08:21:06 -0400
Received: from mta4.srv.hcvlny.cv.net ([167.206.4.199]:28280 "EHLO
	mta4.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1751500AbWFJMVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 08:21:05 -0400
Date: Sat, 10 Jun 2006 08:21:00 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in taskstats
In-reply-to: <448A089C.6020408@engr.sgi.com>
To: Jay Lan <jlan@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, balbir@in.ibm.com, jlan@sgi.com,
       csturtiv@sgi.com, linux-kernel@vger.kernel.org
Message-id: <448AB92C.4080205@watson.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
References: <44892610.6040001@watson.ibm.com>
 <20060609010057.e454a14f.akpm@osdl.org> <448952C2.1060708@in.ibm.com>
 <20060609042129.ae97018c.akpm@osdl.org> <4489EE7C.3080007@watson.ibm.com>
 <4489F93E.6070509@engr.sgi.com> <20060609162232.2f2479c5.akpm@osdl.org>
 <448A089C.6020408@engr.sgi.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan wrote:

>Andrew Morton wrote:
>  
>
>

>>But the overhead at present is awfully low.  If we don't need this ability
>>at present (and I don't think we do) then a paper design would be
>>sufficient at this time.  As long as we know we can do this in the future
>>without breaking existing APIs then OK.
>> 
>>    
>>
>i can see if an exiting process is the only process in the thread group,
>the (not is_thread_group) condition would be true. So, that leaves
>multi-threaded applications that are not interested in tgid-data still
>receive 2x taskstats data.
>  
>
Jay,

Why is the 2x taskstats data for the multithreaded app a real problem ?
When differnt clients agree to use a common taskstats structure, they 
also incur the potential
overhead of receiving extra data they don't really care about (in CSA's 
case, that would be all the
delay accounting fields of struct taskstats). Isn't that, in some sense, 
the "price" of sharing a structure
or delivery mechanism ?

Of course, if this overhead becomes too much, we need to find 
alternatives. But, as already shown,
even in the extreme case where app does nothing but fork/exit, there is very
little performance impact. So I don't see how in the common case of 
multithreaded apps, where exits
are going to be at a far lesser rate, the extra per-tgid data is a real 
issue.

So, are we trying to solve a real problem ?

I'll address the alternatives in a separate mail but lets address this 
point first please.

--Shailabh
