Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965123AbVLOL6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965123AbVLOL6r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 06:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965188AbVLOL6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 06:58:47 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:11240 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965123AbVLOL6q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 06:58:46 -0500
Date: Thu, 15 Dec 2005 12:58:12 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Al Viro <viro@ftp.linux.org.uk>
cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-m68k@vger.kernel.org
Subject: Re: [PATCH 1/3] m68k: compile fix - hardirq checks were in wrong
 place
In-Reply-To: <20051215085402.GT27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.61.0512151252110.1605@scrub.home>
References: <20051215085402.GT27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 15 Dec 2005, Al Viro wrote:

> Move the sanity check for NR_IRQS being no more than 1<<HARDIRQ_BITS
> from asm-m68k/hardirq.h to asm-m68k/irq.h; needed since NR_IRQS is
> not necessary know at the points of inclusion of asm/hardirq.h due
> to the rather ugly header dependencies on m68k.  Fix is by far simpler
> than trying to massage those dependencies...

I disagree.

> diff --git a/include/asm-m68k/hardirq.h b/include/asm-m68k/hardirq.h
> index 728318b..5e1c582 100644
> --- a/include/asm-m68k/hardirq.h
> +++ b/include/asm-m68k/hardirq.h
> @@ -14,13 +14,4 @@ typedef struct {
>  
>  #define HARDIRQ_BITS	8
>  
> -/*
> - * The hardirq mask has to be large enough to have
> - * space for potentially all IRQ sources in the system
> - * nesting on a single CPU:
> - */
> -#if (1 << HARDIRQ_BITS) < NR_IRQS
> -# error HARDIRQ_BITS is too low!
> -#endif
> -
>  #endif

You separate the definition from the check, now you push the 
responsibility to get the order right to the header users.
Sorry, but I prefer to fix the header dependencies than scatter things 
which belong together over multiple files.

bye, Roman
