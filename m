Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266584AbSLJVOY>; Tue, 10 Dec 2002 16:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266712AbSLJVOY>; Tue, 10 Dec 2002 16:14:24 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:51974 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S266584AbSLJVOX>; Tue, 10 Dec 2002 16:14:23 -0500
Date: Tue, 10 Dec 2002 19:21:49 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make net/ipv4/route.c compile without CONFIG_PROC_FS
Message-ID: <20021210212149.GN26067@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Arnd Bergmann <arnd@bergmann-dalldorf.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <200212102208.31562.arnd@bergmann-dalldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212102208.31562.arnd@bergmann-dalldorf.de>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 10, 2002 at 10:08:31PM +0100, Arnd Bergmann escreveu:
> The recent cleanup of /proc/net/rt_cache broke compiling
> without procfs, this makes it work again.
> 
> ===== net/ipv4/route.c 1.31 vs edited =====
> --- 1.31/net/ipv4/route.c       Sun Dec  8 03:45:58 2002
> +++ edited/net/ipv4/route.c     Tue Dec 10 22:01:36 2002
> @@ -402,6 +402,11 @@
>  {
>         remove_proc_entry("rt_cache", proc_net);
>  }
> +#else
> +
> +#define rt_cache_stat_get_info (get_info_t*)0
> +static inline int rt_cache_proc_init(void) { return 0; }
> +
>  #endif /* CONFIG_PROC_FS */
> 
>  static __inline__ void rt_free(struct rtable *rt)

uups, sorry, but this will not be needed after I convert the rest
of net/ipv4/route.c to seq_file.

- Arnaldo
