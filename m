Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbWCZDDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWCZDDK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 22:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWCZDDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 22:03:10 -0500
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:18029 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751450AbWCZDDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 22:03:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=aJt7T+eRyGrBapItYcE4LDe9tMP271H7gy6HKZoheu44Rm40RYrJ4mY2eA4G0Iy+zgGbueM/EYxMpXSmUZRL7nhTC6dfTR7g7uBqtKXqItxGAz873FO7bYSDCACKmW0O9rx3L0IV3UPxI2LjE3A00S6RPz4wrS1Q8+5jsoy2M/U=  ;
Message-ID: <44260467.10402@yahoo.com.au>
Date: Sun, 26 Mar 2006 13:03:03 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: vatsa@in.ibm.com, mingo@elte.hu, suresh.b.siddha@intel.com, pj@sgi.com,
       hawkes@sgi.com, linux-kernel@vger.kernel.org, dino@in.ibm.com
Subject: Re: [PATCH 2.6.16-mm1 1/2] sched_domain: handle kmalloc failure
References: <20060325082730.GA17011@in.ibm.com>	<20060325180605.6e5bb4b9.akpm@osdl.org>	<20060326024039.GA2998@in.ibm.com> <20060325184441.0f6ba5bc.akpm@osdl.org>
In-Reply-To: <20060325184441.0f6ba5bc.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:
> 

>>If we decide to return an error, then it has to be percolated all the
>>way down (for ex: update_cpu_domains should now have to return an error
>>too if partition_sched_domains returns an error)?
> 
> 
> Well, when is this code called?  It would be at boot time, in which case
> the allocations will succeed (if not, the boot fails) or at cpu/node
> hot-add, in which case the appropriate response is to fail to bring up the
> new cpu/node.
> 
> It's better to send the administrator back to work out why we ran out of
> memory than to appear to have brought the new cpu/node online, only to have
> it run funny.
> 
> I think?
> 

I agree, for bootup/hot-add.

Not so sure about exclusive cpusets.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
