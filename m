Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbTLYJ44 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 04:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264289AbTLYJ4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 04:56:55 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:31243 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S264286AbTLYJ4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 04:56:48 -0500
Date: Thu, 25 Dec 2003 08:06:48 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Bart Samwel <bart@samwel.tk>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] laptop-mode for 2.6, version 3
Message-ID: <20031225100648.GB13382@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Bart Samwel <bart@samwel.tk>, Jens Axboe <axboe@suse.de>,
	linux-kernel@vger.kernel.org
References: <3FE92517.1000306@samwel.tk> <20031224111640.GL1601@suse.de> <3FE9AFFC.2080302@samwel.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE9AFFC.2080302@samwel.tk>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor nitpicks below

Em Wed, Dec 24, 2003 at 04:25:48PM +0100, Bart Samwel escreveu:
> diff -baur --speed-large-files linux-2.6.0/mm/page-writeback.c linux-2.6.0-withlaptopmode/mm/page-writeback.c
> --- linux-2.6.0/mm/page-writeback.c	2003-12-24 05:19:46.000000000 +0100
> +++ linux-2.6.0-withlaptopmode/mm/page-writeback.c	2003-12-24 15:49:55.000000000 +0100
> @@ -28,6 +28,7 @@
>  #include <linux/smp.h>
>  #include <linux/sysctl.h>
>  #include <linux/cpu.h>
> +#include <linux/quotaops.h>
>  
>  /*
>   * The maximum number of pages to writeout in a single bdflush/kupdate
> @@ -81,6 +82,16 @@
>   */
>  int dirty_expire_centisecs = 30 * 100;
>  
> +/*
> + * Flag that makes the machine dump writes/reads and block dirtyings.
> + */
> +int block_dump = 0;
> +
> +/*
> + * Flag that puts the machine in "laptop mode".
> + */
> +int laptop_mode = 0;
> +

No need to set a global variable to 0, if you don't set it'll go to the
.bss section and the kernel will zero it out for us, and we reclaim 
2 * sizeof(int) from the kernel image. This is common style in most parts
of the kernel.

- Arnaldo
