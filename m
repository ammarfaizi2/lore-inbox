Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262673AbVBDBi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbVBDBi4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 20:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262966AbVBDB2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 20:28:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:64913 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263299AbVBDBLe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 20:11:34 -0500
Date: Thu, 3 Feb 2005 17:16:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: terje_fb@yahoo.no, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: 2.6.10: kswapd spins like crazy
Message-Id: <20050203171638.668f2892.akpm@osdl.org>
In-Reply-To: <4202C839.8000103@yahoo.com.au>
References: <20050203195033.29314.qmail@web51608.mail.yahoo.com>
	<4202BE05.9090901@yahoo.com.au>
	<4202C839.8000103@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Oh, attached should be a minimal fix if you would like to try it out.
> 
> 
> ...
> --- linux-2.6/mm/vmscan.c~vmscan-minfix	2005-02-04 11:52:37.000000000 +1100
> +++ linux-2.6-npiggin/mm/vmscan.c	2005-02-04 11:53:32.000000000 +1100
> @@ -575,6 +575,7 @@ static void shrink_cache(struct zone *zo
>  			nr_taken++;
>  		}
>  		zone->nr_inactive -= nr_taken;
> +		zone->pages_scanned += nr_scan;
>  		spin_unlock_irq(&zone->lru_lock);
>  
>  		if (nr_taken == 0)
> 

Any theories as to why these pages aren't being activated and aren't being
reclaimed?

