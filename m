Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751555AbWJWGCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbWJWGCi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 02:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbWJWGCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 02:02:38 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:2488 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751554AbWJWGCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 02:02:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=AB9bX4+r83jo/WMAKHTAuwOWTGFZ3ZVPyzeLCtRFPDfldR+T8mhF/tzvKmNx5GCj7qIQP/OfsvoHKKds8rNBsEEuIexD5YPoHwOG12/vhObr698RKgS9zE+adzAuRcMTRoqiOIOflyPY1HBubHzXELXDnYluavKM2EMYeTH17DU=  ;
Message-ID: <453C5AF4.8070707@yahoo.com.au>
Date: Mon, 23 Oct 2006 16:02:28 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, mbligh@google.com,
       akpm@osdl.org, menage@google.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, dino@in.ibm.com, rohitseth@google.com,
       holt@sgi.com, dipankar@in.ibm.com, clameter@sgi.com
Subject: Re: [RFC] cpuset: remove sched domain hooks from cpusets
References: <20061019092358.17547.51425.sendpatchset@sam.engr.sgi.com>	<4537527B.5050401@yahoo.com.au>	<20061019120358.6d302ae9.pj@sgi.com>	<4537D056.9080108@yahoo.com.au>	<4537D6E8.8020501@google.com>	<20061022035135.2c450147.pj@sgi.com>	<20061022222652.B2526@unix-os.sc.intel.com> <20061022225456.6adfd0be.pj@sgi.com>
In-Reply-To: <20061022225456.6adfd0be.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Suresh wrote:
> 
>>group of pinned tasks can completely skew the system load balancing..
> 
> 
> Ah - yes.  That was a problem.  If the load balancer couldn't offload
> tasks from one or two of the most loaded CPUs (perhaps because they
> were pinned.) it tended to give up.
> 
> I believe that Christoph is actively working that problem.  Adding him
> to the cc list, so he can explain the state of this work more
> accurately.

It is somewhat improved. The load balancing will now retry other CPUs,
but this is pretty costly in terms of latency and rq lock hold time.
And the algorithm itself still breaks down if you have lots of pinned
tasks, even if the load balancer is willing to try lesser loaded cpus.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
