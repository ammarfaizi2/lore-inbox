Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751515AbWCXOxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbWCXOxE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 09:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751682AbWCXOxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 09:53:03 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:47263 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751515AbWCXOxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 09:53:01 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] swswsup: return correct load_image error
Date: Fri, 24 Mar 2006 15:51:35 +0100
User-Agent: KMail/1.9.1
Cc: linux list <linux-kernel@vger.kernel.org>, ck list <ck@vds.kolivas.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       linux-mm@kvack.org
References: <200603200234.01472.kernel@kolivas.org> <200603210022.32985.rjw@sisk.pl> <200603241600.56144.kernel@kolivas.org>
In-Reply-To: <200603241600.56144.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603241551.36349.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 March 2006 06:00, Con Kolivas wrote:
> On Tuesday 21 March 2006 10:22, Rafael J. Wysocki wrote:
> > Basically, yes.  swsusp.c and snapshot.c contain common functions,
> > disk.c and swap.c contain the code used by the built-in swsusp only,
> > and user.c contains the userland interface.  If you want something to
> > be run by the built-in swsusp only, place it in disk.c.
> 
> Ok. A quick look at the code in swap.c makes me wonder if we need this patch.
> 
> Rafael?

Yes, we do.  Thanks.

Andrew, could you please pick it up?

Rafael


> ---
> If there's an error in load_image() we should return that without checking
> snapshot_image_loaded.
> 
> Signed-off-by: Con Kolivas <kernel@kolivas.org>
> 
> ---
>  kernel/power/swap.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> Index: linux-2.6.16-mm1/kernel/power/swap.c
> ===================================================================
> --- linux-2.6.16-mm1.orig/kernel/power/swap.c	2006-03-24 15:04:13.000000000 +1100
> +++ linux-2.6.16-mm1/kernel/power/swap.c	2006-03-24 15:55:30.000000000 +1100
> @@ -454,10 +454,11 @@ static int load_image(struct swap_map_ha
>  			nr_pages++;
>  		}
>  	} while (ret > 0);
> -	if (!error)
> +	if (!error) {
>  		printk("\b\b\b\bdone\n");
> -	if (!snapshot_image_loaded(snapshot))
> -		error = -ENODATA;
> +		if (!snapshot_image_loaded(snapshot))
> +			error = -ENODATA;
> +	}
>  	return error;
>  }
>  
> 
> 
