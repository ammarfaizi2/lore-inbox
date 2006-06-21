Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751491AbWFUVpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbWFUVpA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWFUVpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:45:00 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:65205 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751491AbWFUVo7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:44:59 -0400
Message-ID: <4499BDDD.3010206@engr.sgi.com>
Date: Wed, 21 Jun 2006 14:45:01 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, balbir@in.ibm.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com>	<20060609010057.e454a14f.akpm@osdl.org>	<448952C2.1060708@in.ibm.com>	<20060609042129.ae97018c.akpm@osdl.org>	<4489EE7C.3080007@watson.ibm.com>	<449999D1.7000403@engr.sgi.com> <20060621133838.12dfa9f8.akpm@osdl.org> <4499BAA9.3000707@watson.ibm.com>
In-Reply-To: <4499BAA9.3000707@watson.ibm.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar wrote:
> Andrew Morton wrote:
>
>> On Wed, 21 Jun 2006 12:11:13 -0700
>> Jay Lan <jlan@engr.sgi.com> wrote:
>>
>>  
>>
>>> Another observation that i considered bad news is that all
>>> 10 runs produced 1 to 5 recv() error with errno=105 (ENOBUF).
>>>   
>>
>> Well that's rather bad.  AFAICT most of the allocations in there are
>> GFP_KERNEL, so why is this happening?
>>  
>>
>
> Need to trace the cause.
>
>> Because the kernel is producing netlink messages faster than
>> userspace can
>> consume them, perhaps?
> Hmm...possible. A quick check would be to reduce the frequency of
> exits and see.
>
>> If so, the sender needs to block, which means we
>> need to make reception of these stats a privileged operation?
>>  
>>
> Won't it suffice to make delivery of these stats best effort, with
> userspace dealing with missing data,

How do you recover the missed data?

> rather than risk delaying exits ? The cases where exits are so
> frequent as in this program should be

This is very true. However, it was a 2p IA64 machine. I am too frightened to
speak "512p"...

Regards,
 - jay

> very few. Making the reception privileged would kind of constrain the
> utilization of stats and I'm not
> sure if  its warranted.
>
>
> --Shailabh
>
>

