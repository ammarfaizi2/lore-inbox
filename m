Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266101AbUBQL0b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 06:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266114AbUBQL0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 06:26:31 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:12419 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S266101AbUBQL03
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 06:26:29 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Pavel Machek <pavel@ucw.cz>, "Amit S. Kale" <akale@users.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>
Subject: Re: hweight64
Date: Tue, 17 Feb 2004 16:55:43 +0530
User-Agent: KMail/1.5
References: <20040217103451.GA440@elf.ucw.cz>
In-Reply-To: <20040217103451.GA440@elf.ucw.cz>
Cc: Andi Kleen <ak@suse.de>, Jim Houston <jim.houston@ccur.com>,
       Tom Rini <trini@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402171655.44006.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel and kgdb gurus,

I inherited this change from x86_64 patch. Probably it was required on x86_64. 
I can't think of any reason why it is necessary.

Unless someone finds a problem with this patch, I am going to apply it.

-Amit

On Tuesday 17 Feb 2004 4:04 pm, Pavel Machek wrote:
> Hi!
>
> In kgdb patches you change prototype of hweight64. Why that change?
>
> [This patch is reverse]
>
> I do not see what it has to do with kgdb. Its true that result always
> fits into int, but I'd be afraid of small sideeffects somewhere...
>
> 								Pavel
>
>
> --- clean-mm/include/linux/bitops.h	2004-02-16 23:00:15.000000000 +0100
> +++ linux-mm/include/linux/bitops.h	2003-06-24 12:28:05.000000000 +0200
> @@ -108,7 +108,7 @@
>          return (res & 0x0F) + ((res >> 4) & 0x0F);
>  }
>
> -static inline unsigned int generic_hweight64(__u64 w)
> +static inline unsigned long generic_hweight64(__u64 w)
>  {
>  #if BITS_PER_LONG < 64
>  	return generic_hweight32((unsigned int)(w >> 32)) +
> @@ -120,8 +120,7 @@
>  	res = (res & 0x0F0F0F0F0F0F0F0F) + ((res >> 4) & 0x0F0F0F0F0F0F0F0F);
>  	res = (res & 0x00FF00FF00FF00FF) + ((res >> 8) & 0x00FF00FF00FF00FF);
>  	res = (res & 0x0000FFFF0000FFFF) + ((res >> 16) & 0x0000FFFF0000FFFF);
> -	res = (res & 0x00000000FFFFFFFF) + ((res >> 32) & 0x00000000FFFFFFFF);
> -	return (unsigned int)res;
> +	return (res & 0x00000000FFFFFFFF) + ((res >> 32) & 0x00000000FFFFFFFF);
>  #endif
>  }

