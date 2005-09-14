Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932779AbVINVmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932779AbVINVmW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 17:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932781AbVINVmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 17:42:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11429 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932780AbVINVmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 17:42:21 -0400
Message-ID: <432897BB.6040303@redhat.com>
Date: Wed, 14 Sep 2005 17:35:55 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: dipankar@in.ibm.com, "David S. Miller" <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: [PATCH] reorder struct files_struct
References: <20050914191842.GA6315@in.ibm.com>	<20050914.125750.05416211.davem@davemloft.net>	<20050914201550.GB6315@in.ibm.com> <20050914.132936.105214487.davem@davemloft.net> <43289376.7050205@cosmosbay.com>
In-Reply-To: <43289376.7050205@cosmosbay.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet wrote:

> Hi
>
> Browsing (and using) the excellent RCU infrastructure for files that 
> was adopted for 2.6.14-rc1, I noticed that the file_lock spinlock sit 
> close to mostly read fields of 'struct files_struct'
>
> In SMP (and NUMA) environnements, each time a thread wants to open or 
> close a file, it has to acquire the spinlock, thus invalidating the 
> cache line containing this spinlock on other CPUS. So other threads 
> doing read()/write()/... calls that use RCU to access the file table 
> are going to ask further memory (possibly NUMA) transactions to read 
> again this memory line.
>
> Please consider applying this patch. It moves the spinlock to another 
> cache line, so that concurrent threads can share the cache line 
> containing 'count' and 'fdt' fields. 


How was the performance impact of this change measured?

    Thanx...

       ps
