Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWHPSrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWHPSrl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 14:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWHPSrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 14:47:41 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:10916 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750800AbWHPSrj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 14:47:39 -0400
Subject: Re: [RFC][PATCH 5/7] UBC: kernel memory accounting (core)
From: Dave Hansen <haveblue@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
In-Reply-To: <44E33C8A.6030705@sw.ru>
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>
Content-Type: text/plain
Date: Wed, 16 Aug 2006 11:47:09 -0700
Message-Id: <1155754029.9274.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-16 at 19:40 +0400, Kirill Korotaev wrote:
> --- ./include/linux/mm.h.kmemcore       2006-08-16 19:10:38.000000000
> +0400
> +++ ./include/linux/mm.h        2006-08-16 19:10:51.000000000 +0400
> @@ -274,8 +274,14 @@ struct page {
>         unsigned int gfp_mask;
>         unsigned long trace[8];
>  #endif
> +#ifdef CONFIG_USER_RESOURCE
> +       union {
> +               struct user_beancounter *page_ub;
> +       } bc;
> +#endif
>  };

Is everybody OK with adding this accounting to the 'struct page'?  Is
there any kind of noticeable performance penalty for this?  I thought
that we had this aligned pretty well on cacheline boundaries.

How many things actually use this?  Can we have the slab ubcs without
the struct page pointer?

-- Dave

