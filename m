Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbVICO7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbVICO7b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 10:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbVICO7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 10:59:31 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:61866 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1750779AbVICO7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 10:59:31 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH 03/11] memory hotplug prep: __section_nr helper
Date: Sat, 3 Sep 2005 17:59:06 +0300
User-Agent: KMail/1.8.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20050902205643.9A4EC17A@kernel.beaverton.ibm.com> <20050902205645.FD6DE397@kernel.beaverton.ibm.com>
In-Reply-To: <20050902205645.FD6DE397@kernel.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509031759.06449.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 September 2005 23:56, Dave Hansen wrote:
> 
> A little helper that we use in the hotplug code.
> 
> Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
> ---
> 
>  memhotplug-dave/include/linux/mmzone.h |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+)
> 
> diff -puN include/linux/mmzone.h~C3-__section_nr include/linux/mmzone.h
> --- memhotplug/include/linux/mmzone.h~C3-__section_nr	2005-08-18 14:59:45.000000000 -0700
> +++ memhotplug-dave/include/linux/mmzone.h	2005-08-18 14:59:45.000000000 -0700
> @@ -511,6 +511,31 @@ static inline struct mem_section *__nr_t
>  }
>  
>  /*
> + * Although written for the SPARSEMEM_EXTREME case, this happens
> + * to also work for the flat array case becase
> + * NR_SECTION_ROOTS==NR_MEM_SECTIONS.
> + */
> +static inline int __section_nr(struct mem_section* ms)
> +{
> +	unsigned long root_nr;
> +	struct mem_section* root;
> +
> +	for (root_nr = 0;
> +	     root_nr < NR_MEM_SECTIONS;
> +	     root_nr += SECTIONS_PER_ROOT) {
> +		root = __nr_to_section(root_nr);
> +
> +		if (!root)
> +			continue;
> +
> +		if ((ms >= root) && (ms < (root + SECTIONS_PER_ROOT)))
> +		     break;
> +	}
> +
> +	return (root_nr * SECTIONS_PER_ROOT) + (ms - root);
> +}
> +
> +/*

isn't it too much for the inlining?
--
vda
