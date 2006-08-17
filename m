Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWHQMQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWHQMQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 08:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWHQMQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 08:16:59 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:12425 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932211AbWHQMQ5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 08:16:57 -0400
Date: Thu, 17 Aug 2006 16:39:40 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [RFC][PATCH 4/7] UBC: syscalls (user interface)
Message-ID: <20060817110940.GC19127@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <44E33893.6020700@sw.ru> <44E33C3F.3010509@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E33C3F.3010509@sw.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 07:39:43PM +0400, Kirill Korotaev wrote:

> +/*
> + *	The setbeanlimit syscall
> + */
> +asmlinkage long sys_setublimit(uid_t uid, unsigned long resource,
> +		unsigned long *limits)
> +{

[snip]

> +	spin_lock_irqsave(&ub->ub_lock, flags);
> +	ub->ub_parms[resource].barrier = new_limits[0];
> +	ub->ub_parms[resource].limit = new_limits[1];

Would it be usefull to notify the "resource" controller about this
change in limits? For ex: in case of the CPU controller I wrote 
(http://lkml.org/lkml/2006/8/4/9), I was finding it usefull to recv
notification of changes to these limits, so that internal structures
(which are kept per-task-group) can be updated.


-- 
Regards,
vatsa
