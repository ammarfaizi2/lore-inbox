Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbVLLIyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbVLLIyw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 03:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbVLLIyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 03:54:52 -0500
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:42587 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751121AbVLLIyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 03:54:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=a8U3EI/dpuKVxV2TnqBfvmR1kE9V59DpSytMblKwBZU/tLatAhmWONHcLMRLvlEUKFlL9wM4GB9XyCBnTiaulWV1QtCC4i0orf6I028rEmd1WJOfTHX3LyD9hFUh4nGUiTiftgzakISmrPO/8N8MU4wf1Cr/hwe5GxZPo8eTN3U=  ;
Message-ID: <439D3AD5.3080403@yahoo.com.au>
Date: Mon, 12 Dec 2005 19:54:45 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: Paul Jackson <pj@sgi.com>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       Simon Derr <Simon.Derr@bull.net>, Andi Kleen <ak@suse.de>,
       Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH] Cpuset: rcu optimization of page alloc hook
References: <20051211233130.18000.2748.sendpatchset@jackhammer.engr.sgi.com> <439D39A8.1020806@cosmosbay.com>
In-Reply-To: <439D39A8.1020806@cosmosbay.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet wrote:
> Paul Jackson a écrit :
> 
>> +
>> +static kmem_cache_t *cpuset_cache;
>> +
> 
> 
> Hi Paul
> 
> Please do use __read_mostly for new kmem_cache :
> 
> static kmem_cache_t *cpuset_cache __read_mostly;
> 
> If not, the pointer can sit in the midle of a highly modified cache 
> line, and multiple CPUS will have memory cache misses to access the 
> cpuset_cache, while slab code/data layout itself is very NUMA/SMP friendly.
> 

Is it a good idea for all kmem_cache_t? If so, can we move
__read_mostly to the type definition?


-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
