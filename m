Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbULIQiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbULIQiI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 11:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbULIQiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 11:38:07 -0500
Received: from mail00hq.adic.com ([63.81.117.10]:38359 "EHLO mail00hq.adic.com")
	by vger.kernel.org with ESMTP id S261548AbULIQhu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 11:37:50 -0500
Message-ID: <41B87E68.2070508@xfs.org>
Date: Thu, 09 Dec 2004 10:33:44 -0600
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: negative dentry_stat.nr_unused causes aggressive dcache pruning
References: <41B77D54.4080909@xfs.org> <20041209020919.6f17e322.akpm@osdl.org>
In-Reply-To: <20041209020919.6f17e322.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Dec 2004 16:37:45.0223 (UTC) FILETIME=[69165970:01C4DE0D]
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

Looked again, you are right, looks like a 2.4 only problem and even there I
am darned if I can see how it leaks now, still digging as to where it is coming
from. I have a box which goes negative shortly after bootup, this seems to put
it in a feedback loop and  it just keeps heading south from there pushing on the
dcache. This is running on a fedora legacy kernel for redhat 9.0 which I added
kdb to. Starting to wonder if the compiler screwed up somewhere. I have an
external fiberchannel driver loaded, but it does not have any dentry related
code in it.

Steve

