Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbULIU7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbULIU7r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 15:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbULIU7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 15:59:47 -0500
Received: from mail00hq.adic.com ([63.81.117.10]:14928 "EHLO mail00hq.adic.com")
	by vger.kernel.org with ESMTP id S261621AbULIU6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 15:58:52 -0500
Message-ID: <41B8BB96.4040006@xfs.org>
Date: Thu, 09 Dec 2004 14:54:46 -0600
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: negative dentry_stat.nr_unused causes aggressive dcache pruning
References: <41B77D54.4080909@xfs.org> <20041209020919.6f17e322.akpm@osdl.org>
In-Reply-To: <20041209020919.6f17e322.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Dec 2004 20:58:47.0997 (UTC) FILETIME=[E0D3FED0:01C4DE31]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Steve Lord <lord@xfs.org> wrote:
> 
>>I have seen this stat go negative (just from booting up a multi cpu box),
>> and looking at the code, it is manipulated without locking in a number
>> of places. I have only seen this in real life on a 2.4 kernel, but 2.6
>> also looks vulnerable.
> 
> 
> In 2.6, both dentry_stat.nr_unused and dentry_stat.nr_dentry are covered
> by dcache_lock.  I just double-checked and all seems well.
> 

I still do not know exactly how the count gets negative, but I tracked it
down to a user space app from emulex called HBAanywhere. The only thing I
can see this doing which might be related is attempting to open a lot of
non-existant /proc entries:

	/proc/scsi//120
	/proc/scsi//121
	etc...

Yes there is a // in there.

I ran with a BUG call if we manipulate nr_unused without the dcache lock
and it never tripped. All very wierd.

Steve



