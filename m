Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266450AbUHWRuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266450AbUHWRuI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 13:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266306AbUHWRuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 13:50:08 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:11392 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266376AbUHWRq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 13:46:59 -0400
Date: Mon, 23 Aug 2004 19:42:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Erik Rigtorp <erik@rigtorp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make swsusp produce nicer screen output
Message-ID: <20040823174217.GC603@openzaurus.ucw.cz>
References: <20040820152317.GA7118@linux.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040820152317.GA7118@linux.nu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I made a small patch that makes swsusp produce a bit nicer screen output,
> it's still a little rough though.

Well, it looks nice, be sure to submit smooth version :-).

				Pavel

> @@ -85,10 +85,17 @@
>  
>  static void free_some_memory(void)
>  {
> -	printk("Freeing memory: ");
> -	while (shrink_all_memory(10000))
> -		printk(".");
> -	printk("|\n");
> +	int i = 0;
> +	char *p = "-\|/";
> +	
> +	printk("Freeing memory:  ");
> +	while (shrink_all_memory(10000)) {
> +		printk("\b%c", p[i]);
> +		i++;
> +		if (i > 3)
> +			i = 0;
> +	}
> +	printk("\bdone\n");
>  }

I'd leave dots here. Its usefull to see if it done something or not.

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

