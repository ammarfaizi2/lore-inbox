Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbTELWLh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 18:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262880AbTELWLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 18:11:37 -0400
Received: from palrel10.hp.com ([156.153.255.245]:53888 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262878AbTELWLd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 18:11:33 -0400
Date: Mon, 12 May 2003 15:24:16 -0700
To: Adrian Bunk <bunk@fs.tum.de>
Cc: yoshfuji@linux-ipv6.org, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.5.69-bk7: wireless.c must include module.h
Message-ID: <20030512222416.GA26396@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030512220512.GC1107@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030512220512.GC1107@fs.tum.de>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 12:05:12AM +0200, Adrian Bunk wrote:
> <--  snip  -->
> 
> ...
>   gcc -Wp,-MD,net/core/.wireless.o.d -D__KERNEL__ -Iinclude -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
> -pipe -mpreferred-stack-boundary=2 -march=k6 
> -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    
> -DKBUILD_BASENAME=wireless -DKBUILD_MODNAME=wireless -c -o 
> net/core/wireless.o net/core/wireless.c
> net/core/wireless.c:488: `THIS_MODULE' undeclared here (not in a function)
> net/core/wireless.c:488: initializer element is not constant
> net/core/wireless.c:488: (near initialization for `wireless_seq_fops.owner')
> make[2]: *** [net/core/wireless.o] Error 1
> 
> <--  snip  -->
> 
> 
> The fix is simple:
> 
> --- linux-2.5.69-bk7/net/core/wireless.c.old	2003-05-13 00:02:06.000000000 +0200
> +++ linux-2.5.69-bk7/net/core/wireless.c	2003-05-13 00:02:42.000000000 +0200
> @@ -60,6 +60,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/init.h>			/* for __init */
>  #include <linux/if_arp.h>		/* ARPHRD_ETHER */
> +#include <linux/module.h>
>  
>  #include <linux/wireless.h>		/* Pretty obvious */
>  #include <net/iw_handler.h>		/* New driver API */
> 
> 
> 
> cu
> Adrian

	I still managed to beat you by a few minute ;-)
http://marc.theaimsgroup.com/?l=linux-kernel&m=105276406917601&w=2

	Thanks !

	Jean
