Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbVHYJVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbVHYJVO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 05:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbVHYJVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 05:21:14 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:34029 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S964899AbVHYJVN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 05:21:13 -0400
Message-ID: <430D8D76.6040907@cosmosbay.com>
Date: Thu, 25 Aug 2005 11:20:54 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removes filp_count_lock and changes nr_files type to
 atomic_t
References: <20050824214610.GA3675@localhost.localdomain>	 <1124956563.3222.8.camel@laptopd505.fenrus.org>	 <430D8518.8020502@cosmosbay.com> <1124960744.3222.11.camel@laptopd505.fenrus.org>
In-Reply-To: <1124960744.3222.11.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Thu, 25 Aug 2005 11:20:55 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven a écrit :
> On Thu, 2005-08-25 at 10:45 +0200, Eric Dumazet wrote:
> 
>>This patch removes filp_count_lock spinlock, used to protect files_stat.nr_files.
>>
>>Just use atomic_t type and atomic_inc()/atomic_dec() operations.
>>
>>This patch assumes that atomic_read() is a plain {return v->counter;} on all 
>>architectures. (keywords : sysctl, /proc/sys/fs/file-nr, proc_dointvec)
>>
> 
> 
> this patch adds atomic ops where there were none before

nope... a spinlock/spinunlock contains atomic ops.

> for those architectures that need atomics for read (parisc? arm?)

not today. No atomic needed for read.

> 
> however.. wouldn't it be better to make this a per cpu variable for
> write, and for read iterate or do something smart otherwise?

So on a machine with 256 CPUS, you want to iterate 256 counters ?
nr_files is not heavily touched, no need to expand it.

