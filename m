Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268261AbUHXUC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268261AbUHXUC0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 16:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268262AbUHXUC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 16:02:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:4022 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268261AbUHXUCU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 16:02:20 -0400
Date: Tue, 24 Aug 2004 13:00:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: nickpiggin@yahoo.com.au, us15@os.inf.tu-dresden.de, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Message-Id: <20040824130027.77b7b0f9.akpm@osdl.org>
In-Reply-To: <20040824182036.GB8806@logos.cnet>
References: <Pine.LNX.4.58.0408102201510.1839@ppc970.osdl.org>
	<Pine.LNX.4.58.0408102213250.1839@ppc970.osdl.org>
	<20040812180033.62b389db@laptop.delusion.de>
	<Pine.LNX.4.58.0408121813190.1839@ppc970.osdl.org>
	<20040820000238.55e22081@laptop.delusion.de>
	<20040820001154.0a5cf331.akpm@osdl.org>
	<20040820001905.27a9ff8f@laptop.delusion.de>
	<4125AD23.4000705@yahoo.com.au>
	<20040823230824.3c937d88@laptop.delusion.de>
	<412AF113.6000804@yahoo.com.au>
	<20040824182036.GB8806@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> I dont fully understand the all_unreclaimable logic yet.

1) bk revtool include/linux/mmzone.h
2) double-click on declaration of all_unreclaimable
3) read changelog ;)

> --- mm/vmscan.c.orig	2004-08-24 16:48:09.467086840 -0300
> +++ mm/vmscan.c	2004-08-24 16:51:55.304754296 -0300
> @@ -878,7 +878,8 @@
>  		if (zone->prev_priority > sc->priority)
>  			zone->prev_priority = sc->priority;
>  
> -		if (zone->all_unreclaimable && sc->priority != DEF_PRIORITY)
> +		if (zone->all_unreclaimable && 
> +				(sc->priority < DEF_PRIORITY && sc->priority > 0))
>  			continue;	/* Let kswapd poll it */
>  
>  		shrink_zone(zone, sc);
> @@ -1054,7 +1055,8 @@
>  		for (i = 0; i <= end_zone; i++) {
>  			struct zone *zone = pgdat->node_zones + i;
>  
> -			if (zone->all_unreclaimable && priority != DEF_PRIORITY)
> +			if (zone->all_unreclaimable && 
> +					(priority < DEF_PRIORITY && priority > 0))
>  				continue;
>  
>  			if (nr_pages == 0) {	/* Not software suspend */

Does anyone understand _why_ all_unreclaimable is getting set?

If not, it's too early to be writing patches...
