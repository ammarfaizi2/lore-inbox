Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263648AbTH1Ald (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 20:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263601AbTH1AlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 20:41:21 -0400
Received: from [62.75.136.201] ([62.75.136.201]:58784 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S263599AbTH1AlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 20:41:16 -0400
Message-ID: <3F4D6BC5.3050901@g-house.de>
Date: Thu, 28 Aug 2003 04:41:09 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030815
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: parport_pc Oops with 2.6.0-test3
References: <200308160438.59489.gene.heskett@verizon.net>	<1061030883.13257.253.camel@workshop.saharacpt.lan>	<200308161107.21430.gene.heskett@verizon.net>	<3F4AA6FF.9050601@g-house.de> <20030826013829.73d00992.akpm@osdl.org>
In-Reply-To: <20030826013829.73d00992.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> --- 25/drivers/parport/parport_pc.c~parport_pc-rmmod-oops-fix	2003-08-26 01:32:59.000000000 -0700
> +++ 25-akpm/drivers/parport/parport_pc.c	2003-08-26 01:33:08.000000000 -0700
> @@ -93,7 +93,7 @@ static struct superio_struct {	/* For Su
>  	int dma;
>  } superios[NR_SUPERIOS] __devinitdata = { {0,},};
>  
> -static int user_specified __devinitdata = 0;
> +static int user_specified;
>  #if defined(CONFIG_PARPORT_PC_SUPERIO) || \
>         (defined(CONFIG_PARPORT_1284) && defined(CONFIG_PARPORT_PC_FIFO))
>  static int verbose_probing;

ah, that did it. now i get

parport0: PC-style at 0x378 (0x778), irq 7, using FIFO \ 
[PCSPP,TRISTATE,COMPAT,ECP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)

upon loading of parport_pc and no oops when unloading (tried it several 
times, even with a tainted kernel.)

you know, even tiny patches like this (a single line changed!) look 
quite incredible to a non hacker (me). with this little bits of 
information i gave you, you produced a working patch. this is...totally 
cool, really.


Thank you very much,
Christian.
-- 
BOFH excuse #312:

incompatible bit-registration operators

