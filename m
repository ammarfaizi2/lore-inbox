Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290793AbSBFUYZ>; Wed, 6 Feb 2002 15:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290790AbSBFUYO>; Wed, 6 Feb 2002 15:24:14 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:37422 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S290787AbSBFUYD> convert rfc822-to-8bit; Wed, 6 Feb 2002 15:24:03 -0500
Date: Tue, 5 Feb 2002 22:23:02 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: "David S. Miller" <davem@redhat.com>
cc: <hch@caldera.de>, <davidm@hpl.hp.com>, <mmadore@turbolinux.com>,
        <linux-ia64@linuxia64.org>, <linux-kernel@vger.kernel.org>,
        <torvalds@transmeta.com>
Subject: Re: [Linux-ia64] Proper fix for sym53c8xx_2 driver and dma64_addr_t
In-Reply-To: <20020206.004503.118628125.davem@redhat.com>
Message-ID: <20020205221314.F1707-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Feb 2002, David S. Miller wrote:

>    From: Christoph Hellwig <hch@caldera.de>
>    Date: Wed, 6 Feb 2002 09:35:58 +0100
>
>    On Wed, Feb 06, 2002 at 12:29:06AM -0800, David S. Miller wrote:
>    > So who needs it? :-)
>
>    The new sym53c8xx driver (sym2), and that one only if is actually is
>    configured for DAC-mode (SYM_CONF_DMA_ADDRESSING_MODE > 0).
>
> It is not using the DMA apis correctly then, it should be using
> dma_addr_t which may or may not be 64-bits on a given platform.
>
> The sym2 driver needs to be fixed.

The code written at 't' time was using what was available at that time.
If you can let me know when Linux will be rewritten in Java, this will be
useful for me to be ready in time. :-)

--- sym_glue.c	Sun Dec 30 21:33:10 2001
+++ a.c	Tue Feb  5 22:17:30 2002
@@ -313,11 +313,7 @@
 #ifndef SYM_LINUX_DYNAMIC_DMA_MAPPING
 typedef u_long		bus_addr_t;
 #else
-#if	SYM_CONF_DMA_ADDRESSING_MODE > 0
-typedef dma64_addr_t	bus_addr_t;
-#else
 typedef dma_addr_t	bus_addr_t;
-#endif
 #endif

You may get a couple of warnings, but since I haven't hardware to check
this, I am ready to apply patches.


  Gérard.

PS:
The driver Java version is planned to be available on April the 1rst.  ;)


