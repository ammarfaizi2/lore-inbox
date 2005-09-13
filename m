Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbVIMRAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbVIMRAH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 13:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbVIMRAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 13:00:06 -0400
Received: from phoenix.infradead.org ([81.187.2.162]:51462 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S964888AbVIMRAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 13:00:01 -0400
Date: Tue, 13 Sep 2005 17:59:54 +0100
From: Joern Engel <joern@infradead.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Permanently fix kernel configuration include mess (was: Missing #include <config.h>)
Message-ID: <20050913165954.GA31461@phoenix.infradead.org>
References: <20050913135622.GA30675@phoenix.infradead.org> <20050913150825.A23643@flint.arm.linux.org.uk> <20050913155012.C23643@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050913155012.C23643@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 September 2005 15:50:12 +0100, Russell King wrote:
> 
> Subject: [KBUILD] Permanently fix kernel configuration include mess.
> 
> Include autoconf.h into every kernel compilation via the gcc
> command line using -imacros.  This ensures that we have the
> kernel configuration included from the start, rather than
> relying on each file having #include <linux/config.h> as
> appropriate.  History has shown that this is something which
> is difficult to get right.
> 
> Since we now include the kernel configuration automatically,
> make configcheck becomes meaningless, so remove it.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

If it helps:
Signed-off-by: Joern Engel <joern@wh.fh-wedel.de>

> diff --git a/Makefile b/Makefile
> --- a/Makefile
> +++ b/Makefile
> @@ -346,7 +346,8 @@ AFLAGS_KERNEL	=
>  # Use LINUXINCLUDE when you must reference the include/ directory.
>  # Needed to be compatible with the O= option
>  LINUXINCLUDE    := -Iinclude \
> -                   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include)
> +                   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include) \
> +		   -imacros include/linux/autoconf.h
>  
>  CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
>  
> @@ -1247,11 +1248,6 @@ tags: FORCE
>  # Scripts to check various things for consistency
>  # ---------------------------------------------------------------------------
>  
> -configcheck:
> -	find * $(RCS_FIND_IGNORE) \
> -		-name '*.[hcS]' -type f -print | sort \
> -		| xargs $(PERL) -w scripts/checkconfig.pl
> -
>  includecheck:
>  	find * $(RCS_FIND_IGNORE) \
>  		-name '*.[hcS]' -type f -print | sort \

Jörn

-- 
Schrödinger's cat is <BLINK>not</BLINK> dead.
-- Illiad
