Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030461AbWHXTI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030461AbWHXTI3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 15:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030462AbWHXTI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 15:08:29 -0400
Received: from terminus.zytor.com ([192.83.249.54]:51644 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030461AbWHXTI3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 15:08:29 -0400
Message-ID: <44EDF923.4030607@zytor.com>
Date: Thu, 24 Aug 2006 12:08:19 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Brukhov <pingved@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] boot: small change of halt method
References: <20060824184447.GA3346@windows95>
In-Reply-To: <20060824184447.GA3346@windows95>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Brukhov wrote:
> I'm new here.
> After reading boot code i'm immidiatly change this string:
> 
> --- ./linux-2.6.17.11/arch/i386/boot/compressed/misc.c	2006-08-24 01:16:33.000000000 +0400
> +++ /usr/src/linux-2.6.17.11/arch/i386/boot/compressed/misc.c	2006-08-24 22:36:10.000000000 +0400
> @@ -7,6 +7,7 @@
>   * malloc by Hannu Savolainen 1993 and Matthias Urlichs 1994
>   * puts by Nick Holloway 1993, better puts by Martin Mares 1995
>   * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
> + * Small fix of halt method Andrew Brukhov, Aug. 2006               
>   */
>  
>  #include <linux/linkage.h>
> @@ -289,8 +290,7 @@ static void error(char *x)
>  	putstr("\n\n");
>  	putstr(x);
>  	putstr("\n\n -- System halted");
> -
> -	while(1);	/* Halt */
> +      	asm( "hlt" );
>  }
> 
> It's becouse this code is platform depended and therefore there is no resons to write infinity cycle.
> 

Wrong.

You need to:

	while (1)
		asm volatile("hlt");

... since HLT only pauses until interrupt.

	-hpa
