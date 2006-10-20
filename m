Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWJTQD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWJTQD3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 12:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWJTQD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 12:03:29 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:38044 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932264AbWJTQD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 12:03:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=tPpY6W5FPjQ78BfuBCEUeBry2R67XEfZj5JXMafy417LIiLZQupDMX+FB+dMCtYmwhAYpGaLT3PkHyGbJwk4tDvWIvIDIjNG2ICFTmuur2kkNn3QxyvKQhFbZUeH+qnRc4CWhD8+Jz8lcm1/Kmw9af1dzvEMyhYLqmSXLvc9ug4=  ;
Message-ID: <4538F34A.7070703@yahoo.com.au>
Date: Sat, 21 Oct 2006 02:03:22 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Bligh <mbligh@google.com>
CC: Paul Jackson <pj@sgi.com>, akpm@osdl.org, menage@google.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, dino@in.ibm.com,
       rohitseth@google.com, holt@sgi.com, dipankar@in.ibm.com,
       suresh.b.siddha@intel.com
Subject: Re: [RFC] cpuset: remove sched domain hooks from cpusets
References: <20061019092358.17547.51425.sendpatchset@sam.engr.sgi.com>	<4537527B.5050401@yahoo.com.au> <20061019120358.6d302ae9.pj@sgi.com> <4537D056.9080108@yahoo.com.au> <4537D6E8.8020501@google.com>
In-Reply-To: <4537D6E8.8020501@google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh wrote:
> 
>> I don't know of anyone else using cpusets, but I'd be interested to know.
> 
> 
> We (Google) are planning to use it to do some partitioning, albeit on
> much smaller machines. I'd really like to NOT use cpus_allowed from
> previous experience - if we can get it to to partition using separated
> sched domains, that would be much better.
> 
>  From my dim recollections of previous discussions when cpusets was
> added in the first place, we asked for exactly the same thing then.
> I think some of the problem came from the fact that "exclusive"
> to cpusets doesn't actually mean exclusive at all, and they're
> shared in some fashion. Perhaps that issue is cleared up now?
> /me crosses all fingers and toes and prays really hard.

The I believe, is that an exclusive cpuset can have an exclusive parent
and exclusive children, which obviously all overlap one another, and
thus you have to do the partition only at the top-most exclusive cpuset.

Currently, cpusets is creating partitions in cpus_exclusive children as
well, which breaks balancing for the parent.

The patch I posted previously should (modulo bugs) only do partitioning
in the top-most cpuset. I still need clarification from Paul as to why
this is unacceptable, though.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
