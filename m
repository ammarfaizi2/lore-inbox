Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932946AbWKQQev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932946AbWKQQev (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 11:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933709AbWKQQev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 11:34:51 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:41638 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP id S932946AbWKQQeu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 11:34:50 -0500
Message-ID: <455DE480.7000500@in.ibm.com>
Date: Fri, 17 Nov 2006 22:04:08 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: "Patrick.Le-Dot" <Patrick.Le-Dot@bull.net>
CC: ckrm-tech@lists.sourceforge.net, dev@openvz.org, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC][PATCH 5/8] RSS controller task migration	support
References: <20061117132533.A5FCF1B6A2@openx4.frec.bull.fr>
In-Reply-To: <20061117132533.A5FCF1B6A2@openx4.frec.bull.fr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick.Le-Dot wrote:
>> ...
>> For implementing guarantees, we can use limits. Please see
>> http://wiki.openvz.org/Containers/Guarantees_for_resources.
> 
> Nack.
> 
> This seems to be correct for resources like cpu, disk or network
> bandwidth but not for the memory just because nobody in this wiki
> speaks about the kswapd and page reclaim (but it's true that a such
> demon does not exist for cpu, disk or... then the problem is more
> simple).
> 
> For a customer the main reason to use guarantee is to be sure that
> some pages of a job remain in memory when the system is low on free
> memory. This should be true even for a job in group/container A with
> a smooth activity compared to a group/container B with a set of jobs
> using memory more agressively...
> 

I am not against guarantees, but

Consider the following scenario, let's say we implement guarantees

1. If we account for kernel resources, how do you provide guarantees
   when you have non-reclaimable resources?
2. If a customer runs a system with swap turned off (which is quite
   common), then anonymous memory becomes irreclaimable. If a group
   takes more than it's fair share (exceeds its guarantee), you
   have scenario similar to 1 above.

> What happens if we use limits to implement guarantees ?
> 
>>> ...
>>> The idea of getting a guarantee is simple:
>>> if any group gi requires a Gi units of resource from R units available
>>> then limiting all the rest groups with R - Gi units provides a desired
>>> guarantee
> 
> If the limit is a "hard limit" then we have implemented reservation and
> this is too strict.
>
> If the limit is a "soft limit" then group/container B is autorized to
> use more than the limit and nothing is guaranteed for group/container A...
> 
> Patrick


Yes, but it is better than failing to meet a guarantee (if guarantees are
desired :))


-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
