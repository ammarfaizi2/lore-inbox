Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbVCZDB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbVCZDB3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 22:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVCZDB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 22:01:29 -0500
Received: from fire.osdl.org ([65.172.181.4]:491 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261923AbVCZDBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 22:01:15 -0500
Message-ID: <4244D068.3080900@osdl.org>
Date: Fri, 25 Mar 2005 19:00:56 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org, apw@shadowen.org
Subject: Re: [RFC][PATCH 1/4] create mm/Kconfig for arch-independent memory
 options
References: <E1DEwlP-0006BQ-00@kernel.beaverton.ibm.com>
In-Reply-To: <E1DEwlP-0006BQ-00@kernel.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> With sparsemem and memory hotplug there are quite a few options that
> we kept adding identically in several different architectures.  This
> new file allows some of these to be consolidated.
> 
> Signed-off-by: Andy Whitcroft <apw@shadowen.org>
> Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
> ---
> 
>  memhotplug-dave/mm/Kconfig |   41 +++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 41 insertions(+)
> 
> diff -puN mm/Kconfig~A6-mm-Kconfig mm/Kconfig
> --- memhotplug/mm/Kconfig~A6-mm-Kconfig	2005-03-25 08:08:22.000000000 -0800
> +++ memhotplug-dave/mm/Kconfig	2005-03-25 08:08:22.000000000 -0800
> @@ -0,0 +1,41 @@
> +choice
> +	prompt "Memory model"
> +	default FLATMEM
> +	default SPARSEMEM if ARCH_SPARSEMEM_DEFAULT
> +	default DISCONTIGMEM if ARCH_DISCONTIGMEM_DEFAULT
> +
> +config FLATMEM
> +	bool "Flat Memory"
> +	depends on !ARCH_DISCONTIGMEM_ENABLE || ARCH_FLATMEM_ENABLE
> +	help
> +	  This option allows you to change some of the ways that
> +	  Linux manages its memory internally.  Most users will
> +	  only have one option here: FLATMEM.  This is normal
> +	  and a correct option.
> +
> +	  Some users of more advanced features like NUMA and
> +	  memory hotplug may have different options here.
> +	  DISCONTIGMEM is an more mature, better tested system,
> +	  but is incompatible with memory hotplug and may suffer
> +	  decreased performance over SPARSEMEM.  If unsure between
> +	  "Sparse Memory" and "Discontiguous Memory", choose
Where is the "Sparse Memory" option?  I didn't find it.

> +	  "Discontiguous Memory".
> +
> +	  If unsure, choose FLATMEM.
> +
> +config DISCONTIGMEM
> +	bool "Discontigious Memory"
> +	depends on ARCH_DISCONTIGMEM_ENABLE
> +	help
> +	  If unsure, choose this option over "Sparse Memory".
Same question....

> +endchoice
> +
> +#
> +# Both the NUMA code and DISCONTIGMEM use arrays of pg_data_t's
> +# to represent different areas of memory.  This variable allows
> +# those dependencies to exist individually.
> +#
> +config NEED_MULTIPLE_NODES
> +	def_bool y
> +	depends on DISCONTIGMEM || NUMA


-- 
~Randy
