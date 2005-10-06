Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbVJFP5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbVJFP5Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 11:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbVJFP5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 11:57:24 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:5819 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1751120AbVJFP5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 11:57:24 -0400
Message-ID: <4345494E.8030007@nortel.com>
Date: Thu, 06 Oct 2005 09:57:02 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernd Petrovitsch <bernd@firmix.at>
CC: Alex Riesen <raa.lkml@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: select(0,NULL,NULL,NULL,&t1) used for delay
References: <1128606546.14385.26.camel@penguin.madhu>	 <81b0412b0510060727h35c0fd78i260037ca89f253f9@mail.gmail.com>	 <43454238.4040907@nortel.com> <1128613370.6630.5.camel@tara.firmix.at>
In-Reply-To: <1128613370.6630.5.camel@tara.firmix.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Oct 2005 15:57:05.0274 (UTC) FILETIME=[991A6DA0:01C5CA8E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Petrovitsch wrote:
> On Thu, 2005-10-06 at 09:26 -0600, Christopher Friesen wrote:

> And it's cooler to hack the kernel than to create and use a
> portable_sleep() function and use it.

If there is a substantial codebase using select() for sleeping, then it 
makes sense to improve the efficiency of the kernel.  Fix it in one 
place, make all the apps run better.

>>The select() man page explicitly mentions this usage;
>>
>>"Some code calls select with all three sets empty, n zero, and a 
>>non-null timeout as a fairly portable way to sleep with subsecond 
>                                                           ^^^^^^^^^
>>precision."
>   ^^^^^^^^^
> 
> You do realize that "subsecond precision" is probably meant as
> improvement to sleep(3) and surely not to nanosleep(2)?

select() allows for the selection of sleep time with microsecond 
precision.  The mainline kernel can't sleep for that small an interval 
anyway, so there's not really any difference in sleep precision between 
the two.

As I mentioned earlier, select() actually sleeps more accurately than 
nanosleep() on many kernels.  I haven't tested the most recent to see if 
this is still true though.

Chris
