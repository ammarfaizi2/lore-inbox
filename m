Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263420AbTJBQok (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 12:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263427AbTJBQoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 12:44:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:61337 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263424AbTJBQoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 12:44:20 -0400
Date: Thu, 2 Oct 2003 09:40:01 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@localhost.localdomain
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] fix oops after saving image
In-Reply-To: <20031001223751.GA6402@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0310020933140.997-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> --- tmp/linux/kernel/power/swsusp.c	2003-10-02 00:04:35.000000000 +0200
> +++ linux/kernel/power/swsusp.c	2003-10-01 23:56:49.000000000 +0200
> @@ -345,7 +348,7 @@
>  	printk( "|\n" );
>  
>  	MDELAY(1000);
> -	free_page((unsigned long) buffer);
> +	/* Trying to free_page((unsigned long) buffer) here is bad idea, not sure why */
>  	return 0;
>  }

Patches like this really do a disservice to anyone trying to read the code 
and figure out what is going on. I've spent a considerable amount of time 
deciphering and santizing the swsusp code, which is why pmdisk exists. 

The patch is simply a band-aid, and completely meaningless without the 
context of the email. If I applied this, one would be able to ascertain 
the reason for the patch, if they manipulated the BK tools correctly. 
However, seeing that line solely in the context on the rest of the source 
makes one cock their head, squint their eyes and pray that they never have 
to look at that file again. 

If you're seeing an Oops, please search more for the cause and submit a 
real fix for it. 

Or, simply change the semantics of the code enough to eliminate the
possibility of a problem. In the pmdisk code, I've statically declared the 
header, so we don't need that alloc/free. Please see that file for an 
example. 


	Pat

