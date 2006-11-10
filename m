Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946563AbWKJM4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946563AbWKJM4L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 07:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946564AbWKJM4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 07:56:10 -0500
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:4602 "EHLO
	ausmtp05.au.ibm.com") by vger.kernel.org with ESMTP
	id S1946563AbWKJM4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 07:56:09 -0500
Message-ID: <455476C0.6010204@in.ibm.com>
Date: Fri, 10 Nov 2006 18:25:28 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Pavel Emelianov <xemul@openvz.org>
CC: dev@openvz.org, ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux MM <linux-mm@kvack.org>, rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC][PATCH 6/8] RSS controller shares allocation
References: <20061109193523.21437.86224.sendpatchset@balbir.in.ibm.com>	<20061109193619.21437.84173.sendpatchset@balbir.in.ibm.com> <45544240.80609@openvz.org> <45545429.7080903@in.ibm.com> <4554552E.8050300@openvz.org>
In-Reply-To: <4554552E.8050300@openvz.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Emelianov wrote:
> [snip]
> 
>>>> +	for_each_child(child, res->rgroup) {
>>>> +		child_res = get_memctlr(child);
>>>> +		BUG_ON(!child_res);
>>>> +		recalc_and_propagate(child_res, res);
>>> Recursion? Won't it eat all the stack in case of a deep tree?
>> The depth of the hierarchy can be controlled. Recursion is needed
>> to do a DFS walk
> 
> That's another point against recursion - bad root can
> crash the kernel... If we are about to give container's
> users ability to make their own subtrees then we *must*
> avoid recursion. There's an algorithm that allows one
> to walk the tree like this w/o recursion.

Bad pointers are always bad, whether they are the root or
any other pointer. Tree traversal is a generic infrastructure issue
for any infrastructure that supports a hierarchy.

Are you talking about threaded trees? Yes, they can be traversed
without recursion. I need to recheck my DS reference to double
check.

> 
> [snip]
> 
>>> I didn't find where in this patches this callback is called.
>> It's a part of the resource groups infrastructure. It's been ported
>> on top of Paul Menage's containers patches. The code can be easily
>> adapted to work directly with containers instead of resource groups
>> if required.
> 
> 
> Could you please give me a link to the patch where this
> is called?

Please see

http://www.mail-archive.com/ckrm-tech@lists.sourceforge.net/msg03333.html

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
