Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbTJOIHZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 04:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbTJOIHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 04:07:25 -0400
Received: from jaguar.mkp.net ([192.139.46.146]:38103 "EHLO jaguar")
	by vger.kernel.org with ESMTP id S262446AbTJOIHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 04:07:24 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: Patrick Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org,
       davidm@napali.hpl.hp.com, jbarnes@sgi.com
Subject: Re: [PATCH] Altix I/O code cleanup
References: <3F872984.7877D382@sgi.com> <20031013095652.A25495@infradead.org>
From: Jes Sorensen <jes@trained-monkey.org>
Date: 15 Oct 2003 04:07:07 -0400
In-Reply-To: <20031013095652.A25495@infradead.org>
Message-ID: <yq0llrmncus.fsf@trained-monkey.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:

Christoph> On Fri, Oct 10, 2003 at 04:49:57PM -0500, Patrick Gefre
Christoph> wrote:

Christoph> Why do you remove the per-nod wrappers?  Unlike the other
Christoph> these actually had some use as preparation for a node-aware
Christoph> kmalloc..

I believe it was me who nuked it, until we start using it properly I
don't see any reason for keeping it as a placeholder.

>>  - intr_hdl = snia_kmem_alloc_node(sizeof(struct hub_intr_s),
>> KM_NOSLEEP, cnode); + intr_hdl = kmalloc(sizeof(struct hub_intr_s),
>> GFP_KERNEL); ASSERT_ALWAYS(intr_hdl);

Christoph> NULL return not handled again (and the assert is totally
Christoph> useless)

ASSERT_ALWAYS checks it, it may not be pretty but it does check it.

>> -#define NEWAf(ptr,n,f) (ptr = snia_kmem_zalloc((n)*sizeof
>> (*(ptr)), (f&PCIIO_NOSLEEP)?KM_NOSLEEP:KM_SLEEP)) -#define
>> NEWA(ptr,n) (ptr = snia_kmem_zalloc((n)*sizeof (*(ptr)), KM_SLEEP))
>> +#define NEWAf(ptr,n,f) (ptr = snia_kmem_zalloc((n)*sizeof
>> (*(ptr)))) +#define NEWA(ptr,n) (ptr = snia_kmem_zalloc((n)*sizeof
>> (*(ptr)))) #define DELA(ptr,n) (kfree(ptr))

Christoph> What about killing this stupid wrappers while you're at it?
Christoph> Also PCIIO_NOSLEEP is never set.

All the NEWA stuff is going, I sent Pat a patch for it already, it's
going away.

Cheers,
Jes
