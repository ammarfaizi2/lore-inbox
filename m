Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVAGU2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVAGU2b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 15:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbVAGUZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 15:25:05 -0500
Received: from [213.85.13.118] ([213.85.13.118]:61825 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S261595AbVAGUVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 15:21:40 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: [RFC] per thread page reservation patch
References: <20050103011113.6f6c8f44.akpm@osdl.org>
	<20050103114854.GA18408@infradead.org> <41DC2386.9010701@namesys.com>
	<1105019521.7074.79.camel@tribesman.namesys.com>
	<20050107144644.GA9606@infradead.org>
	<1105118217.3616.171.camel@tribesman.namesys.com>
	<20050107104838.0eacd301.akpm@osdl.org>
From: Nikita Danilov <nikita@clusterfs.com>
Date: Fri, 07 Jan 2005 23:21:19 +0300
In-Reply-To: <20050107104838.0eacd301.akpm@osdl.org> (Andrew Morton's
 message of "Fri, 7 Jan 2005 10:48:38 -0800")
Message-ID: <m1u0ptq9c0.fsf@clusterfs.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.5 (chayote, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Vladimir Saveliev <vs@namesys.com> wrote:
>>
>> +int perthread_pages_reserve(int nrpages, int gfp)
>>  +{
>>  +	int i;
>>  +	struct list_head  accumulator;
>>  +	struct list_head *per_thread;
>>  +
>>  +	per_thread = get_per_thread_pages();
>>  +	INIT_LIST_HEAD(&accumulator);
>>  +	list_splice_init(per_thread, &accumulator);
>>  +	for (i = 0; i < nrpages; ++i) {
>
> This will end up reserving more pages than were asked for, if
> current->private_pages_count is non-zero.  Deliberate?

Yes. This is to make modular usage possible, so that


        perthread_pages_reserve(nrpages, gfp_mask);

        /* call some other code... */

        perthread_pages_release(unused_pages);

works correctly if "some other code" does per-thread reservations
too.

Nikita.
