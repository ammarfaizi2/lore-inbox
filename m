Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312998AbSD3G1O>; Tue, 30 Apr 2002 02:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313090AbSD3G1N>; Tue, 30 Apr 2002 02:27:13 -0400
Received: from imladris.infradead.org ([194.205.184.45]:7183 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S312998AbSD3G1M>; Tue, 30 Apr 2002 02:27:12 -0400
Date: Tue, 30 Apr 2002 07:26:54 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Patricia Gaughen <gone@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] discontigmem support for ia32 NUMA box against 2.4.19pre7
Message-ID: <20020430072654.B2262@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Patricia Gaughen <gone@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200204300115.g3U1FQc16634@w-gaughen.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2002 at 06:15:26PM -0700, Patricia Gaughen wrote:
> +	if [ "$CONFIG_MULTIQUAD" = "y" ]; then
> +   	bool 'Discontiguous Memory Support' CONFIG_DISCONTIGMEM
> +		if [ "$CONFIG_DISCONTIGMEM" = "y" ]; then
> +		define_bool CONFIG_DISCONTIGMEM_X86 y
> +		define_bool CONFIG_IBMNUMAQ y
> +		define_bool CONFIG_NUMA y
> +		fi
> +	fi

CML code uses three tab indentes. Also the way you do the config looks
rather strange. I'd rather ask for IBM NUMAQ support and imply NUMA &
DISCONTIGMEM support if set.  Also CONFIG_DISCONTIGMEM_X86 looks like
an ugly workaround to me, all places where it is used should rather check
for one of CONFIG_DISCONTIGMEM/CONFIG_NUMA/CONFIG_IBMNUMAQ.
(and CONFIG_IBMNUMAQ would better be named CONFIG_X86_NUMAQ, IMHO).

> +
> +#ifdef CONFIG_SMP
> +	/*
> +	 * But first pinch a few for the stack/trampoline stuff
> +	 * FIXME: Don't need the extra page at 4K, but need to fix
> +	 * trampoline before removing it. (see the GDT stuff)
> +	 */
> +	reserve_bootmem_node(NODE_DATA(0), PAGE_SIZE, PAGE_SIZE);
> +#endif

Umm, NUMA without SMP looks rather strange to me..

> +#ifdef CONFIG_X86_LOCAL_APIC
> +	/*
> +	 * Find and reserve possible boot-time SMP configuration:
> +	 */
> +	find_smp_config();
> +#endif

Dito for local APIC.

