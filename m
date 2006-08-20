Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751497AbWHTFBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbWHTFBN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 01:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWHTFBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 01:01:13 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:14469 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750759AbWHTFBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 01:01:12 -0400
Message-ID: <44E7EC8E.3080505@in.ibm.com>
Date: Sun, 20 Aug 2006 10:31:02 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [RFC][PATCH 2/7] UBC: core (structures, API)
References: <44E33893.6020700@sw.ru> <44E33BB6.3050504@sw.ru>
In-Reply-To: <44E33BB6.3050504@sw.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +
> +void __put_beancounter(struct user_beancounter *ub)
> +{
> +	unsigned long flags;
> +	struct user_beancounter *parent;
> +
> +again:
> +	parent = ub->parent;
> +	/* equevalent to atomic_dec_and_lock_irqsave() */
> +	local_irq_save(flags);
> +	if (likely(!atomic_dec_and_lock(&ub->ub_refcount, &ub_hash_lock))) {
> +		if (unlikely(atomic_read(&ub->ub_refcount) < 0))
> +			printk(KERN_ERR "UB: Bad ub refcount: ub=%p, "
> +					"luid=%d, ref=%d\n",
> +					ub, ub->ub_uid,
> +					atomic_read(&ub->ub_refcount));
> +		local_irq_restore(flags);
> +		return;

Minor comment - the printk (I think there is one other place) could come after 
the local_irq_restore()

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
