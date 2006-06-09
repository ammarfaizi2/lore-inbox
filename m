Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWFIH7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWFIH7H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 03:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWFIH7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 03:59:07 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:4555 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751388AbWFIH7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 03:59:05 -0400
Date: Fri, 9 Jun 2006 09:58:40 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: schwidefsky@de.ibm.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       arjan@infradead.org
Subject: Re: 2.6.17-rc5-mm2 link issues on s390
Message-ID: <20060609075840.GA9415@osiris.boeblingen.de.ibm.com>
References: <20060601014806.e86b3cc0.akpm@osdl.org> <447EE5A4.7050201@fr.ibm.com> <1149168482.5279.34.camel@localhost> <447EF175.4040608@fr.ibm.com> <20060608072802.GB9416@osiris.boeblingen.de.ibm.com> <4487EA41.3030400@fr.ibm.com> <20060608110222.GA16871@osiris.boeblingen.de.ibm.com> <44881BD5.2060607@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44881BD5.2060607@fr.ibm.com>
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Cedric Le Goater <clg@fr.ibm.com>
> Replace-Subject: s390 adds __raw_writeq required by __iowrite64_copy.
> 
> It also adds all the related quad routines. 
> 
> Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
> 
> ---
>  include/asm-s390/io.h |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> Index: 2.6.17-rc6-mm1/include/asm-s390/io.h
> ===================================================================
> --- 2.6.17-rc6-mm1.orig/include/asm-s390/io.h
> +++ 2.6.17-rc6-mm1/include/asm-s390/io.h
> @@ -86,20 +86,25 @@ extern void iounmap(void *addr);
>  #define readb(addr) (*(volatile unsigned char *) __io_virt(addr))
>  #define readw(addr) (*(volatile unsigned short *) __io_virt(addr))
>  #define readl(addr) (*(volatile unsigned int *) __io_virt(addr))
> +#define readq(addr) (*(volatile unsigned long long *) __io_virt(addr))
>  
>  #define readb_relaxed(addr) readb(addr)
>  #define readw_relaxed(addr) readw(addr)
>  #define readl_relaxed(addr) readl(addr)
> +#define readq_relaxed(addr) readq(addr)
>  #define __raw_readb readb
>  #define __raw_readw readw
>  #define __raw_readl readl
> +#define __raw_readq readq
>  
>  #define writeb(b,addr) (*(volatile unsigned char *) __io_virt(addr) = (b))
>  #define writew(b,addr) (*(volatile unsigned short *) __io_virt(addr) = (b))
>  #define writel(b,addr) (*(volatile unsigned int *) __io_virt(addr) = (b))
> +#define writeq(b,addr) (*(volatile unsigned long long *) __io_virt(addr) = (b))
>  #define __raw_writeb writeb
>  #define __raw_writew writew
>  #define __raw_writel writel
> +#define __raw_writeq writeq
>  
>  #define memset_io(a,b,c)        memset(__io_virt(a),(b),(c))
>  #define memcpy_fromio(a,b,c)    memcpy((a),__io_virt(b),(c))

Thank you!

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
