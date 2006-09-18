Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965574AbWIRI00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965574AbWIRI00 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 04:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965575AbWIRI00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 04:26:26 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:20932 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S965574AbWIRI0Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 04:26:25 -0400
Message-ID: <450E5813.2040804@in.ibm.com>
Date: Mon, 18 Sep 2006 13:55:55 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Pavel Emelianov <xemul@openvz.org>
Cc: sekharan@us.ibm.com, Srivatsa <vatsa@in.ibm.com>,
       Rik van Riel <riel@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Matt Helsley <matthltc@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Kirill Korotaev <dev@sw.ru>,
       Oleg Nesterov <oleg@tv-sign.ru>, devel@openvz.org
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added	user
 memory)
References: <44FD918A.7050501@sw.ru>	<44FDAB81.5050608@in.ibm.com>		<44FEC7E4.7030708@sw.ru>	<44FF1EE4.3060005@in.ibm.com>		<1157580371.31893.36.camel@linuxchandra>	<45011CAC.2040502@openvz.org>		<1157730221.26324.52.camel@localhost.localdomain>		<4501B5F0.9050802@in.ibm.com> <450508BB.7020609@openvz.org>		<4505161E.1040401@in.ibm.com> <45051AC7.2000607@openvz.org>		<1158000590.6029.33.camel@linuxchandra>	<45069072.4010007@openvz.org>		<1158105488.4800.23.camel@linuxchandra>	<4507BC11.6080203@openvz.org>		<1158186664.18927.17.camel@linuxchandra>	<45090A6E.1040206@openvz.org>	<1158277364.6357.33.camel@linuxchandra>	<450A5325.6090803@openvz.org> <450A6A7A.8010102@sw.ru> <450A8B61.7040905@openvz.org>
In-Reply-To: <450A8B61.7040905@openvz.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Emelianov wrote:
> Kirill Korotaev wrote:
> 
> [snip]
>>> I have a C program that computes limits to obtain desired guarantees
>>> in a single 'for (i = 0; i < n; n++)' loop for any given set of guarantees.
>>> With all error handling, beautifull output, nice formatting etc it weights
>>> only 60 lines.
> 
> Look at http://wiki.openvz.org/Containers/Guarantees_for_resources
> I've described there how a guarantee can be get with limiting in details.
> 
> [snip]
> 
>>> I do not 'do not like guarantee'. I'm just sure that there are two ways
>>> for providing guarantee (for unreclaimable resorces):
>>> 1. reserving resource for group in advance
>>> 2. limit resource for others
>>> Reserving is worse as it is essentially limiting (you cut off 100Mb from
>>> 1Gb RAM thus limiting the other groups by 900Mb RAM), but this limiting
>>> is too strict - you _have_ to reserve less than RAM size. Limiting in
>>> run-time is more flexible (you may create an overcommited BC if you
>>> want to) and leads to the same result - guarantee.
>> I think this deserves putting on Wiki.
>> It is very good clear point.
> 
> This is also on the page I gave link at.
> 

This approach has the following disadvantages
  1. Lets consider initialization - When we create 'n' groups initially, we need
     to spend O(n^2) time to assign guarantees.
  2. Every time a limit or a guarantee changes, we need to recalculate guarantees
     and ensure that the change will not break any guarantees
  3. The same thing as stated above, when a resource group is created or deleted

This can lead to some instability; a change in one group propagates to all other groups.


-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
