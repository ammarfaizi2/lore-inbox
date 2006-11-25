Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757841AbWKYGHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757841AbWKYGHf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 01:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757843AbWKYGHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 01:07:35 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:8855
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1757841AbWKYGHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 01:07:35 -0500
Date: Fri, 24 Nov 2006 22:07:46 -0800 (PST)
Message-Id: <20061124.220746.57445336.davem@davemloft.net>
To: rdreier@cisco.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, openib-general@openib.org,
       tom@opengridcomputing.com
Subject: Re: [PATCH] Avoid truncating to 'long' in ALIGN() macro
From: David Miller <davem@davemloft.net>
In-Reply-To: <adazmag5bk1.fsf@cisco.com>
References: <adazmag5bk1.fsf@cisco.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 24 Nov 2006 21:40:14 -0800

> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 24b6111..cc542d3 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -31,7 +31,7 @@ #define ULLONG_MAX	(~0ULL)
>  #define STACK_MAGIC	0xdeadbeef
>  
>  #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> -#define ALIGN(x,a) (((x)+(a)-1UL)&~((a)-1UL))
> +#define ALIGN(x,a) (((x)+(a)-1L)&~((a)-1L))

Perhaps a better way to fix this is to use
typeof() like other similar macros do.
