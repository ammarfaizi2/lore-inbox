Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267866AbUJCMVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267866AbUJCMVN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 08:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267869AbUJCMVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 08:21:12 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:42430 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S267866AbUJCMVH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 08:21:07 -0400
Message-ID: <415FEE68.2060505@watson.ibm.com>
Date: Sun, 03 Oct 2004 08:19:52 -0400
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030901 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: akpm@osdl.org, mef@CS.Princeton.EDU, nagar@watson.ibm.com,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       mbligh@aracnet.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com, llp@CS.Princeton.EDU
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
 memory placement
References: <NIBBJLJFDHPDIBEEKKLPCEFLCHAA.mef@cs.princeton.edu>	<415ED4A4.1090001@watson.ibm.com>	<20041002134059.65b45e29.akpm@osdl.org>	<415F34FF.8040806@watson.ibm.com> <20041002194926.06bd0332.pj@sgi.com>
In-Reply-To: <20041002194926.06bd0332.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Paul Jackson wrote:
> Hubertus wrote:
> 
>>CKRM could do so. We already provide the name space and the class 
>>hierarchy.
> 
> 
> Just because two things have name spaces and hierarchies, doesn't
> make them interchangeable.  Name spaces and hierarchies are just
> implementation mechanisms - many interesting, entirely unrelated,
> solutions make use of them.
> 
> What are the objects named, and what is the relation underlying
> the hierarchy?  These must match up.

Object name relationships are established through the rcfs pathname.

> 
> The objects named in cpusets are subsets of a systems CPUs and Memory
> Nodes. The relation underlying the hierarchy is the subset relation on
> these sets: if one cpuset node is a descendent of another, then its
> CPUs and Memory Nodes are a subset of the others.

Exactly, the controller will enforce that in the same way we
enforce other attributes and shares.
Example, we make sure that the sum of the share "guarantees" for
all children does not exceed the total_guarantee (i.e. denominator)
of the parent.
Nothing prohibits the controller to enforce the set constraints
you describe above and reject requests that are not valid.
As I said before, ideally the controller would be the cpumem set
guts and RCFS would be the API to it.

That's what Andrew was asking for in case the requirement for
this functionality can/is made.

> 
> What is the corresponding statement for CKRM?
> 
> For CKRM to subsume cpusets, there must be an injective map from the
> above cpuset objects to CKRM objects, that preserves this subset
> relation on cpusets.
> 

See above.

