Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVF1WD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVF1WD7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 18:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVF1WBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 18:01:24 -0400
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:30216 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261523AbVF1V5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 17:57:43 -0400
Date: Tue, 28 Jun 2005 23:57:59 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, akpm@osdl.org,
       tytso@mit.edu, zwane@arm.linux.org.uk, jmforbes@linuxtx.org,
       rdunlap@xenotime.net, torvalds@osdl.org, chuckw@quantumlinux.com,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [05/07] Add "memory" clobbers to the x86 inline asm of strncmp
 and friends
Message-Id: <20050628235759.19866f7b.khali@linux-fr.org>
In-Reply-To: <20050627230144.GN9046@shell0.pdx.osdl.net>
References: <20050627224651.GI9046@shell0.pdx.osdl.net>
	<20050627230144.GN9046@shell0.pdx.osdl.net>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

> @@ -138,8 +139,9 @@ __asm__ __volatile__(
>  	"3:\tsbbl %%eax,%%eax\n\t"
>  	"orb $1,%%al\n"
>  	"4:"
> -		     :"=a" (__res), "=&S" (d0), "=&D" (d1), "=&c" (d2)
> -		     :"1" (cs),"2" (ct),"3" (count));
> +	:"=a" (__res), "=&S" (d0), "=&D" (d1), "=&c" (d2)
> +	:"1" (cs),"2" (ct),"3" (count)
> +	:"memory");
>  return __res;
>  }

Could be made shorter. As far as I remember, indentation fixes are not
-stable material.

> @@ -369,7 +379,7 @@ __asm__ __volatile__(
>  	"je 2f\n\t"
>  	"stosb\n"
>  	"2:"
> -	: "=&c" (d0), "=&D" (d1)
> +	:"=&c" (d0), "=&D" (d1)
>  	:"a" (c), "q" (count), "0" (count/4), "1" ((long) s)
>  	:"memory");
>  return (s);	

Doesn't belong there, unless -stable rules have changed.

Thanks,
-- 
Jean Delvare
