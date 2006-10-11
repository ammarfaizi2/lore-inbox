Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWJKM6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWJKM6O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 08:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWJKM6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 08:58:14 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:45013 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751244AbWJKM6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 08:58:14 -0400
Subject: Re: [PATCH] drivers/mmc/mmc.c: Replacing yield() with a better
	alternative
From: Arjan van de Ven <arjan@infradead.org>
To: Amol Lad <amol@verismonetworks.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>,
       kernel Janitors <kernel-janitors@lists.osdl.org>
In-Reply-To: <1160570743.19143.307.camel@amol.verismonetworks.com>
References: <1160570743.19143.307.camel@amol.verismonetworks.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 11 Oct 2006 14:58:11 +0200
Message-Id: <1160571491.3000.372.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-11 at 18:15 +0530, Amol Lad wrote:
> In 2.6, the semantics of calling yield() changed from "sleep for a
> bit" to "I really don't want to run for a while".  This matches POSIX
> better, but there's a lot of drivers still using yield() when they mean
> cond_resched(), schedule() or even schedule_timeout().
> 
> For this driver cond_resched() seems to be a better
> alternative
> 

are you sure?

> Tested compile only
> 
> Signed-off-by: Amol Lad <amol@verismonetworks.com>
> ---
> diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/drivers/mmc/mmc.c linux-2.6.19-rc1/drivers/mmc/mmc.c
> --- linux-2.6.19-rc1-orig/drivers/mmc/mmc.c	2006-10-05 14:00:46.000000000 +0530
> +++ linux-2.6.19-rc1/drivers/mmc/mmc.c	2006-10-11 17:57:02.000000000 +0530
> @@ -454,7 +454,7 @@ static void mmc_deselect_cards(struct mm
>  static inline void mmc_delay(unsigned int ms)
>  {
>  	if (ms < HZ / 1000) {
> -		yield();
> +		cond_resched();
>  		mdelay(ms);


this probably wants msleep(), especially with hrtimers comming up; there
the sleeps are always exact...


