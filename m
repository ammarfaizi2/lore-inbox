Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270539AbRHNTbN>; Tue, 14 Aug 2001 15:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270757AbRHNTbD>; Tue, 14 Aug 2001 15:31:03 -0400
Received: from ns.caldera.de ([212.34.180.1]:56975 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S270539AbRHNTaz>;
	Tue, 14 Aug 2001 15:30:55 -0400
Date: Tue, 14 Aug 2001 21:30:23 +0200
Message-Id: <200108141930.f7EJUNj01929@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: chrisc@shad0w.org.uk (Chris Crowther)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CDP handler for linux
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <Pine.LNX.4.33.0108141934130.3283-100000@monolith.shad0w.org.uk>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chis,

In article <Pine.LNX.4.33.0108141934130.3283-100000@monolith.shad0w.org.uk> you wrote:
> 	I've been working on an addition to the kernel over the past
> couple of days that enables the kernel to interpret CDP (Cisco Discovery
> Protocol) packets which can be transmited by various pieces of Cisco kit.
>
> 	I've got it to the stage where it will read neighbors packets and
> display them via a /proc/net entry, but I've only really tested it with
> the router I have access to here, so I was wondering:



> --- linux-2.4/net/cdp/Makefile	Thu Jan  1 01:00:00 1970
> +++ linux-2.4.7-cdp/net/cdp/Makefile	Thu Aug  9 12:11:44 2001
> @@ -0,0 +1,25 @@
> +#
> +# Makefile for the Linux CDP layer.
> +#
> +# Note! Dependencies are done automagically by 'make dep', which also
> +# removes any old dependencies. DON'T put your own dependencies here
> +# unless it's something special (ie not a .c file).
> +#
> +# Note 2! The CFLAGS definition is now in the main makefile...
> +
> +# We only get in/to here if CONFIG_CDP = 'y' or 'm'
> +
> +O_TARGET := cdp.o
> +
> +export-objs = af_cdp.o

You don't export symbols, so you don't need to add your object to export-objs.

> +
> +obj-y	:= af_cdp.o
> +
> +ifeq ($(CONFIG_CDP),m)
> +  obj-m += $(O_TARGET)
> +endif
> +
> +include $(TOPDIR)/Rules.make
> +
> +tar:
> +		tar -cvf /dev/f1 .

Kill this tar rule, please :)

> diff -urN -X dontdiff linux-2.4/net/cdp/af_cdp.c linux-2.4.7-cdp/net/cdp/af_cdp.c
> --- linux-2.4/net/cdp/af_cdp.c	Thu Jan  1 01:00:00 1970
> +++ linux-2.4.7-cdp/net/cdp/af_cdp.c	Tue Aug 14 19:14:11 2001
> @@ -0,0 +1,509 @@
> +/*
> + *      Implements a CDP handler.
> + *
> + * 	This code is derived from protocol specifications by Cisco Systems
> + *	and various code culled from the Kernel source tree, mostly the IPX
> + *	code.
> + *
> + *	Unless otherwise commented, all revisions by Chris Crowther.
> + *
> + *	Revision 0.1.0:	Initial coding.
> + *	Revision 0.1.1:	Incoming CDP packet handling working, prefix's and addresses
> + *			need handling still.
> + *
> + *	Portions Copyright (c) 2001 Chris Crowther.

I think it's all yours, isn't it?


Besides this little nitpicks I'd like to give you the advise to send this
to linuxnetdev, too.

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
