Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbVHRGvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbVHRGvZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 02:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbVHRGvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 02:51:25 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:59569 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1750864AbVHRGvX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 02:51:23 -0400
Message-ID: <43042FD7.40204@cosmosbay.com>
Date: Thu, 18 Aug 2005 08:51:03 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Coywolf Qi Hunt <coywolf@gmail.com>
CC: Andi Kleen <ak@suse.de>, Benjamin LaHaise <bcrl@linux.intel.com>,
       "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct file cleanup : the very large file_ra_state is
 now allocated only on demand.
References: <20050810164655.GB4162@linux.intel.com>	 <20050810.135306.79296985.davem@davemloft.net>	 <20050810211737.GA21581@linux.intel.com>	 <430391F1.9080900@cosmosbay.com>	 <20050817211829.GK27628@wotan.suse.de>	 <4303AEC4.3060901@cosmosbay.com> <20050817215357.GU3996@wotan.suse.de>	 <4303D90E.2030103@cosmosbay.com> <2cd57c90050817183942b217fa@mail.gmail.com>
In-Reply-To: <2cd57c90050817183942b217fa@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [62.23.185.226]); Thu, 18 Aug 2005 08:51:10 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt a écrit :
> On 8/18/05, Eric Dumazet <dada1@cosmosbay.com> wrote:
> 
>>Andi Kleen a écrit :
>>
>>
>>>>(because of the insane struct file_ra_state f_ra. I wish this structure
>>>>were dynamically allocated only for files that really use it)
>>>
>>>
>>>How about you submit a patch for that instead?
>>>
>>>-Andi
>>
>>OK, could you please comment this patch ?
>>
>>The problem of dynamically allocating the readahead state data is that the allocation can fail and should not be fatal.
>>I made some choices that might be not good.
>>
>>I also chose not to align "file_ra" slab on SLAB_HWCACHE_ALIGN because the object size is 10*sizeof(long), so alignment would loose
>>6*sizeof(long) bytes for each object.
>>
>>
>>[PATCH]
>>
>>* struct file cleanup : the very large file_ra_state is now allocated only on demand, using a dedicated "file_ra" slab.
>>        64bits machines handling lot of sockets can save about 72 bytes per file.
>>* private_data : The field is moved close to f_count and f_op fields to speedup sockfd_lookups
> 
> 
> Why not keep the comment or fix it?
> 

You mean the comment in include/linux/fs.h : /* needed for tty driver, and maybe others */ ?

I think this comment is outdated, since nearly every 'struct file' user store something of his own in this place, not only 'tty drivers'

As no other fields has comment, why should we keep this outdated comment ?

Eric
