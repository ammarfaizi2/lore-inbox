Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266786AbUG1FSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266786AbUG1FSN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 01:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266781AbUG1FSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 01:18:13 -0400
Received: from services.exanet.com ([212.143.73.102]:36107 "EHLO
	services.exanet.com") by vger.kernel.org with ESMTP id S266786AbUG1FSK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 01:18:10 -0400
Message-ID: <41073710.2020306@exanet.com>
Date: Wed, 28 Jul 2004 08:18:08 +0300
From: Avi Kivity <avi@exanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ulrich Weigand <weigand@i1.informatik.uni-erlangen.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Deadlock during heavy write activity to userspace NFS
References: <200407280232.EAA14567@faui1m.informatik.uni-erlangen.de>
In-Reply-To: <200407280232.EAA14567@faui1m.informatik.uni-erlangen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Jul 2004 05:18:09.0269 (UTC) FILETIME=[455F0A50:01C47462]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Weigand wrote:

>Avi Kivity wrote:
>
>  
>
>>In our case, all block I/O is done using 
>>unbuffered I/O, and all memory is preallocated, so we don't need kswapd 
>>at all, just that small bit of memory that syscalls consume.
>>    
>>
>
>Does your userspace process need to send/receive network packets
>in order to perform a write-out?  
>
Yes.

>If so, how can you make sure your
>incoming packets aren't thrown away in out-of-memory situations?
>(Outgoing packets can use PF_MEMALLOC memory I guess, but incoming
>ones aren't associated to any process yet ...)
>
>  
>
I did nothing to address this. So far it works well, even under heavy 
load. I guess a general solution needs to address this as well.

The kernel NFS client (which kswapd depends on) has the same issue. Has 
anyone ever observed kswapd deadlock due to imcoming or outgoing NFS 
packets being discarded due to oom?

Avi
