Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbVIYHSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbVIYHSY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 03:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbVIYHSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 03:18:23 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:2994 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751220AbVIYHSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 03:18:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=kkglO3fmozqEK6VFrVIvSfOHVsBGIngyrku2v/d4mcaLgffyfKgJzROQD/LrL12ok4SHac7sA91RSZyrKsbSpZxV4JmWx88WS5J/FHtAwzcdazt3sFvK0NTT1sXgM1g9OVJehHbJik9XMnFEPOzyuMH1uB4hKT0lz6I6Z5BtMIE=  ;
Message-ID: <43364F70.7010705@yahoo.com.au>
Date: Sun, 25 Sep 2005 17:19:12 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: zwane@linuxpower.ca, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6 01/04] brsem: implement big reader semaphore
References: <20050925064218.E7558977@htj.dyndns.org> <20050925064218.FF1C2BEC@htj.dyndns.org>
In-Reply-To: <20050925064218.FF1C2BEC@htj.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> 01_brsem_implement_brsem.patch
> 
> 	This patch implements big reader semaphore - a rwsem with very
> 	cheap reader-side operations and very expensive writer-side
> 	operations.  For details, please read comments at the top of
> 	kern/brsem.c.
> 

This thing looks pretty overengineered. It is difficult to
read with all the little wrapper functions and weird naming
schemes.

What would be wrong with an array of NR_CPUS rwsems? The only
tiny trick you would have to do AFAIKS is have up_read remember
what rwsem down_read took, but that could be returned from
down_read as a token.

I have been meaning to do something like this for mmap_sem to
see what happens to page fault scalability (though the heavy
write-side would make such a scheme unsuitable for mainline).

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
