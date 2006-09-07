Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWIGQaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWIGQaQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 12:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWIGQaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 12:30:15 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:7594 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932267AbWIGQaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 12:30:10 -0400
Message-ID: <450048BD.6050803@in.ibm.com>
Date: Thu, 07 Sep 2006 21:58:45 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Hugh Dickins <hugh@veritas.com>, Matt Helsley <matthltc@us.ibm.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       devel@openvz.org, Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [PATCH 11/13] BC: vmrss (preparations)
References: <44FD918A.7050501@sw.ru> <44FD9853.6040002@sw.ru>
In-Reply-To: <44FD9853.6040002@sw.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:
> This patch does simple things:
> - intruduces an bc_magic field on beancunter to make sure
>   union on struct page is correctly used in next patches
> - adds nr_beancounters
> - adds unused_privvmpages variable (counter of privvm pages
>   which are not mapped into VM address space and thus potentially
>   can be allocated later)
> 
> +static inline void privvm_uncharge(struct beancounter *bc, unsigned long sz)
> +{
> +	if (unlikely(bc->unused_privvmpages < sz)) {
> +		printk("BC: overuncharging %d unused pages: val %lu held %lu\n",
> +				bc->bc_id, sz, bc->unused_privvmpages);

I hit this path, when I do not enable CONFIG_BEANCOUNTERS_RSS. I suspect it has
something to do with the code in mod_rss_pages(). I suspect the that
CONFIG_BEANCOUNTERS_RSS needs to be enabled to get the accounting right.

In addition, Could you please make this a warning with KERN_WARNING.

> +		sz = bc->unused_privvmpages;
> +	}
> +	bc->unused_privvmpages -= sz;
> +	bc_update_privvmpages(bc);
> +}
> +
-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
