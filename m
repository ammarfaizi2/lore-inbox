Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287500AbRLaMu4>; Mon, 31 Dec 2001 07:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287501AbRLaMuq>; Mon, 31 Dec 2001 07:50:46 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:61710 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287500AbRLaMug>;
	Mon, 31 Dec 2001 07:50:36 -0500
Date: Mon, 31 Dec 2001 10:50:15 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [patch] Prefetching file_read_actor()
In-Reply-To: <20011231033220.A1686@suse.de>
Message-ID: <Pine.LNX.4.33L.0112311049550.24031-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Dec 2001, Dave Jones wrote:

> diff -urN --exclude-from=/home/davej/.exclude linux-2.5.2-pre5/mm/filemap.c linux-2.5/mm/filemap.c
> --- linux-2.5.2-pre5/mm/filemap.c	Sun Dec 16 23:21:24 2001
> +++ linux-2.5/mm/filemap.c	Mon Dec 31 03:22:51 2001
> @@ -1570,6 +1570,15 @@
>  		size = count;
>
>  	kaddr = kmap(page);
> +
> +	if (size > 128) {
> +		int i;
> +		for(i=0; i<size; i+=64) {
> +			prefetch (kaddr+offset);
> +			prefetch (kaddr+offset+(L1_CACHE_BYTES*2));

Neat piece of deep magic, please document it ;)

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

