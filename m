Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264484AbUANWgA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 17:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264433AbUANWeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 17:34:19 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:30649 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S264398AbUANWdt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 17:33:49 -0500
Date: Wed, 14 Jan 2004 15:33:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: davidm@hpl.hp.com
Cc: Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] 2.6 && module + -g && kernel w/o -g
Message-ID: <20040114223348.GC983@stop.crashing.org>
References: <20040108003040.GA18481@stop.crashing.org> <20040114210937.GA983@stop.crashing.org> <16389.49505.481834.12558@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16389.49505.481834.12558@napali.hpl.hp.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 02:23:29PM -0800, David Mosberger wrote:
> >>>>> On Wed, 14 Jan 2004 14:09:37 -0700, Tom Rini <trini@kernel.crashing.org> said:
> 
>   Tom> The following patch fixes the problem for me on PPC32:
> 
>   Tom> --- 1.96/kernel/module.c	Wed Jan  7 22:46:59 2004
>   Tom> +++ edited/kernel/module.c	Wed Jan 14 14:05:12 2004
>   Tom> @@ -1439,6 +1439,13 @@
>   Tom> strindex = sechdrs[i].sh_link;
>   Tom> strtab = (char *)hdr + sechdrs[strindex].sh_offset;
>   Tom> }
>   Tom> +
>   Tom> +		/* If we find any debug RELAs, frob these away now. */
>   Tom> +		if (sechdrs[i].sh_type == SHT_RELA &&
>   Tom> +				(strstr(secstrings+sechdrs[i].sh_name, ".debug")
>   Tom> +				 != 0))
>   Tom> +			sechdrs[i].sh_type = SHT_NULL;
>   Tom> +
>   Tom> #ifndef CONFIG_MODULE_UNLOAD
>   Tom> /* Don't load .exit sections */
>   Tom> if (strncmp(secstrings+sechdrs[i].sh_name, ".exit", 5) == 0)
> 
>   Tom> IMHO, this shouldn't be covered under a PPC32 test since at
>   Tom> least PPC32, PPC64 and Alpha have this issue, and I suspect
>   Tom> that ia64, parisc, s390 and v850 have the problem as well
>   Tom> (based on what their module_arch_frob bits look to be doing).
> 
> As far as ia64 is concerned, adding a check for .debug should be OK,
> but since the debug sections do not have any relocs anyhow, it
> shouldn't make much of a difference one way or another (addresses in
> the debug section a segment-relative).

OK, I wasn't sure.  I just did a real quick skim of everyones module.c
to see if they did any for loops and checking of SHT_RELA.

-- 
Tom Rini
http://gate.crashing.org/~trini/
