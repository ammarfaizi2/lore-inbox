Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932908AbWF2VwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932908AbWF2VwK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932938AbWF2Vvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:51:39 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:32128
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932908AbWF2VvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:51:12 -0400
Date: Thu, 29 Jun 2006 14:50:27 -0700 (PDT)
Message-Id: <20060629.145027.41636491.davem@davemloft.net>
To: bos@pathscale.com
Cc: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il,
       openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH 39 of 39] IB/ipath - use streaming copy in RDMA
 interrupt handler to reduce packet loss
From: David Miller <davem@davemloft.net>
In-Reply-To: <1b00209ef20a0e7893d8.1151617290@eng-12.pathscale.com>
References: <patchbomb.1151617251@eng-12.pathscale.com>
	<1b00209ef20a0e7893d8.1151617290@eng-12.pathscale.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bryan O'Sullivan <bos@pathscale.com>
Date: Thu, 29 Jun 2006 14:41:30 -0700

> +/*
> + * Copy data.  Try not to pollute the dcache with the source data,
> + * because we won't be reading it again.
> + */
> +#if defined(CONFIG_X86_64)
> +void *ipath_memcpy_nc(void *dest, const void *src, size_t n);
> +#else
> +#define ipath_memcpy_nc(dest, src, n) memcpy(dest, src, n)
> +#endif

A facility like this doesn't belong in some arbitrary driver layer.
It belongs as a generic facility the whole kernel could make use
of.

Please stop polluting the infiniband drivers with Opteron crap.
