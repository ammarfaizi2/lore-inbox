Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129044AbQKMQhb>; Mon, 13 Nov 2000 11:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129211AbQKMQhV>; Mon, 13 Nov 2000 11:37:21 -0500
Received: from office.mandrakesoft.com ([195.68.114.34]:49656 "EHLO
	toy.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129044AbQKMQhO>; Mon, 13 Nov 2000 11:37:14 -0500
Date: Mon, 13 Nov 2000 17:44:45 +0100 (CET)
From: Francis Galiegue <fg@mandrakesoft.com>
To: Torsten.Duwe@caldera.de
cc: linux-kernel@vger.kernel.org
Subject: Re: Modprobe local root exploit
In-Reply-To: <14864.5656.706778.275865@ns.caldera.de>
Message-ID: <Pine.LNX.4.21.0011131744100.594-100000@toy.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2000, Torsten Duwe wrote:

> 
> --- linux/kernel/kmod.c.orig	Tue Sep 26 01:18:55 2000
> +++ linux/kernel/kmod.c	Mon Nov 13 16:57:02 2000
> @@ -168,6 +168,22 @@
>  	static atomic_t kmod_concurrent = ATOMIC_INIT(0);
>  #define MAX_KMOD_CONCURRENT 50	/* Completely arbitrary value - KAO */
>  	static int kmod_loop_msg;
> +	const char * p;
> +
> +	/* For security reasons ensure the requested name consists
> +	 * only of allowed characters. Especially whitespace and
> +	 * shell metacharacters might confuse modprobe.
> +	 */
> +	for (p = module_name; *p; p++)
> +	{
> +	  if ((*p & 0xdf) >= 'a' && (*p & 0xdf) <= 'z')
> +	    continue;
> +	  if (*p >= '0' && *p <= '9')
> +	    continue;
> +	  if (*p == '_' || *p == '-')
> +	    continue;
> +	  return -EINVAL;
> +	}
>  

Just in case... Some modules have uppercase letters too :)

-- 
Francis Galiegue, fg@mandrakesoft.com
"Programming is a race between programmers, who try and make more and more
idiot-proof software, and universe, which produces more and more remarkable
idiots. Until now, universe leads the race"  -- R. Cook

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
