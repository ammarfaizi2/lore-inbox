Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264433AbUAOBjY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 20:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264292AbUAOBhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 20:37:35 -0500
Received: from dp.samba.org ([66.70.73.150]:19847 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264538AbUAOBh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 20:37:26 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] 2.6 && module + -g && kernel w/o -g 
In-reply-to: Your message of "Wed, 14 Jan 2004 14:09:37 PDT."
             <20040114210937.GA983@stop.crashing.org> 
Date: Thu, 15 Jan 2004 10:00:11 +1100
Message-Id: <20040115013723.29B912C0DC@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040114210937.GA983@stop.crashing.org> you write:
> Okay.  I've been looking at stock 2.6.1 noticed  that the fix for this
> issue that Rusty proposed, and that ultimately made it into 2.6.1-rc3
> (or so) is not correct.  The problem is that we do:
> 
> err = module_frob_arch_sections(hdr, sechdrs, secstrings, mod);
> /* Which goes over every .debug section and can take _ages_ on something
>  * like ipv6 */

Right.  So the arch-specific module_frob_arch_sections() can be slow.
Logically, the fix should be in those module_frob_arch_sections(), not
in the generic code.

> +		/* If we find any debug RELAs, frob these away now. */
> +		if (sechdrs[i].sh_type == SHT_RELA &&
> +				(strstr(secstrings+sechdrs[i].sh_name, ".debug")
> +				 != 0))
> +			sechdrs[i].sh_type = SHT_NULL;
> +

Doesn't cover SHT_REL, and I really dislike name matches: they've bitten
us before.

Really, I prefer the arch-specific optimization.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
