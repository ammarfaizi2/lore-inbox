Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292419AbSBPQZ4>; Sat, 16 Feb 2002 11:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292415AbSBPQZr>; Sat, 16 Feb 2002 11:25:47 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:59438 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S292414AbSBPQZ2>; Sat, 16 Feb 2002 11:25:28 -0500
Date: Sat, 16 Feb 2002 17:20:48 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: anton@samba.org, mingo@elte.hu, torvalds@transmeta.com,
        riel@conectiva.com.br, velco@fadata.bg, stoffel@casc.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
Message-ID: <20020216172047.A32037@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0201312227350.18203-100000@localhost.localdomain> <20020131231242.GA4138@krispykreme> <20020201005543.K3396@athlon.random> <20020131.160159.41632715.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020131.160159.41632715.davem@redhat.com>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 04:01:59PM -0800, David S. Miller wrote:
> --- vanilla/linux/arch/i386/mm/init.c	Sun Nov 18 19:59:22 2001
> +++ linux/arch/i386/mm/init.c	Mon Nov 12 00:14:00 2001
> @@ -466,6 +466,8 @@
>  #endif
>  	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
>  
> +	page_cache_init(count_free_bootmem());
> +
>  	/* clear the zero-page */

I wanted to merge it, but pagecache will be in highmem as well, and the
above only takes into account the normal classzone (so it can be off by
63G).

Also I'd prefer page_cache_init() to be recalled within
free_all_bootmem/free_all_bootmem_node, so we don't need to change all
archs. to take highmem into account we can use the globals
highstart_pfn/highend_pfn within an #ifdef CONFIG_HIGHMEM.

Are you interested in fixing it? Otherwise let me know. Thanks!

Andrea
