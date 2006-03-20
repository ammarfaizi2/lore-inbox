Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965178AbWCTTTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965178AbWCTTTV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 14:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965185AbWCTTTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 14:19:20 -0500
Received: from fmr20.intel.com ([134.134.136.19]:30140 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S965178AbWCTTTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 14:19:20 -0500
Message-ID: <441EFFF2.7000301@ichips.intel.com>
Date: Mon, 20 Mar 2006 11:18:10 -0800
From: Sean Hefty <mshefty@ichips.intel.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, bunk@stusta.de
Subject: Re: [openib-general] Re: 2.6.16-rc6-mm2: new RDMA CM EXPORT_SYMBOL's
References: <20060318172507.GC14608@stusta.de>	<ORSMSX401FRaqbC8wSA00000004@orsmsx401.amr.corp.intel.com>	<20060318171926.7cb182fb.akpm@osdl.org> <ada64m9eywi.fsf@cisco.com>
In-Reply-To: <ada64m9eywi.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
> Looking at this list of exports, I do see a couple of things that
> could maybe be improved:
> 
>     > +EXPORT_SYMBOL(rdma_wq);
>     > +EXPORT_SYMBOL(rdma_translate_ip);
>     > +EXPORT_SYMBOL(rdma_resolve_ip);
>     > +EXPORT_SYMBOL(rdma_addr_cancel);
> 
> First, rdma_wq seems like a strange internal thing to be exporting.
> Sean, why does more than one module need to use the same workqueue?

This is simply an attempt to reduce/combine work queues used by the Infiniband 
code.  This keeps the threading a little simpler in the rdma_cm, since all 
callbacks are invoked using the same work queue.  (I'm also using this with the 
local SA/multicast code, but that's not ready for merging.)

> Second, the naming of rdma_addr_cancel() is not that symmetric with
> the rdma_{translate,resolve}_ip() functions.  Unfortunately I'm just
> clever enough to criticize, not clever enough to come up with a better
> suggestion.

rdma_resolve_ip() is the operation actually being canceled if that makes it 
easier to come up with a better name.

- Sean
