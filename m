Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030429AbWGUBex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030429AbWGUBex (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 21:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030431AbWGUBex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 21:34:53 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:60603 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030429AbWGUBew (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 21:34:52 -0400
Message-ID: <44C02F35.4000604@garzik.org>
Date: Thu, 20 Jul 2006 21:34:45 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: ricknu-0@student.ltu.se
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [RFC][PATCH] A generic boolean (version 2)
References: <1153341500.44be983ca1407@portal.student.luth.se> <1153445087.44c02cdf40511@portal.student.luth.se>
In-Reply-To: <1153445087.44c02cdf40511@portal.student.luth.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ricknu-0@student.ltu.se wrote:
> diff --git a/include/asm-i386/types.h b/include/asm-i386/types.h
> index 4b4b295..841792b 100644
> --- a/include/asm-i386/types.h
> +++ b/include/asm-i386/types.h
> @@ -1,6 +1,13 @@
>  #ifndef _I386_TYPES_H
>  #define _I386_TYPES_H
>  
> +#if defined(__GNUC__)
> +typedef _Bool bool;
> +#else
> +#warning You compiler doesn't seem to support boolean types, will set 'bool' as
> an 'unsigned int'
> +typedef unsigned int bool;
> +#endif
> +
>  #ifndef __ASSEMBLY__
>  
>  typedef unsigned short umode_t;

Just delete the #ifdef and assume its either gcc, or a compatible 
compiler.  That's what we assume with other data types.


> @@ -10,6 +17,8 @@ typedef unsigned short umode_t;
>   * header files exported to user space
>   */
>  
> +typedef bool __u1;
> +
>  typedef __signed__ char __s8;
>  typedef unsigned char __u8;
>  
> @@ -36,6 +45,8 @@ #define BITS_PER_LONG 32
>  #ifndef __ASSEMBLY__
>  
>  
> +typedef bool u1;
> +
>  typedef signed char s8;
>  typedef unsigned char u8;
>  

I wouldn't bother with these types.  Nobody uses creates in their own 
hand-crafted bool uses, so I don't think people would suddenly start.


> diff --git a/include/linux/stddef.h b/include/linux/stddef.h
> index b3a2cad..498813b 100644
> --- a/include/linux/stddef.h
> +++ b/include/linux/stddef.h
> @@ -10,6 +10,9 @@ #else
>  #define NULL ((void *)0)
>  #endif
>  
> +#define false	((0))
> +#define true	((1))

I would say:

#undef true
#undef false
enum {
	false	= 0,
	true	= 1
};

#define false false
#define true true

