Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbWCXTL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWCXTL5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 14:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbWCXTL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 14:11:57 -0500
Received: from mx.pathscale.com ([64.160.42.68]:58303 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S964789AbWCXTL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 14:11:56 -0500
Subject: Re: [PATCH 0 of 18] ipath driver - for inclusion in 2.6.17
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: akpm@osdl.org, greg@kroah.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <ada4q1nr7pu.fsf@cisco.com>
References: <patchbomb.1143175292@eng-12.pathscale.com>
	 <ada4q1nr7pu.fsf@cisco.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Fri, 24 Mar 2006 11:11:55 -0800
Message-Id: <1143227515.30626.43.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-24 at 10:57 -0800, Roland Dreier wrote:

> It's customary to work through subsystem maintainers to merge new drivers...

OK, I'll feed patches to you, then.  No inconvenience intended.

Thanks for applying the patches.

> I fixed a couple of minor whitespace problems and made it actually
> build (hint: the constant RDMA_NODE_IB_CA does not exist in the
> upstream kernel).

Oops.

> It seems you need to fix up your Kconfig dependencies somewhat.

Will do.

>   On
> x86_64 allnoconfig + CONFIG_PCI=y, CONFIG_PCI_MSI=y,
> CONFIG_INFINIBAND=y, CONFIG_IPATH_CORE=y, CONFIG_INFINIBAND_IPATH=y, I get:
> 
>     drivers/built-in.o: In function `ipath_free_pddata': undefined reference to `kfree_skb'
>     drivers/built-in.o: In function `ipath_alloc_skb': undefined reference to `__alloc_skb'
>     drivers/built-in.o: In function `ipath_kreceive': undefined reference to `skb_over_panic'
>     drivers/built-in.o: In function `ipath_init_chip': undefined reference to `kfree_skb'

Would your preference be to slap #ifdefs around those, or to just
require CONFIG_NET in Kconfig?  The core driver should work fine without
any kernel-level networking support, so I suppose the former makes more
sense.

> It also looks like there are a few problems on ia64:
> 
>     drivers/infiniband/hw/ipath/ipath_verbs.c:733: warning: implicit declaration of function `atomic_set_mask'
>     drivers/infiniband/hw/ipath/ipath_verbs.c:734: warning: implicit declaration of function `atomic_clear_mask'
>     drivers/infiniband/hw/ipath/ipath_verbs.c: In function `show_stats':
>     drivers/infiniband/hw/ipath/ipath_verbs.c:1184: warning: long long unsigned int format, u64 arg (arg 4)
>     drivers/infiniband/hw/ipath/ipath_verbs.c:1184: warning: long long unsigned int format, u64 arg (arg 5)
>     drivers/infiniband/hw/ipath/ipath_pe800.c: In function `ipath_pe_handle_hwerrors':
>     drivers/infiniband/hw/ipath/ipath_pe800.c:353: warning: long long unsigned int format, long unsigned int arg (arg 5)
>     drivers/infiniband/hw/ipath/ipath_pe800.c:353: warning: long long unsigned int format, long unsigned int arg (arg 3)

That's going to be interesting to test, because I don't have any ia64
hardware to even compile on.  I have tested on x86_64 and powerpc, so
this seems like an arch-level header deficiency.  Any idea what to do
about it?

> I also wouldn't say the driver is sparse clean.

I've been building with C=1 for months.  I'll see if I can figure out
why you're getting such different results.

	<b

