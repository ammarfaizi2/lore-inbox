Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965041AbVIUWxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbVIUWxd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 18:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965106AbVIUWxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 18:53:32 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:37813 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S965041AbVIUWxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 18:53:32 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [swsusp] Rework image freeing
Date: Thu, 22 Sep 2005 00:53:44 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
References: <20050921205132.GA4249@elf.ucw.cz>
In-Reply-To: <20050921205132.GA4249@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509220053.45358.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 21 of September 2005 22:51, Pavel Machek wrote:
> Do not store pagedirs in swap twice. This needed rewrite of image
> freeing, but it enabled me nice cleanups in the end.
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>
> 
> ---
> commit 67434821951d6f10d55e29465a24e7f5015038f1
> tree ee0f4a209e8b680ffdfa6e7837a3a248b524f421
> parent 7bdc8fc378f053bd4eb4210beb1d494485318512
> author <pavel@amd.(none)> Tue, 20 Sep 2005 15:34:55 +0200
> committer <pavel@amd.(none)> Tue, 20 Sep 2005 15:34:55 +0200
> 
>  kernel/power/swsusp.c |  103 ++++++++++++++++++++++---------------------------
>  1 files changed, 46 insertions(+), 57 deletions(-)
> 
> diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
> --- a/kernel/power/swsusp.c
> +++ b/kernel/power/swsusp.c
> @@ -729,16 +729,6 @@ static void copy_data_pages(void)
>  	BUG_ON(pbe);
>  }
>  
> -
> -/**
> - *	calc_nr - Determine the number of pages needed for a pbe list.
> - */
> -
> -static int calc_nr(int nr_copy)
> -{
> -	return nr_copy + (nr_copy+PBES_PER_PAGE-2)/(PBES_PER_PAGE-1);
> -}

I can't see why you are going to drop this function.  Isn't it necessary any more?

Greetings,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
