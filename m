Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265230AbTBQCSl>; Sun, 16 Feb 2003 21:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265457AbTBQCSl>; Sun, 16 Feb 2003 21:18:41 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:52099 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S265230AbTBQCSi>; Sun, 16 Feb 2003 21:18:38 -0500
Message-ID: <3E50491C.2030901@didntduck.org>
Date: Sun, 16 Feb 2003 21:29:48 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Move __this_module to xxx.mod.c
References: <Pine.LNX.4.44.0302161946220.5217-100000@chaos.physics.uiowa.edu>
In-Reply-To: <Pine.LNX.4.44.0302161946220.5217-100000@chaos.physics.uiowa.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski wrote:

> On Sun, 16 Feb 2003, Brian Gerst wrote:
>
>
> >This patch moves the module structure to the generated .mod.c file,
> >instead of compiling it into each object and relying on the linker to
> >include it only once.
>
>
> Yeah, it's something I though about doing, but I was not sure. I think
> it's up to Rusty to comment ;)
>
> It will need an associated change to module_init_tools.
>
> Another comment:
>
> diff -urN linux-2.5.61-bk1/scripts/modpost.c linux/scripts/modpost.c
> --- linux-2.5.61-bk1/scripts/modpost.c	2003-02-16 10:06:35.000000000 -0500
> +++ linux/scripts/modpost.c	2003-02-16 14:10:19.000000000 -0500
> @@ -287,6 +287,10 @@
>  		/* undefined symbol */
>  		if (ELF_ST_BIND(sym->st_info) != STB_GLOBAL)
>  			break;
> +
> +		/* ignore __this_module */
> +		if (!strcmp(symname, "__this_module"))
> +			break;
>  		
>  		s = alloc_symbol(symname);
>  		/* add to list */
>
> Is that necessary? __this_module shouldn't be unresolved, so this case
> should never be hit AFAICS.

After the definition is removed from module.h, it is unresolved before 
it is linked to xxx.mod.c.

--
				Brian Gerst

