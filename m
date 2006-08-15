Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030446AbWHOSYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030446AbWHOSYq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030451AbWHOSYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:24:45 -0400
Received: from 125.14.cm.sunflower.com ([24.124.14.125]:65465 "EHLO
	mail.atipa.com") by vger.kernel.org with ESMTP id S1030447AbWHOSYa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:24:30 -0400
Message-ID: <44E21166.60308@atipa.com>
Date: Tue, 15 Aug 2006 13:24:38 -0500
From: Roger Heflin <rheflin@atipa.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: Willy Tarreau <w@1wt.eu>, Xin Zhao <uszhaoxin@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: What's the NFS OOM problem?
References: <4ae3c140608081524u4666fb7x741734908c35cfe6@mail.gmail.com>	<20060810045711.GI8776@1wt.eu> <17627.53340.43470.60811@cse.unsw.edu.au>
In-Reply-To: <17627.53340.43470.60811@cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Aug 2006 18:24:49.0656 (UTC) FILETIME=[17FB8780:01C6C098]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> On Thursday August 10, w@1wt.eu wrote:
>>> Can someone help me and give me a brief description on OOM issue?
>> I don't know about any OOM issue related to NFS. At most it might happen
>> on the client (eg: stating firefox from an NFS root) which might not have
>> enough memory for new network buffers, but I don't even know if it's
>> possible at all.
> 
> We've had reports of OOM problems with NFS at SuSE.
> The common factors seem to be lots of memory (6G+) and very large
> files. 
> Tuning down  /proc/sys/vm/dirty_*ratio seems to avoid the problem,
> but I'm not very close to understanding what the real problem is.
> 
> NeilBrown
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

I have noticed on SLES kernels that when the dirty_*ratios turned down it
still uses alot more memory than it should work writeback buffers, it makes
me think that with the default setting of 40% that it for some reason
may be using all of memory and deadlocking.   It does not seem like an
NFS only issue, as I believe I have duplicated it with a fast lock
setup.

Checking writeback in /proc/meminfo does indicate that alot more memory
is being used for write cache that should be.

                                     Roger
