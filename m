Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932581AbVLBAce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581AbVLBAce (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 19:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbVLBAce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 19:32:34 -0500
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:51287 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932585AbVLBAcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 19:32:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=RlohVR+X0X+ADVsXivN4CUQX8EZEZ1kdc7CsI21q537Tx3sAEQtlewTtZMXRE7YqILV9JHxsAG40EHupMLQjb+Y/o74ao5DQ3w4sV6C4HcyvnkSdz4x9KJlW6Socha3A6ktf8fVjCjP495aVSjvBG105JkmLAQcWethZKh/9xxw=  ;
Message-ID: <438F961B.6060709@yahoo.com.au>
Date: Fri, 02 Dec 2005 11:32:27 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: Rohit Seth <rohit.seth@intel.com>, akpm@osdl.org, clameter@engr.sgi.com,
       torvalds@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       steiner@sgi.com
Subject: Re: [PATCH]: Free pages from local pcp lists under tight memory conditions
References: <20051122161000.A22430@unix-os.sc.intel.com>	<Pine.LNX.4.62.0511231128090.22710@schroedinger.engr.sgi.com>	<1132775194.25086.54.camel@akash.sc.intel.com>	<20051123115545.69087adf.akpm@osdl.org>	<1132779605.25086.69.camel@akash.sc.intel.com>	<20051123190237.3ba62bf0.pj@sgi.com>	<1133306336.24962.47.camel@akash.sc.intel.com> <20051201064446.c87049ad.pj@sgi.com>
In-Reply-To: <20051201064446.c87049ad.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Rohit wrote:
> 
>>Can you please comment on the performance delta on the MPI workload
>>because of this change in batch values. 
> 
> 
> I can't -- all I know is what I read in Jack Steiner's posts
> of April 5, 2005, referenced earlier in this thread.
> 

It was something fairly large. Basically having a power of 2 batch size
meant that 2 concurrent allocators (presumably setting up the working
area) would alternately pull in power of 2 chunks of memory, which
caused each CPU to only get pages of ~half of its cache's possible
colours.

The fix is not by any means a single value for all workloads, it simply
avoids powers of 2 batch size. Note this will have very little effect
on single threaded allocators and will do nothing for cache colouring
there, however it is important for concurrent allocators.

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
