Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264942AbRHAISn>; Wed, 1 Aug 2001 04:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264797AbRHAISd>; Wed, 1 Aug 2001 04:18:33 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:34053 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S264447AbRHAIST>;
	Wed, 1 Aug 2001 04:18:19 -0400
From: Andrew Tridgell <tridge@valinux.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0108010232100.8866-100000@freak.distro.conectiva>
	(message from Marcelo Tosatti on Wed, 1 Aug 2001 03:10:58 -0300 (BRT))
Subject: Re: 2.4.8preX VM problems
Reply-To: tridge@valinux.com
In-Reply-To: <Pine.LNX.4.21.0108010232100.8866-100000@freak.distro.conectiva>
Message-Id: <20010801081344.8A6C04603@lists.samba.org>
Date: Wed,  1 Aug 2001 01:13:44 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Marcelo,

I'm afraid that didn't help. I get:

[root@skurk /root]# ./readfiles /dev/ddisk 
362 MB    181.145 MB/sec
695 MB    166.455 MB/sec
811 MB    57.6077 MB/sec
812 MB    0.439532 MB/sec
813 MB    0.463901 MB/sec
814 MB    0.416093 MB/sec
815 MB    0.409958 MB/sec
816 MB    0.410413 MB/sec




> Could you please try the patch below ? (against 2.4.8pre3)
> 
> --- linux.orig/mm/vmscan.c	Wed Aug  1 04:26:36 2001
> +++ linux/mm/vmscan.c	Wed Aug  1 04:33:22 2001
> @@ -593,13 +593,9 @@
>  			 * If we're freeing buffer cache pages, stop when
>  			 * we've got enough free memory.
>  			 */
> -			if (freed_page) {
> -				if (zone) {
> -					if (!zone_free_shortage(zone))
> -						break;
> -				} else if (!free_shortage()) 
> -					break;
> -			}
> +			if (freed_page && !total_free_shortage())
> +				break;
> +
>  			continue;
>  		} else if (page->mapping && !PageDirty(page)) {
>  			/*
> 
> 

