Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262289AbSKHTef>; Fri, 8 Nov 2002 14:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262298AbSKHTef>; Fri, 8 Nov 2002 14:34:35 -0500
Received: from chaos.analogic.com ([204.178.40.224]:14464 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262289AbSKHTee>; Fri, 8 Nov 2002 14:34:34 -0500
Date: Fri, 8 Nov 2002 14:41:36 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Douglas Gilbert <dougg@torque.net>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] Re: sscanf("-1", "%d", &i) fails, returns 0
In-Reply-To: <Pine.LNX.4.33L2.0211081118250.32726-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.3.95.1021108143738.1000A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Nov 2002, Randy.Dunlap wrote:

> On Sat, 9 Nov 2002, Douglas Gilbert wrote:
> 
> | In lk 2.5.46-bk3 the expression in the subject line
> | fails to write into "i" and returns 0. Drop the minus
> | sign and it works.
> 
> Here's an unobstrusive patch to correct that.
> Please apply.
> 
> -- 
> ~Randy
> 
> 
> 
> --- ./lib/vsprintf.c%signed	Mon Nov  4 14:30:49 2002
> +++ ./lib/vsprintf.c	Fri Nov  8 11:20:03 2002
> @@ -517,6 +517,7 @@
>  {
>  	const char *str = buf;
>  	char *next;
> +	char *dig;
>  	int num = 0;
>  	int qualifier;
>  	int base;
> @@ -638,12 +639,13 @@
>  		while (isspace(*str))
>  			str++;
> 
> -		if (!*str
> -                    || (base == 16 && !isxdigit(*str))
> -                    || (base == 10 && !isdigit(*str))
> -                    || (base == 8 && (!isdigit(*str) || *str > '7'))
> -                    || (base == 0 && !isdigit(*str)))
> -			break;
> +		dig = (*str == '-') ? (str + 1) : str;
> +		if (!*dig
> +                    || (base == 16 && !isxdigit(*dig))
> +                    || (base == 10 && !isdigit(*dig))
> +                    || (base == 8 && (!isdigit(*dig) || *dig > '7'))
> +                    || (base == 0 && !isdigit(*dig)))
> +				break;
> 
>  		switch(qualifier) {
>  		case 'h':
> 
> -

I was thinking that if anybody ever had to change any of this
stuff, it might be a good idea to do the indirection only once?
All those "splats" over and over again are costly.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


