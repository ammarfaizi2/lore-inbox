Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262714AbULPPMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbULPPMw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 10:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262708AbULPPMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 10:12:44 -0500
Received: from reformers.mr.itd.umich.edu ([141.211.93.147]:46490 "EHLO
	reformers.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S262699AbULPPME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 10:12:04 -0500
Message-ID: <41C1A3F4.2090707@umich.edu>
Date: Thu, 16 Dec 2004 10:04:20 -0500
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Werner Almesberger <werner@almesberger.net>
CC: linux-kernel@vger.kernel.org, kernel@kolivas.org
Subject: Re: [RFC] Generalized prio_tree, revisited
References: <20041216053118.M1229@almesberger.net>
In-Reply-To: <20041216053118.M1229@almesberger.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:
> and so on. So it seems to me that we're just at the level of
> abstraction that gives us the most narrow interface and that
> doesn't hide any information we need to implement the other
> cases. And it's just the "engine" that would be used in all
> cases anyway.

Yeah, makes sense. I think we can consider multi_prio_tree_node
later if many future users of prio_tree code need vma->shared.vm_set
like handling.

I am okay with the patch. I haven't tested it myself and I won't
have time to do so for next few days. Below are some small nitpicks.

>  struct prio_tree_node {
>  	struct prio_tree_node	*left;
>  	struct prio_tree_node	*right;
>  	struct prio_tree_node	*parent;
> +	unsigned long		start;
> +	unsigned long		end;
>  };

I wonder whether we should use [start, last] or [first, last] for
index names because "end" normally means last + 1, e.g., vm_end.
In prio_tree we store closed intervals of form [first, last] and
I think the name "last" makes it more explicit. Did I tell you
nitpicking ?

> +
> +struct prio_tree_node *prio_tree_replace(struct prio_tree_root *root, 
> +                struct prio_tree_node *old, struct prio_tree_node *node);

prio_tree_replace should be static in prio_tree.c.

> +struct prio_tree_node *prio_tree_first(struct prio_tree_iter *iter);

Should we go with prio_tree_iter_init and remove prio_tree_first
(similar to vma_prio_tree_next) ? I am not very particular about it,
though.

> +static void get_index(const struct prio_tree_root *root,

Should be "inline" ?

Thanks,
Rajesh
