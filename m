Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265902AbTGIJ5P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 05:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265904AbTGIJ5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 05:57:15 -0400
Received: from air-2.osdl.org ([65.172.181.6]:33492 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265902AbTGIJ5F (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 05:57:05 -0400
Date: Wed, 9 Jul 2003 03:12:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Linux-Kernel@vger.kernel.org
Subject: Re: [PATCH] 1/5 VM changes: zone-pressure.patch
Message-Id: <20030709031203.3971d9b4.akpm@osdl.org>
In-Reply-To: <16139.54887.932511.717315@laputa.namesys.com>
References: <16139.54887.932511.717315@laputa.namesys.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov <Nikita@Namesys.COM> wrote:
>
> Add zone->pressure field. It estimates scanning intensity for this zone and
>  is calculated as exponentially decaying average of the scanning priority
>  required to free enough pages in this zone (mm/vmscan.c:zone_adj_pressure()).
> 
>  zone->pressure is supposed to be used in stead of scanning priority by
>  vmscan.c. This is used by later patches in a series.
> 

OK, fixes a bug.

> 
>  diff -puN include/linux/mmzone.h~zone-pressure include/linux/mmzone.h
>  --- i386/include/linux/mmzone.h~zone-pressure	Wed Jul  9 12:24:50 2003
>  +++ i386-god/include/linux/mmzone.h	Wed Jul  9 12:24:50 2003
>  @@ -84,11 +84,23 @@ struct zone {
>   	atomic_t		refill_counter;
>   	unsigned long		nr_active;
>   	unsigned long		nr_inactive;
>  -	int			all_unreclaimable; /* All pages pinned */
>  +	int			all_unreclaimable:1; /* All pages pinned */

I'll revert this change.  Once we start adding bitfields in there they all
need common locking and it gets messy.  integers are simpler.

