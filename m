Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261447AbSI2RVW>; Sun, 29 Sep 2002 13:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261521AbSI2RVV>; Sun, 29 Sep 2002 13:21:21 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:2067 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261447AbSI2RVV>; Sun, 29 Sep 2002 13:21:21 -0400
Date: Sun, 29 Sep 2002 18:26:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andi Kleen <ak@muc.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use __attribute__((malloc)) for gcc 3.2
Message-ID: <20020929182643.C8564@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andi Kleen <ak@muc.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20020929152731.GA10631@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020929152731.GA10631@averell>; from ak@muc.de on Sun, Sep 29, 2002 at 05:27:31PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2002 at 05:27:31PM +0200, Andi Kleen wrote:
> -extern pgd_t *pgd_alloc(struct mm_struct *);
> +extern pgd_t *pgd_alloc(struct mm_struct *) malloc_function;

Anz chance you could make that __malloc?  That how the other
atrributes in the kernel (e.g. __init/__exit) work.

> +/* Function allocates new memory and return cannot alias with anything */
> +#define malloc_function __attribute__((malloc))
> +/* Never inline */
> +#define noinline __attribute__((noinline))
> +#else
> +#define malloc_function
> +#define noinline
> +#endif

Dito for __noinline?  And IMHO compiler.h is the better place for this.

BTW, do you have any stats on the better optimization?
