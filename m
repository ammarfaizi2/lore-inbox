Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423340AbWJZMNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423340AbWJZMNs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 08:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423352AbWJZMNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 08:13:48 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:17257 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1423340AbWJZMNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 08:13:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=yfgluo3kTs1z4LewBNf1gGCgZFkaL1uESAUy40fFjU5rSr2o9BWNtx1eFvCDS7W0fBWK8k05Dp1bWo9cH6T9UFybq+B/9cqOJ9nLqA+/F6PQquZh8Tay2dJIaQBZCceIdGp5Qmb6IS8e472bD6AGJPWqZMRm8dEBnpsb8hidu9Y=  ;
Message-ID: <4540A676.1070802@yahoo.com.au>
Date: Thu, 26 Oct 2006 22:13:42 +1000
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
Subject: Re: [PATCH 3/5] Use next_balance instead of last_balance
References: <20061024183104.4530.29183.sendpatchset@schroedinger.engr.sgi.com> <20061024183119.4530.64973.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061024183119.4530.64973.sendpatchset@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> Use next_balance instead of last_balance ...
> 
> The cpu offset calculation in the sched_domains code makes it difficult to
> figure out when the next event is supposed to happen since we only keep
> track of the last_balancing. We want to know when the next load balance
> is supposed to occur.
> 
> Move the cpu offset calculation into build_sched_domains(). Do the
> setup of the staggered load balance schewduling when the sched domains
> are initialized. That way we dont have to worry about it anymore later.
> 
> This also in turn simplifies the load balancing time checks.

OK. I think I made this overcomplex in order to cope with issues where
offset can get skewed so if we're unlucky they might all get into synch
... but this new code isn't any worse than the old, and it is cheaper.

So, Ack.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
