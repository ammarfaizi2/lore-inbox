Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262713AbUDAGK3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 01:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbUDAGK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 01:10:28 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:40576 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262713AbUDAGKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 01:10:21 -0500
Message-ID: <406BB238.2050207@nortelnetworks.com>
Date: Thu, 01 Apr 2004 01:10:00 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: timer question
References: <Pine.BSO.4.33.0403311609180.17377-100000@citi.umich.edu> <Pine.LNX.4.53.0403311628120.12948@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> On Wed, 31 Mar 2004, Chuck Lever wrote:
> 
> 
>>hi all-
>>
>>i'm looking for a way to do microsecond resolution timing in the RPC
>>client.  i need a timer or timestamp function that is fairly cheap, that i
>>can call on any hardware platform, and that i can invoke from inside a
>>bottom half.
>>
>>any suggestions?

As Dick Johnson said, x86 has rdtsc.  PowerPC has the mftbr, which is 
equivalent.  MIPS has something similar.

Many architectures have something, but currently it has to be coded for 
each.

One thing that might be nice would be a common API to get a high-res 
timestamp, something like a 64-bit nano_uptime, which would be good for 
uptimes of up to 524 years at nanosecond precision.  Or else you could 
just use timespec, although its not as nice on actual 64-bit machines.

Chris

