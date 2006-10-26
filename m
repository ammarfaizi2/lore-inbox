Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423374AbWJZM0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423374AbWJZM0v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 08:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423380AbWJZM0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 08:26:51 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:39600 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1423374AbWJZM0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 08:26:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=kGeEmu+mRFuLCDveXbCGrFWGv656pHdVZ9Nd1IfqAYUeBnQx8lWtWhDdJrIVzQtkrSq4WPx0fMurCZybVJG+Qnmntv2pCSRmM/PDGp/VYDVT/QnmZim94SDYCSx4xqYBEM3oOmChHugDK+0HeFeKyysJMZh0J6xDubMhzC9HoXY=  ;
Message-ID: <4540A986.2070200@yahoo.com.au>
Date: Thu, 26 Oct 2006 22:26:46 +1000
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
References: <20061024183104.4530.29183.sendpatchset@schroedinger.engr.sgi.com> <20061024183130.4530.83162.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061024183130.4530.83162.sendpatchset@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> Only call rebalance_domains when needed from scheduler_tick.
> 
> Call rebalance_domains from a tasklet with interrupt enabled.
> Only call it when one of the sched domains is to be rebalanced.
> The jiffies when the next balancing action is to take place is
> kept in a per cpu variable next_balance.

sched-domains was supposed to be able to build a whacky topology
so you didn't have to take the occasional big latency hit when
scanning 512 CPUs...

Ideas were: overlapping, non-covering top level domains, or a
SD_BALANCE_ROTOR, which scans only N (< all) groups on each
balance attempt, but more frequently.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
