Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWHQOAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWHQOAH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 10:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbWHQN75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:59:57 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:47206 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932490AbWHQN7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:59:48 -0400
Message-ID: <44E476DE.4050903@sw.ru>
Date: Thu, 17 Aug 2006 18:02:06 +0400
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
Subject: Re: [ckrm-tech] [RFC][PATCH 2/7] UBC: core (structures, API)
References: <44E33893.6020700@sw.ru> <44E33BB6.3050504@sw.ru> <20060817110913.GB19127@in.ibm.com>
In-Reply-To: <20060817110913.GB19127@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Aug 16, 2006 at 07:37:26PM +0400, Kirill Korotaev wrote:
> 
>>+struct user_beancounter
>>+{
>>+	atomic_t		ub_refcount;
>>+	spinlock_t		ub_lock;
>>+	uid_t			ub_uid;
>>+	struct hlist_node	hash;
>>+
>>+	struct user_beancounter	*parent;
> 
> 
> This seems to hint at some heirarchy of ubc? How would that heirarchy be
> used? I cant find anything in the patch which forms this heirarchy
> (basically I dont see any place where beancounter_findcreate() is called
> with non-NULL 2nd arg).
yes, it is possible to use hierarchical beancounters.
kernel memory, user memory and TCP/IP buffers are accounted hierarchicaly.
user interface for this is not provided yet as it would complicate patchset
and increase number of topics for discussion :)

> [snip]
> 
> 
>>+static void init_beancounter_syslimits(struct user_beancounter *ub)
>>+{
>>+	int k;
>>+
>>+	for (k = 0; k < UB_RESOURCES; k++)
>>+		ub->ub_parms[k].barrier = ub->ub_parms[k].limit;
> 
> 
> This sets barrier to 0. Is this value of 0 interpreted differently by
> different controllers? One way to interpret it is "dont allocate any
> resource", other way to interpret it is "don't care - give me what you
> can" (which makes sense for stuff like CPU and network bandwidth).
every patch which adds a resource modifies this function and sets
some default limit. Check: [PATCH 5/7] UBC: kernel memory accounting (core)

Thanks,
Kirill

