Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423519AbWJZRMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423519AbWJZRMu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 13:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423619AbWJZRMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 13:12:50 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:23963 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1423519AbWJZRMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 13:12:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=OFESMROuYd+SznkFLRgRA1/sbAEqiyGMI+JLd0YrP1czaYX5esSXbJ7O3zUdKBBeWXyAs+gKSGThMZubhuhpnR7Onha94/kOt1HrlqELeoKHXPZnLhFf5fICFwW7P9NTtPyvEZoPVdX/PxXvlHnHJkc1l6Jk6vPR8ld4DRl4MkY=  ;
Message-ID: <4540EC84.8070302@yahoo.com.au>
Date: Fri, 27 Oct 2006 03:12:36 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: akpm@osdl.org, Peter Williams <pwil3058@bigpond.net.au>,
       linux-kernel@vger.kernel.org,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Dave Chinner <dgc@sgi.com>, Ingo Molnar <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [PATCH 5/5] Only call rebalance_domains when needed from scheduler_tick
References: <20061024183104.4530.29183.sendpatchset@schroedinger.engr.sgi.com> <20061024183130.4530.83162.sendpatchset@schroedinger.engr.sgi.com> <4540A986.2070200@yahoo.com.au> <Pine.LNX.4.64.0610260922400.16978@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0610260922400.16978@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Thu, 26 Oct 2006, Nick Piggin wrote:
> 
> 
>>>Call rebalance_domains from a tasklet with interrupt enabled.
>>>Only call it when one of the sched domains is to be rebalanced.
>>>The jiffies when the next balancing action is to take place is
>>>kept in a per cpu variable next_balance.
>>
>>sched-domains was supposed to be able to build a whacky topology
>>so you didn't have to take the occasional big latency hit when
>>scanning 512 CPUs...
> 
> 
> How is that supposed to work? The load calculations will be off
> in that case and also the load balancing algorithm wont work anymore. 
> This is going to be a pretty significant rework of how the scheduler 
> works but given the problems with pinned tasks... maybe that is 
> necessary?
> duler?

What will the problem be? Sure it may pull tasks fom one group to
another when both could actually be pulling from a third, but it
the load balancing algorithm should work fine and not require any
rework.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
