Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbWGBSTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWGBSTa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 14:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbWGBSTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 14:19:30 -0400
Received: from xenotime.net ([66.160.160.81]:10981 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964865AbWGBST3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 14:19:29 -0400
Date: Sun, 2 Jul 2006 11:22:15 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: akpm@osdl.org, hpa@zytor.com, erik_frederiksen@pmc-sierra.com,
       linux-kernel@vger.kernel.org
Subject: Re: IS_ERR Threshold Value
Message-Id: <20060702112215.152a593e.rdunlap@xenotime.net>
In-Reply-To: <20060702161520.GA15791@linux-mips.org>
References: <44A6F5E3.8000300@zytor.com>
	<20060702161520.GA15791@linux-mips.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jul 2006 17:15:20 +0100 Ralf Baechle wrote:

> So MAX_ERRNO of EMAXERRNO which was also being used in assembler code.
> Other architectures may have the same issue, so I propose wrapping the
> C parts with #ifndef __ASSEMBLY__ to keep as happy.

Ack, fixes 'as' whinging for me.


> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> diff --git a/include/linux/err.h b/include/linux/err.h
> index cd3b367..1ab1d44 100644
> --- a/include/linux/err.h
> +++ b/include/linux/err.h
> @@ -15,6 +15,8 @@ #include <asm/errno.h>
>   */
>  #define MAX_ERRNO	4095
>  
> +#ifndef __ASSEMBLY__
> +
>  #define IS_ERR_VALUE(x) unlikely((x) >= (unsigned long)-MAX_ERRNO)
>  
>  static inline void *ERR_PTR(long error)
> @@ -32,4 +34,6 @@ static inline long IS_ERR(const void *pt
>  	return IS_ERR_VALUE((unsigned long)ptr);
>  }
>  
> +#endif
> +
>  #endif /* _LINUX_ERR_H */
> -


---
~Randy
