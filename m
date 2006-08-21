Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWHUTQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWHUTQI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 15:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWHUTQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 15:16:08 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:28555
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750815AbWHUTQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 15:16:07 -0400
Date: Mon, 21 Aug 2006 12:16:21 -0700 (PDT)
Message-Id: <20060821.121621.18301975.davem@davemloft.net>
To: DJurzitza@harmanbecker.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Two "bugletts" on SPARC 64 @ kernel 2.4
From: David Miller <davem@davemloft.net>
In-Reply-To: <DA6197CAE190A847B662079EF7631C060156928D@OEKAW2EXVS03.hbi.ad.harman.com>
References: <DA6197CAE190A847B662079EF7631C060156928D@OEKAW2EXVS03.hbi.ad.harman.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Mon, 21 Aug 2006 13:37:51 +0200

> --- linux/include/linux/module.h	2004-12-15 08:34:44.000000000 +0100
> +++ linux/include/linux/module.h	2004-12-15 08:45:32.000000000 +0100
> @@ -31,7 +31,11 @@
>  /* Used by get_kernel_syms, which is obsolete.  */
>  struct kernel_sym
>  {
> -	unsigned long value;
> +#ifdef __ARCH_SPARC64_ATOMIC__
> +	  unsigned int value;
> +#else
> +          unsigned long value;
> +#endif
>  	char name[60];		/* should have been 64-sizeof(long); oh well */
>  };

1) You should post sparc patches at least CC:'d to sparclinux@vger.kernel.org
   which is where the Sparc developers hang out.

2) I can't see any reason why this part of your patch can be valid.
   This structure is exported to userspace and therefor is part of
   the user-visible API and thus cannot be changed.

If there is some bug or bogus limitation in the module tools which
limits the number of symbols visible due to the sizing of this
structure, that is what needs to be changed not this structure.
