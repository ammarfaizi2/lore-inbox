Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266202AbUFPHMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266202AbUFPHMY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 03:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266204AbUFPHMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 03:12:23 -0400
Received: from [213.146.154.40] ([213.146.154.40]:28821 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266202AbUFPHMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 03:12:19 -0400
Date: Wed, 16 Jun 2004 08:12:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: lost dirty bits.
Message-ID: <20040616071214.GA7810@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
References: <20040615174436.GA10098@mschwid3.boeblingen.de.ibm.com> <20040615210919.1c82a5c8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615210919.1c82a5c8.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 09:09:19PM -0700, Andrew Morton wrote:
>  #define ClearPageReferenced(page)	clear_bit(PG_referenced, &(page)->flags)
>  #define TestClearPageReferenced(page) test_and_clear_bit(PG_referenced, &(page)->flags)
>  
> -#ifndef arch_set_page_uptodate
> -#define arch_set_page_uptodate(page) do { } while (0)
> +#ifdef arch_set_page_uptodate
> +#define SetPageUptodate(page) arch_set_page_uptodate(page)
> +#else
> +#define SetPageUptodate(page) set_bit(PG_uptodate, &(page)->flags)
>  #endif

Eek.  It looks like SetPageUptodate, it smells like SetPageUptodate, why
do you give it another name?  Just put a

#ifndef SetPageUptodate	/* S390 wants to override this */
#define SetPageUptodate		set_bit(PG_uptodate, &(page)->flags)
#endif

in mm.h

