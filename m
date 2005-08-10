Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbVHJA17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbVHJA17 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 20:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbVHJA17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 20:27:59 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:41046 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750975AbVHJA16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 20:27:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=pGgsH2liJwo1WlQmJUW3OdO9MDa/tk6EiGm8qJyeaN3zVzqTKezWBe173ore/ebMwDIKqeATXpNIiN8rwSgsAw5BUB+voSL0PbtlEVWgVTf7dkAFK7hPdkjWatjUbFm92BPExf81y1exv+AttSIhaS56RkiiyPdFezGzEgQqQK8=  ;
Message-ID: <42F94A00.3070504@yahoo.com.au>
Date: Wed, 10 Aug 2005 10:27:44 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Ingo Molnar <mingo@elte.hu>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       steiner@sgi.com, dvhltc@us.ibm.com, mbligh@mbligh.org
Subject: Re: allow the load to grow upto its cpu_power (was Re: [Patch] don't
 kick ALB in the presence of pinned task)
References: <20050801174221.B11610@unix-os.sc.intel.com> <20050802092717.GB20978@elte.hu> <20050809160813.B1938@unix-os.sc.intel.com>
In-Reply-To: <20050809160813.B1938@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:

>For example, lets take two nodes each having two physical packages. And
>assume that there are two tasks and both of them are on (may or may n't be
>pinned) two packages in node-0
>
>Todays load balance will detect that there is an imbalance between the
>two nodes and will try to distribute the load between the nodes.
>
>In general, we should allow the load of a group to grow upto its cpu_power
>and stop preventing these costly movements.
>
>Appended patch will fix this. I have done limited testing of this patch.
>Guys with big NUMA boxes, please give this patch a try. 
>
>--
>
>When the system is lightly loaded, don't bother about the average load.
>In this case, allow the load of a sched group to grow upto its cpu_power.
>
>

Yeah this makes sense. Thanks.

I think we'll only need your first line change to fix this, though.

Your second change will break situations where a single group is very
loaded, but it is in a domain with lots of cpu_power
(total_load <= total_power).

Nick


Send instant messages to your online friends http://au.messenger.yahoo.com 
