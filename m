Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbTJCX6h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 19:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbTJCX4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 19:56:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:19636 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261602AbTJCXzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 19:55:00 -0400
Date: Fri, 3 Oct 2003 16:55:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org, cherry@osdl.org
Subject: Re: [PATCH] applicom: fix LEAK, unwind on errors;
Message-Id: <20031003165501.4c7edd59.akpm@osdl.org>
In-Reply-To: <20031003162532.62130e39.rddunlap@osdl.org>
References: <200310032246.h93Mker6018458@cherrypit.pdx.osdl.net>
	<20031003162532.62130e39.rddunlap@osdl.org>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
> -#warning "LEAK"
> -	RamIO = ioremap(mem, LEN_RAM_IO * MAX_ISA_BOARD);
> +	maxRamIO = ioremap(mem, LEN_RAM_IO * MAX_ISA_BOARD);
>  
> -	if (!RamIO) 
> +	if (!maxRamIO) 
>  		printk(KERN_INFO "ac.o: Failed to ioremap ISA memory space at 0x%lx\n", mem);


It seems that this driver is just testing to see if it can ioremap the
whole region before going through and mapping each board.

If we want to keep this sanity check then the iounmap should come
immediately after the ioremap, or it should just be removed.

Probably the latter: if the individual ioremaps work then they've worked,
haven't they?


