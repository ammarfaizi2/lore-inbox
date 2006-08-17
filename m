Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbWHQOCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWHQOCn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 10:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbWHQOCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 10:02:42 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:62367 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964826AbWHQOCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 10:02:40 -0400
Message-ID: <44E4778B.1020808@sw.ru>
Date: Thu, 17 Aug 2006 18:04:59 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [RFC][PATCH 4/7] UBC: syscalls (user interface)
References: <44E33893.6020700@sw.ru> <44E33C3F.3010509@sw.ru> <20060817110940.GC19127@in.ibm.com>
In-Reply-To: <20060817110940.GC19127@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> On Wed, Aug 16, 2006 at 07:39:43PM +0400, Kirill Korotaev wrote:
> 
> 
>>+/*
>>+ *	The setbeanlimit syscall
>>+ */
>>+asmlinkage long sys_setublimit(uid_t uid, unsigned long resource,
>>+		unsigned long *limits)
>>+{
> 
> 
> [snip]
> 
> 
>>+	spin_lock_irqsave(&ub->ub_lock, flags);
>>+	ub->ub_parms[resource].barrier = new_limits[0];
>>+	ub->ub_parms[resource].limit = new_limits[1];
> 
> 
> Would it be usefull to notify the "resource" controller about this
> change in limits? For ex: in case of the CPU controller I wrote 
> (http://lkml.org/lkml/2006/8/4/9), I was finding it usefull to recv
> notification of changes to these limits, so that internal structures
> (which are kept per-task-group) can be updated.
I think this can be added when needed, no?
See no much reason to add notifications which are not used yet.

Please, keep in mind. This patch set can be extended in infinite number
of ways. But!!! It contains only the required minimal functionality.
When we are to add code requiring to know about limit changes or fails
or whatever we can always extend it accordingly.

Thanks,
Kirill
