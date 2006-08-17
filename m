Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWHQMO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWHQMO0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 08:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWHQMO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 08:14:26 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:20460 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932108AbWHQMOZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 08:14:25 -0400
Date: Thu, 17 Aug 2006 16:39:13 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [RFC][PATCH 2/7] UBC: core (structures, API)
Message-ID: <20060817110913.GB19127@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <44E33893.6020700@sw.ru> <44E33BB6.3050504@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E33BB6.3050504@sw.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 07:37:26PM +0400, Kirill Korotaev wrote:
> +struct user_beancounter
> +{
> +	atomic_t		ub_refcount;
> +	spinlock_t		ub_lock;
> +	uid_t			ub_uid;
> +	struct hlist_node	hash;
> +
> +	struct user_beancounter	*parent;

This seems to hint at some heirarchy of ubc? How would that heirarchy be
used? I cant find anything in the patch which forms this heirarchy
(basically I dont see any place where beancounter_findcreate() is called
with non-NULL 2nd arg).

[snip]

> +static void init_beancounter_syslimits(struct user_beancounter *ub)
> +{
> +	int k;
> +
> +	for (k = 0; k < UB_RESOURCES; k++)
> +		ub->ub_parms[k].barrier = ub->ub_parms[k].limit;

This sets barrier to 0. Is this value of 0 interpreted differently by
different controllers? One way to interpret it is "dont allocate any
resource", other way to interpret it is "don't care - give me what you
can" (which makes sense for stuff like CPU and network bandwidth).



-- 
Regards,
vatsa
