Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbUKHGvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbUKHGvQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 01:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbUKHGvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 01:51:16 -0500
Received: from gate.crashing.org ([63.228.1.57]:6529 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261756AbUKHGvN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 01:51:13 -0500
Subject: Re: fbdev: fix compile of rivafb on __BIG_ENDIAN
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "Antonino A. Daplas" <adaplas@hotpop.com>
In-Reply-To: <200411080605.iA865Sr3009548@hera.kernel.org>
References: <200411080605.iA865Sr3009548@hera.kernel.org>
Content-Type: text/plain
Date: Mon, 08 Nov 2004 17:49:56 +1100
Message-Id: <1099896596.5295.159.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-08 at 04:36 +0000, Linux Kernel Mailing List wrote:
> ChangeSet 1.2606, 2004/11/07 20:36:41-08:00, torvalds@ppc970.osdl.org
> 
> 	fbdev: fix compile of rivafb on __BIG_ENDIAN
> 	
> 	Typo introduced by latest cleanups by Antonino
> 
> 
> 
>  riva_hw.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> 
> diff -Nru a/drivers/video/riva/riva_hw.c b/drivers/video/riva/riva_hw.c
> --- a/drivers/video/riva/riva_hw.c	2004-11-07 22:05:40 -08:00
> +++ b/drivers/video/riva/riva_hw.c	2004-11-07 22:05:40 -08:00
> @@ -2112,7 +2112,7 @@
>  #ifdef __BIG_ENDIAN
>      /* turn on big endian register access */
>      if(!(NV_RD32(chip->PMC, 0x00000004) & 0x01000001))
> -    	NV_WR32(chip->PMC, 0x00000004], 0x01000001);
> +    	NV_WR32(chip->PMC, 0x00000004, 0x01000001);
>  #endif

Since the NV_* macros now use byteswapping readX/writeX, we probably
want to remove the above bits completely... I suspect as-is, the driver
no longer works on ppc, but then, I don't have nVidia HW to test any
more.

Ben.


