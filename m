Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbWHQLnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWHQLnh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 07:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWHQLnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 07:43:37 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:59565 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964821AbWHQLng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 07:43:36 -0400
Message-ID: <44E456F4.10001@sw.ru>
Date: Thu, 17 Aug 2006 15:45:56 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH 2/7] UBC: core (structures, API)
References: <44E33893.6020700@sw.ru> <44E33BB6.3050504@sw.ru> <20060816171527.GB27898@kroah.com>
In-Reply-To: <20060816171527.GB27898@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>+struct user_beancounter
>>+{
>>+	atomic_t		ub_refcount;
> 
> 
> Why not use a struct kref here instead of rolling your own reference
> counting logic?

We need more complex decrement/locking scheme than krefs
provide. e.g. in __put_beancounter() we need
atomic_dec_and_lock_irqsave() semantics for performance optimizations.

Kirill

