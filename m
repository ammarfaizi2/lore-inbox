Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422705AbWF0WtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422705AbWF0WtG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422709AbWF0WtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:49:05 -0400
Received: from xenotime.net ([66.160.160.81]:4997 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1422707AbWF0Ws6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:48:58 -0400
Date: Tue, 27 Jun 2006 15:51:43 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: linux-kernel@vger.kernel.org, Henk.Vergonet@gmail.com
Subject: Re: [Patch] Off by one in drivers/usb/input/yealink.c
Message-Id: <20060627155143.b0e3e1dd.rdunlap@xenotime.net>
In-Reply-To: <1151448080.16217.3.camel@alice>
References: <1151448080.16217.3.camel@alice>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006 00:41:19 +0200 Eric Sesterhenn wrote:

> hi,
> 
> another off by one spotted by coverity (id #485),
> we loop exactly one time too often
> 
> Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
> 
> --- linux-2.6.17-git11/drivers/usb/input/yealink.c.orig	2006-06-28 00:29:46.000000000 +0200
> +++ linux-2.6.17-git11/drivers/usb/input/yealink.c	2006-06-28 00:30:04.000000000 +0200
> @@ -350,7 +350,7 @@ static int yealink_do_idle_tasks(struct 
>  		val = yld->master.b[ix];
>  		if (val != yld->copy.b[ix])
>  			goto send_update;
> -	} while (++ix < sizeof(yld->master));
> +	} while (++ix < sizeof(yld->master)-1);
>  
>  	/* nothing todo, wait a bit and poll for a KEYPRESS */
>  	yld->stat_ix = 0;

FWIW, on this one and the previous floppy.c patch,
I would rather see the comparison be <= instead of using -1.

---
~Randy
