Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965162AbWD0QKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965162AbWD0QKr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 12:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbWD0QKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 12:10:46 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:27555 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965162AbWD0QKq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 12:10:46 -0400
Message-ID: <4450ECE8.6050708@austin.ibm.com>
Date: Thu, 27 Apr 2006 11:10:16 -0500
From: jschopp <jschopp@austin.ibm.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
CC: LKML <linux-kernel@vger.kernel.org>,
       LHMS <lhms-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>
Subject: Re: [Lhms-devel] [PATCH] register hot-added memory to iomem resource
References: <20060427204904.5037f6ea.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060427204904.5037f6ea.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +/* add this memory to iomem resource */
> +static void register_memory_resource(u64 start, u64 size)
> +{
> +	struct resource *res;
> +
> +	res = kzalloc(sizeof(struct resource), GFP_KERNEL);
> +	BUG_ON(!res);
> +
> +	res->name = "System RAM";
> +	res->start = start;
> +	res->end = start + size - 1;
> +	res->flags = IORESOURCE_MEM;
> +	if (request_resource(&iomem_resource, res) < 0) {
> +		printk("System RAM resource %llx - %llx cannot be added\n",
> +		(unsigned long long)res->start, (unsigned long long)res->end);
> +		kfree(res);
> +	}
> +}

This is more of a question than a comment.  Is this code saying that all memory we are 
adding is available for IO?  And is it really true that on all platforms any memory we add 
can be used that way?
