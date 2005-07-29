Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVG2BZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVG2BZe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 21:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVG2BZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 21:25:34 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:22356 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261600AbVG2BZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 21:25:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=wjvwCPZ1Rp7wRkckh2q30CDlCcAsLX2LO/q1D1+wFtsuKxgw51ibk2G6nIU+/Z61WlIMalU4WKcdYZA+t6CwjGkLW5W+ytH2hGFPwQCXh7ekgvfS8nTii7gYMdn2U+ZqQGqEAkmU8RJVbFx3SEgXjYm1uI45NRnfWVIjrc657OQ=  ;
Message-ID: <42E98582.2080406@yahoo.com.au>
Date: Fri, 29 Jul 2005 11:25:22 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: Delete scheduler SD_WAKE_AFFINE and SD_WAKE_BALANCE flags
References: <200507282348.j6SNmLg02429@unix-os.sc.intel.com>
In-Reply-To: <200507282348.j6SNmLg02429@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:

>Nick Piggin wrote on Thursday, July 28, 2005 4:35 PM
>
>>Wake balancing provides an opportunity to provide some input bias
>>into the load balancer.
>>
>>For example, if you started 100 pairs of tasks which communicate
>>through a pipe. On a 2 CPU system without wake balancing, probably
>>half of the pairs will be on different CPUs. With wake balancing,
>>it should be much better.
>>
>
>Shouldn't the pipe code use synchronous wakeup?
>
>

Well pipes are just an example. It could be any type of communication.
What's more, even the synchronous wakeup uses the wake balancing path
(although that could be modified to only do wake balancing for synch
wakeups, I'd have to be convinced we should special case pipes and not
eg. semaphores or AF_UNIX sockets).

>
>>I hear you might be having problems with recent 2.6.13 kernels? If so,
>>it would be really good to have a look that before 2.6.13 goes out the
>>door.
>>
>
>Yes I do :-(, apparently bumping up cache_hot_time won't give us the
>performance boost we used to see.
>
>
OK there are probably a number of things we can explore depending on
what are the symptoms (eg. excessive idle time, bad cache performance).

Unfortunately it is kind of difficult to tune 2.6.13 on the basis of
2.6.12 results - although that's not to say it won't indicate a good
avenue to investigate.


Send instant messages to your online friends http://au.messenger.yahoo.com 
