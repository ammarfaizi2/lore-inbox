Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313118AbSDOI6z>; Mon, 15 Apr 2002 04:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313120AbSDOI6y>; Mon, 15 Apr 2002 04:58:54 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4115 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313118AbSDOI6x>; Mon, 15 Apr 2002 04:58:53 -0400
Subject: Re: [BUG] kmem_cache_grow.
To: gang_hu@soul.com.cn (hugang)
Date: Mon, 15 Apr 2002 10:16:42 +0100 (BST)
Cc: linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <20020415144048.37318357.gang_hu@soul.com.cn> from "hugang" at Apr 15, 2002 02:40:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16x2bK-0005mD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Problem: first run "find /" , eject and insert pcmcia network's card, the kernel will crash.

Which network card and what kernel revision

> Kernel oops: at 
> linux/mm/slab.c->kmem_cache_grow.
>         if (in_interrupt() && (flags & SLAB_LEVEL_MASK) != SLAB_ATOMIC)
>                 BUG(); 		<-- here.
> 
> Can I remove this check ?

The kernel realised it was being made to sleep in an interrupt. If you
remove the check it will crash anyway. If you did something like

 	if(..... as before ...)
	{
		flags&=~SLAB_LEVEL_MASK;
		flags|=SLAB_ATOMIC;
		printk(KERN_ERR "kmem: critical memory allocation level error.\n");
	}

it ought to print a complaint and continue. Really however it wants fixing
