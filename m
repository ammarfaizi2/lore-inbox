Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263578AbTHZKOk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 06:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263616AbTHZKOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 06:14:40 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:32238 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S263578AbTHZKOi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 06:14:38 -0400
Message-ID: <3F4B3352.4000703@softhome.net>
Date: Tue, 26 Aug 2003 12:15:46 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: Re: cache limit
References: <n7lV.2HA.19@gated-at.bofh.it> <ofAJ.4dx.9@gated-at.bofh.it> <ogZM.5KJ.1@gated-at.bofh.it> <oyDw.5FP.33@gated-at.bofh.it>
In-Reply-To: <oyDw.5FP.33@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
>>On Mon, Aug 25, 2003 at 11:45:58AM +0900, Takao Indoh wrote:
>>
>>>I need a tuning parameter which can control pagecache
>>>like /proc/sys/vm/pagecache, which RedHat Linux has.
>>>The latest 2.4 or 2.5 standard kernel does not have such a parameter.
>>>2.4.18 kernel or 2.4-aa kernel has a alternative method?
> 
> I doubt that there will be that option in the 2.4 stable series.  I think
> you are trying to fix the problem without understanding the entire picture.
> If there is too much pagechache, then the kernel developers need to know
> about your workload so that they can fix it.  But you have to try -aa first
> to see if it's already fixed.
> 

   Let me give my point of view.

   Linux trys to scale up to the limits of given hardware.

   That is _*horribly*_ wrong.

   If I have 1GB of memory and my applications for use only 16MB - it 
doesn't mean I want to fill 1GB-16MB with garbage like file my momy had 
viewed two weeks ago.

   That's it: OS should scale for *application* *needs*.

   Can you compare in your mind overhead of managing 1GB of cache with 
managing e.g. 16MB of cache?

   So IMHO problem is: OS needless overhead.

   It is possible to minimize overhead in several ways:
   1) Optimize algorithms and data structures.
   2) Minimize amount of resources.
   3) As a compromise of 1&2 - teach OS to not use unneeded resource til 
the time they will be really needed, and free them afterwards.

   1) is already done, 3) is awful heuristics which will never work 
reliably.
   And Takao's patch was trying to approach problem from 2) point.
   So as for me it is justified.

   Comments are welcome.

