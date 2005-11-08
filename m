Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbVKHBod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbVKHBod (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 20:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965163AbVKHBod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 20:44:33 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:16284 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S965173AbVKHBoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 20:44:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ZfzdbZk8WEVuMZJlv6auo0VLdmRlWIiDvEzBVtcazWlm29XtdACKf2m8lKQcO3YCCzRapEXeoiaesQbfgo6COuivbZvv4UJ2g2KvmMwn5+VS7rvVbNUwWIcNYvFMvzPexv2ffvdPSOs6a/tCK3PIDHxCKChTeBeTHs/MVf9WnO4=  ;
Message-ID: <43700371.6040507@yahoo.com.au>
Date: Tue, 08 Nov 2005 12:46:25 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@mbligh.org>
CC: Anton Blanchard <anton@samba.org>, Brian Twichell <tbrian@us.ibm.com>,
       David Lang <david.lang@digitalinsight.com>,
       linux-kernel@vger.kernel.org, slpratt@us.ibm.com
Subject: Re: Database regression due to scheduler changes ?
References: <436FD291.2060301@us.ibm.com> <Pine.LNX.4.62.0511071431030.9339@qynat.qvtvafvgr.pbz> <436FDDE2.4000708@us.ibm.com> <436FF6A6.1040708@yahoo.com.au> <20051108011547.GP12353@krispykreme> <105220000.1131413677@flay>
In-Reply-To: <105220000.1131413677@flay>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:

>>Im also considering adding balance on fork for ppc64, it seems like a
>>lot of people like to run stream like benchmarks and Im getting tired of
>>telling them to lock their threads down to cpus.
> 
> 
> Please don't screw up everything else just for stream. It's a silly 
> frigging benchmark. There's very little real-world stuff that really
> needs balance on fork, as opposed to balance on clone, and it'll slow
> down everything else.
> 

Long lived and memory intensive cloned or forked tasks will often
[but far from always :(] want to be put on another memory controller
from their siblings.

On workloads where there are lots of short lived ones (some bloated
java programs), the load balancer should normally detect this and
cut the balance-on-fork/clone.

Of course there are going to be cases where this fails. I haven't
seen significant slowdowns in tests, although I'm sure there would
be some at least small regressions. Have you seen any? Do you have
any tests in mind that might show a problem?

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
