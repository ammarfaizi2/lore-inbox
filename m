Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVGPITr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVGPITr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 04:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVGPITr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 04:19:47 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:54026 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261183AbVGPITr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 04:19:47 -0400
Date: Sat, 16 Jul 2005 09:52:16 +0000
From: Sam Ravnborg <sam@ravnborg.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] signed char fixes for scripts
Message-ID: <20050716095216.GB8064@mars.ravnborg.org>
References: <1121465068l.13352l.0l@werewolf.able.es> <1121465683l.13352l.5l@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121465683l.13352l.5l@werewolf.able.es>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2005 at 10:14:43PM +0000, J.A. Magallon wrote:
> 
> On 07.16, J.A. Magallon wrote:
> > 
> > On 07.15, Andrew Morton wrote:
> > > 
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm1/
> > > 
> 
> This time I did not break anything... and they shut up gcc4 ;)

Thanks.
Can you please resend with proper changelog and signed-off-by.
Diff should be done on top of latest -linus preferable.
Also this patch seems relative small compared to the others floating
around to cure signed warnings in scripts/
Does this really fix all of them or only a subset of the warnings?

I do not have gcc4 present but maybe thats easy - running gentoo?

> --- linux-2.6.12-jam7/scripts/kallsyms.c.orig	2005-07-06 00:16:39.000000000 +0200
> +++ linux-2.6.12-jam7/scripts/kallsyms.c	2005-07-06 00:42:24.000000000 +0200
> @@ -166,9 +166,9 @@
>  		 * move then they may get dropped in pass 2, which breaks the
>  		 * kallsyms rules.
>  		 */
> -		if ((s->addr == _etext && strcmp(s->sym + offset, "_etext")) ||
> -		    (s->addr == _einittext && strcmp(s->sym + offset, "_einittext")) ||
> -		    (s->addr == _eextratext && strcmp(s->sym + offset, "_eextratext")))
> +		if ((s->addr == _etext && strcmp((char*)s->sym + offset, "_etext")) ||
> +		    (s->addr == _einittext && strcmp((char*)s->sym + offset, "_einittext")) ||
> +		    (s->addr == _eextratext && strcmp((char*)s->sym + offset, "_eextratext")))
>  			return 0;
>  	}
Can we have a local variable so we do not have all the casts in the if
condition?

	Sam
