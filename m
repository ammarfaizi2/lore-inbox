Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318561AbSHQMSB>; Sat, 17 Aug 2002 08:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318652AbSHQMSB>; Sat, 17 Aug 2002 08:18:01 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:8719 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318572AbSHQMSA>; Sat, 17 Aug 2002 08:18:00 -0400
Date: Sat, 17 Aug 2002 13:21:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mel <mel@csn.ul.ie>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: VM Regress 0.5 - Compile error with CONFIG_HIGHMEM
Message-ID: <20020817132153.A11758@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mel <mel@csn.ul.ie>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0208150312220.20123-100000@skynet> <Pine.LNX.4.44.0208171206200.7887-100000@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208171206200.7887-100000@skynet>; from mel@csn.ul.ie on Sat, Aug 17, 2002 at 12:09:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2002 at 12:09:20PM +0100, Mel wrote:
> On Thu, 15 Aug 2002, Mel wrote:
> 
> >
> > Project page: http://www.csn.ul.ie/~mel/projects/vmregress/
> > Download:     http://www.csn.ul.ie/~mel/projects/vmregress/vmregress-0.5.tar.gz
> 
> 0.5 won't compile with CONFIG_HIGHMEM set. Apply the following trivial
> patch and it will compile at least. VM Regress has not been tested with
> CONFIG_HIGHMEM set at all but there is no reason for it to fail because no
> presumptions has been made about the number of nodes or zones in the
> machine
> 
> 
> --- vmregress-0.5/src/sense/kvirtual.c	Tue Aug 13 22:43:48 2002
> +++ vmregress-0.5-highmem/src/sense/kvirtual.c	Sat Aug 17 12:03:02 2002
> @@ -29,6 +29,11 @@
>  #include <linux/mm.h>
>  #include <linux/sched.h>
> 
> +#ifdef CONFIG_HIGHMEM
> +#include <linux/highmem.h>
> +#include <asm/highmem.h>
> +#endif

Shouldn't an undonditional #include <linux/highmem.h> do it much cleaner?

