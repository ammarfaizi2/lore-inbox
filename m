Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275898AbSIURZo>; Sat, 21 Sep 2002 13:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275903AbSIURZo>; Sat, 21 Sep 2002 13:25:44 -0400
Received: from mail.gmx.de ([213.165.64.20]:1455 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S275898AbSIURZn>;
	Sat, 21 Sep 2002 13:25:43 -0400
Date: Sat, 21 Sep 2002 20:30:33 +0300
From: Dan Aloni <da-x@gmx.net>
To: Nicolas Pitre <nico@cam.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix to strchr() in lib/string.c
Message-ID: <20020921173033.GB19943@callisto.yi.org>
References: <Pine.LNX.4.44.0209211209390.15918-100000@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209211209390.15918-100000@xanadu.home>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 21, 2002 at 12:25:59PM -0400, Nicolas Pitre wrote:
> 
> The return value of strchr("foo",0) should be the start address of
> "foo" + 3, not NULL.

Correct me if I'm wrong, but no fix is needed.

strchr("foo", 0) doesn't return NULL, for the simple fact that 
the loop will stop when reaching '\0' before the 'if' that returns
NULL, and then s will be returned.

If it wasn't like this, add_stats() (in net/atm/proc.c) 
would have Oopsed on us long ago.
 
> --- linux/lib/string.c	Thu Aug  1 17:16:34 2002
> +++ linux/lib/string.c	Sat Sep 21 12:21:54 2002
> @@ -190,10 +190,11 @@
>   */
>  char * strchr(const char * s, int c)
>  {
> -	for(; *s != (char) c; ++s)
> -		if (*s == '\0')
> -			return NULL;
> -	return (char *) s;
> +	do {
> +		if (*s == (char) c)
> +			return (char *) s;
> +	} while (*s++);
> +	return NULL;
>  }
>  #endif
>  
> 

-- 
Dan Aloni
da-x@gmx.net
