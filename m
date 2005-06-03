Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVFCFhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVFCFhf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 01:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVFCFhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 01:37:35 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:24501
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261277AbVFCFhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 01:37:31 -0400
Date: Thu, 02 Jun 2005 22:37:12 -0700 (PDT)
Message-Id: <20050602.223712.41634750.davem@davemloft.net>
To: mbligh@mbligh.org
Cc: nickpiggin@yahoo.com.au, jschopp@austin.ibm.com, mel@csn.ul.ie,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Avoiding external fragmentation with a placement policy
 Version 12
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <357240000.1117776882@[10.10.2.4]>
References: <1117770488.5084.25.camel@npiggin-nld.site>
	<20050602.214927.59657656.davem@davemloft.net>
	<357240000.1117776882@[10.10.2.4]>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Martin J. Bligh" <mbligh@mbligh.org>
Date: Thu, 02 Jun 2005 22:34:42 -0700

> One of the calls I got the other day was for loopback interface. 
> Default MTU is 16K, which seems to screw everything up and do higher 
> order allocs. Turning it down to under 4K seemed to fix things. I'm 
> fairly sure loopback doesn't really need phys contig memory, but it 
> seems to use it at the moment ;-)

It helps get better bandwidth to have larger buffers.
That's why AF_UNIX tries to use larger orders as well.

With all these processors using prefetching in their
memcpy() implementations, reducing the number of memcpy()
calls per byte is getting more and more important.
Each memcpy() call makes you hit the memory latency
cost since the first prefetch can't be done early
enough.
