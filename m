Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264073AbTDOBli (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 21:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264081AbTDOBli (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 21:41:38 -0400
Received: from [12.47.58.203] ([12.47.58.203]:28711 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264073AbTDOBlh (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 21:41:37 -0400
Date: Mon, 14 Apr 2003 18:53:26 -0700
From: Andrew Morton <akpm@digeo.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: James Simmons <jsimmons@infradead.org>
Subject: Re: [FBCON] Could be called outside of a process context. This
 fixes that.
Message-Id: <20030414185326.1fdf2e01.akpm@digeo.com>
In-Reply-To: <200304141829.h3EITgZF028370@hera.kernel.org>
References: <200304141829.h3EITgZF028370@hera.kernel.org>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Apr 2003 01:53:22.0433 (UTC) FILETIME=[CBB22710:01C302F1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List <linux-kernel@vger.kernel.org> wrote:
>
> ChangeSet 1.981, 2003/03/25 10:21:46-08:00, jsimmons@maxwell.earthlink.net
> 
> 	[FBCON] Could be called outside of a process context. This fixes that.
> 
> 
> ...
> diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
> --- a/drivers/video/console/fbcon.c	Mon Apr 14 11:29:45 2003
> +++ b/drivers/video/console/fbcon.c	Mon Apr 14 11:29:45 2003
> @@ -985,8 +985,8 @@
>  
>  	size = ((width + 7) >> 3) * height;
>  
> -	data = kmalloc(size, GFP_KERNEL);
> -	mask = kmalloc(size, GFP_KERNEL);
> +	data = kmalloc(size, GFP_ATOMIC);
> +	mask = kmalloc(size, GFP_ATOMIC);
>  	
>  	if (cursor->set & FB_CUR_SETSIZE) {
>  		memset(data, 0xff, size);

GFP_ATOMIC memory allocations can and will return NULL when the system is
under load.  The driver _has_ to check for this, and cope with it.
