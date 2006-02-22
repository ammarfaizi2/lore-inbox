Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751438AbWBVUxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbWBVUxt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 15:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWBVUxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 15:53:49 -0500
Received: from master.soleranetworks.com ([67.137.28.188]:7566 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S1751438AbWBVUxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 15:53:48 -0500
Message-ID: <43FCDC88.7090602@wolfmountaingroup.com>
Date: Wed, 22 Feb 2006 14:50:00 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Robin Holt <holt@sgi.com>, john@johnmccutchan.com,
       linux-kernel@vger.kernel.org, rml@novell.com, arnd@arndb.de, hch@lst.de
Subject: Re: udevd is killing file write performance.
References: <20060222134250.GE20786@lnx-holt.americas.sgi.com>	<1140626903.13461.5.camel@localhost.localdomain>	<20060222175030.GB30556@lnx-holt.americas.sgi.com> <20060222120547.2ae23a16.akpm@osdl.org>
In-Reply-To: <20060222120547.2ae23a16.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Robin Holt <holt@sgi.com> wrote:
>  
>
>>Let me reiterate, I know _VERY_ little about filesystems.  Can the
>> dentry->d_lock be changed to a read/write lock?
>>    
>>
>
>Well, it could, but I suspect that won't help - the hold times in there
>will be very short so the problem is more likely acquisition frequency.
>
>However it's a bit strange that this function is the bottleneck.  If their
>workload is doing large numbers of reads or writes from large numbers of
>processes against the same file then they should be hitting heavy
>contention on other locks, such as i_sem and/or tree_lock and/or lru_lock
>and others.
>
>Can you tell us more about the kernel-visible behaviour of this app?
>  
>

I have also seen this problem, and it's hard to reproduce. What you will 
see is udev getting spawned
multiple times as reported by top. I have found its related to 
intermittent failures of the hard drive and
the hotpluger for some reason invoking udev multiple times in response 
to this. I saw it on a Compaq
laptop right before my hard drive croaked, and it seems BIOS specific as 
well, since I have never seen
it or been able to reproduce it reliably.

Jeff

>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

