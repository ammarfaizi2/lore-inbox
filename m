Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262665AbUKRIe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbUKRIe4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 03:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbUKRIe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 03:34:56 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:26848 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S262665AbUKRIez (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 03:34:55 -0500
Date: Thu, 18 Nov 2004 00:37:52 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, Keir.Fraser@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk
Subject: Re: [patch 2] Xen core patch : arch_free_page return value
Message-ID: <20041118083752.GA35159@gaz.sfgoth.com>
References: <E1CUZXm-00053v-00@mta1.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CUZXm-00053v-00@mta1.cl.cam.ac.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One tiny suggestion...

Ian Pratt wrote:
> -void arch_free_page(struct page *page, int order)
> +int arch_free_page(struct page *page, int order)

How about just changing that to...

	void __arch_free_page(struct page *page, int order)

... and leave the rest of the function alone.  Then:

> -extern void arch_free_page(struct page *page, int order);
> +extern int arch_free_page(struct page *page, int order);

Do...

    extern void __arch_free_page(struct page *page, int order);
    #define arch_free_page(page, order) (__arch_free_page((page), (order)), 0)

That way the compiler can omit the "if(...) return" even on UML

-Mitch
