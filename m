Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319788AbSIMVFb>; Fri, 13 Sep 2002 17:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319789AbSIMVFb>; Fri, 13 Sep 2002 17:05:31 -0400
Received: from 2-028.ctame701-1.telepar.net.br ([200.193.160.28]:1172 "EHLO
	2-028.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S319788AbSIMVF1>; Fri, 13 Sep 2002 17:05:27 -0400
Date: Fri, 13 Sep 2002 18:09:55 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Good way to free as much memory as possible under 2.5.34?
In-Reply-To: <20020913210042.GA25464@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44L.0209131808240.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Sep 2002, Pavel Machek wrote:

> /*
>  * Try to free as much memory as possible, but do not OOM-kill anyone
>  *
>  * Notice: all userland should be stopped at this point, or livelock
> is possible.
>  */
>
> This worked before -rmap came in, but it does not free anything
> now. What needs to be done to fix it?

Actually, it still worked when -rmap came in, but it stopped working
when the LRU lists were made to be per-zone...

> static void free_some_memory(void)
> {
>         printk("Freeing memory: ");
>         while
> (try_to_free_pages(&contig_page_data.node_zones[ZONE_HIGHMEM], GFP_KSWAPD, 0))
>                 printk(".");
>         printk("|\n");
> }

Why don't you just allocate memory ?

To prevent the OOM kill you can just check for a variable
in the OOM slow path.  No need to rely on any particular
behaviour of the VM.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

