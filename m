Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbVAGXVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVAGXVF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 18:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVAGXUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 18:20:49 -0500
Received: from [213.85.13.118] ([213.85.13.118]:55170 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S261718AbVAGXRp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 18:17:45 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: pmarques@grupopie.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       hch@infradead.org
Subject: Re: [RFC] per thread page reservation patch
References: <20050103011113.6f6c8f44.akpm@osdl.org>
	<20050103114854.GA18408@infradead.org> <41DC2386.9010701@namesys.com>
	<1105019521.7074.79.camel@tribesman.namesys.com>
	<20050107144644.GA9606@infradead.org>
	<1105118217.3616.171.camel@tribesman.namesys.com>
	<41DEDF87.8080809@grupopie.com> <m1llb5q7qs.fsf@clusterfs.com>
	<20050107132459.033adc9f.akpm@osdl.org> <m1d5wgrir7.fsf@clusterfs.com>
	<20050107150315.3c1714a4.akpm@osdl.org>
From: Nikita Danilov <nikita@clusterfs.com>
Date: Sat, 08 Jan 2005 02:17:31 +0300
In-Reply-To: <20050107150315.3c1714a4.akpm@osdl.org> (Andrew Morton's
 message of "Fri, 7 Jan 2005 15:03:15 -0800")
Message-ID: <m18y74rfqs.fsf@clusterfs.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.5 (chayote, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Nikita Danilov <nikita@clusterfs.com> wrote:
>>
>> > And the whole idea is pretty flaky really - how can one precalculate how
>> > much memory an arbitrary md-on-dm-on-loop-on-md-on-NBD stack will want to
>> > use?  It really would be better if we could drop the whole patch and make
>> > reiser4 behave more sanely when its writepage is called with for_reclaim=1.
>> 
>> Reiser4 doesn't use this for ->writepage(), by the way. This is used by
>> tree balancing code to assure that balancing cannot get -ENOMEM in the
>> middle of tree modification, because undo is _so_ very complicated.
>
> Oh.  And that involves performing I/O, yes?

Yes, balancing may read tree or bitmap nodes from the disk.

>
> Why does the filesystem risk going oom during the rebalance anyway?  Is it
> doing atomic allocations?

No, just __alloc_pages(GFP_KERNEL, 0, ...) returns NULL. When this
happens, the only thing balancing can do is to panic.

Nikita.


