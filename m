Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266718AbUAWXEf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 18:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266719AbUAWXEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 18:04:35 -0500
Received: from user-119ahgg.biz.mindspring.com ([66.149.70.16]:20432 "EHLO
	mail.home") by vger.kernel.org with ESMTP id S266718AbUAWXEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 18:04:31 -0500
From: Eric <eric@cisu.net>
To: linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: Correct CPUs printout on boot.
Date: Fri, 23 Jan 2004 17:03:54 -0600
User-Agent: KMail/1.5.94
References: <E1Ajuub-0000y1-00@hardwired>
In-Reply-To: <E1Ajuub-0000y1-00@hardwired>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401231703.54127.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 January 2004 12:35 am, davej@redhat.com wrote:
> This currently prints out the maximum number of CPUs the
> kernel is configured to support, instead of the actual
> number that the kernel brought up. Which results in odd
> displays that look like you have more CPUs than you do.

Why do you have to declare a new variable? Can't you just do this? i is 
already counting how many cpu's we've brought up and its of the same type j.

-	printk("CPUS done %u\n", max_cpus);
+	printk("CPUS done %u\n", i);


>     Dave
>
> diff -urpN --exclude-from=/home/davej/.exclude bk-linus/init/main.c
> linux-2.5/init/main.c --- linux-2.5/init/main.c~	Fri Jan 23 06:24:12 2004
> +++ linux-2.5/init/main.c	Fri Jan 23 06:24:44 2004
> @@ -339,7 +339,7 @@
>  /* Called by boot processor to activate the rest. */
>  static void __init smp_init(void)
>  {
> -	unsigned int i;
> +	unsigned int i, j=0;
>
>  	/* FIXME: This should be done in userspace --RR */
>  	for (i = 0; i < NR_CPUS; i++) {
> @@ -348,11 +348,12 @@
>  		if (cpu_possible(i) && !cpu_online(i)) {
>  			printk("Bringing up %i\n", i);
>  			cpu_up(i);
> +			j++;
>  		}
>  	}
>
>  	/* Any cleanup work */
> -	printk("CPUS done %u\n", max_cpus);
> +	printk("CPUS done %u\n", j);
>  	smp_cpus_done(max_cpus);
>  #if 0
>  	/* Get other processors into their bootup holding patterns. */

 
-------------------------
Eric Bambach
Eric at cisu dot net
-------------------------
