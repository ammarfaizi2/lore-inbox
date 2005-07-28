Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262077AbVG1Xgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbVG1Xgb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 19:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbVG1Xgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 19:36:31 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:20052 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262125AbVG1Xes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 19:34:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=kTors6O6cMuf7701kqG6Rqm9b/Pnbrr8QLljzxtOWM3ufq8qrxFFnn1R5SL/Cael6n1c5iT4+YUZ2ur1ZBr4cLakosuOgEOxhl4lDFA0W2HS12xZV5/06LsLtPiQcPj0CVm/R3AYMhe8c2hxfsPVNjBmAXRFG3cByL//OYsZOEw=  ;
Message-ID: <42E96B8C.6010005@yahoo.com.au>
Date: Fri, 29 Jul 2005 09:34:36 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: Delete scheduler SD_WAKE_AFFINE and SD_WAKE_BALANCE flags
References: <200507282308.j6SN8Tg01993@unix-os.sc.intel.com>
In-Reply-To: <200507282308.j6SN8Tg01993@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:
> What sort of workload needs SD_WAKE_AFFINE and SD_WAKE_BALANCE?
> SD_WAKE_AFFINE are not useful in conjunction with interrupt binding.
> In fact, it creates more harm than usefulness, causing detrimental
> process migration and destroy process cache affinity etc.  Also
> SD_WAKE_BALANCE is giving us performance grief with our industry
> standard OLTP workload.
> 

The periodic load balancer basically makes completely undirected,
random choices when picking which tasks to move where.

Wake balancing provides an opportunity to provide some input bias
into the load balancer.

For example, if you started 100 pairs of tasks which communicate
through a pipe. On a 2 CPU system without wake balancing, probably
half of the pairs will be on different CPUs. With wake balancing,
it should be much better.

I've also been told that it impoves IO efficiency significantly -
obviously that depends on the system and workload.

> To demonstrate the problem, we turned off these two flags in the cpu
> sd domain and measured a stunning 2.15% performance gain!  And deleting
> all the code in the try_to_wake_up() pertain to load balancing gives us
> another 0.2% gain.
> 
> The wake up patch should be made simple, just put the waking task on
> the previously ran cpu runqueue.  Simple and elegant.
> 
> I'm proposing we either delete these two flags or make them run time
> configurable.
> 

There have been lots of changes since 2.6.12. Including less aggressive
wake balancing.

I hear you might be having problems with recent 2.6.13 kernels? If so,
it would be really good to have a look that before 2.6.13 goes out the
door.

I appreciate all the effort you're putting into this!

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
