Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbVDHHu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbVDHHu0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 03:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbVDHHu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 03:50:26 -0400
Received: from terminus.zytor.com ([209.128.68.124]:27621 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262730AbVDHHt3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 03:49:29 -0400
Message-ID: <42563776.2000207@zytor.com>
Date: Fri, 08 Apr 2005 00:49:10 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Phillips <phillips@istop.com>
CC: Rogan Dawes <rogan@dawes.za.net>, cw@f00f.org,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM saga..
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <d353vk$72m$1@terminus.zytor.com> <42562D47.9080705@dawes.za.net> <200504080321.02462.phillips@istop.com>
In-Reply-To: <200504080321.02462.phillips@istop.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> On Friday 08 April 2005 03:05, Rogan Dawes wrote:
> 
>>Take a look at
>>http://www.linuxshowcase.org/2001/full_papers/ezolt/ezolt_html/
>>
>>Abstract
>>
>>GNU libc's default setting for malloc can cause a significant
>>performance penalty for applications that use it extensively, such as
>>Compaq's high performance extended math library, CXML.  The default
>>malloc tuning can cause a significant number of minor page faults, and
>>result in application performance of only half of the true potential.
> 
> 
> This does not smell like an n*2 suckage, more like n^something suckage.  
> Finding the elephant under the rug should not be hard.  Profile?
> 

Lack of hysteresis can do that, with large swats of memory constantly 
being claimed and returned to the system.  One way to implement 
hysteresis would be based on a decaying peak-based threshold; 
unfortunately for optimal performance that requires the C runtime to 
have a notion of time, and in extreme cases even be able to do 
asynchronous deallocation, but in reality one can probably assume that 
the rate of malloc/free is roughly constant over time.

	-hpa
