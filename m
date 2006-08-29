Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965279AbWH2U3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965279AbWH2U3z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 16:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965280AbWH2U3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 16:29:55 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:35544 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965279AbWH2U3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 16:29:55 -0400
Subject: Re: [ckrm-tech] [PATCH 6/7] BC: kernel memory (core)
From: Dave Hansen <haveblue@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Matt Helsley <matthltc@us.ibm.com>, Alexey Dobriyan <adobriyan@mail.ru>,
       Oleg Nesterov <oleg@tv-sign.ru>, devel@openvz.org,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <44F45601.9060807@sw.ru>
References: <44F45045.70402@sw.ru>  <44F45601.9060807@sw.ru>
Content-Type: text/plain
Date: Tue, 29 Aug 2006 13:29:42 -0700
Message-Id: <1156883382.5408.153.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-29 at 18:58 +0400, Kirill Korotaev wrote:
> @@ -274,8 +274,14 @@ struct page {
>         unsigned int gfp_mask;
>         unsigned long trace[8];
>  #endif
> +#ifdef CONFIG_BEANCOUNTERS
> +       union {
> +               struct beancounter      *page_bc;
> +       } bc;
> +#endif
>  }; 

I know you're probably saving this union for when you put some userspace
stuff in here or something.  But, for now, it would probably be best
just to leave it as a plain struct, or even an anonymous union.

You probably had to use gcc 2 when this was written and couldn't use
anonymous unions, right?

-- Dave

