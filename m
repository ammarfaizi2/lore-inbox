Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261610AbSJJRI5>; Thu, 10 Oct 2002 13:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261689AbSJJRI5>; Thu, 10 Oct 2002 13:08:57 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:65197 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261610AbSJJRI4>; Thu, 10 Oct 2002 13:08:56 -0400
Subject: Re: [PATCH] kill ide-lib.c warning
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Andre M. Hedrick" <andre@linux-ide.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0210101846170.2509-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0210101846170.2509-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Oct 2002 18:25:43 +0100
Message-Id: <1034270743.6462.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-10 at 17:48, Geert Uytterhoeven wrote:
> 
> Kill warning (speed is u8, while XFER_PIO_4 is int)
> 
> --- linux-2.5.41/drivers/ide/ide-lib.c	Sun Sep 29 11:03:01 2002
> +++ linux-m68k-2.5.41/drivers/ide/ide-lib.c	Thu Oct 10 17:51:25 2002
> @@ -171,7 +171,7 @@
>  		BUG();
>  	return min(speed, speed_max[mode]);
>  #else /* !CONFIG_BLK_DEV_IDEDMA */
> -	return min(speed, XFER_PIO_4);
> +	return min(speed, (__typeof(speed))XFER_PIO_4);

I'd prefer (u8) - that way if it changes again we'll get the warning
back

