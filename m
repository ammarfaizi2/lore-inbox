Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965103AbVKHBel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965103AbVKHBel (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 20:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965126AbVKHBel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 20:34:41 -0500
Received: from dvhart.com ([64.146.134.43]:16578 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S965103AbVKHBel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 20:34:41 -0500
Date: Mon, 07 Nov 2005 17:34:37 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Anton Blanchard <anton@samba.org>, Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Brian Twichell <tbrian@us.ibm.com>,
       David Lang <david.lang@digitalinsight.com>,
       linux-kernel@vger.kernel.org, slpratt@us.ibm.com
Subject: Re: Database regression due to scheduler changes ?
Message-ID: <105220000.1131413677@flay>
In-Reply-To: <20051108011547.GP12353@krispykreme>
References: <436FD291.2060301@us.ibm.com> <Pine.LNX.4.62.0511071431030.9339@qynat.qvtvafvgr.pbz> <436FDDE2.4000708@us.ibm.com> <436FF6A6.1040708@yahoo.com.au> <20051108011547.GP12353@krispykreme>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I would also take a look at removing SD_WAKE_IDLE from the flags.
>> This flag should make balancing more aggressive, but it can have
>> problems when applied to a NUMA domain due to too much task
>> movement.
> 
> I was wondering how ppc64 ended up with different parameters in the NODE
> definitions (added SD_BALANCE_NEWIDLE and SD_WAKE_IDLE)	and it looks
> like it was Andrew :)
> 
> http://lkml.org/lkml/2004/11/2/205
> 
> It looks like balancing was not agressive enough on his workload too.
> Im a bit uneasy with only ppc64 having the two flags though.
> 
> Im also considering adding balance on fork for ppc64, it seems like a
> lot of people like to run stream like benchmarks and Im getting tired of
> telling them to lock their threads down to cpus.

Please don't screw up everything else just for stream. It's a silly 
frigging benchmark. There's very little real-world stuff that really
needs balance on fork, as opposed to balance on clone, and it'll slow
down everything else.

M.


