Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbWCOOdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbWCOOdI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 09:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWCOOdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 09:33:07 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:2099 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932428AbWCOOdG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 09:33:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=gF2bFUtPZ1sTNKhgMT6+C1SyC9Vo0LhxbvcoJrTuFLBWxv80x/9sqcM01069wr/ZCMjfp9G8Yj2TNYWJzXxipCMolkph2g1XCexMwwzKxwGNZMe2eNK4FuLeNitRx3LPXG31zPKgJAreaxrJ2D3F2wa9kVv12OXKHQHhkDrpT+k=
Date: Wed, 15 Mar 2006 17:33:01 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: PATCH: rio driver rework continued  #2
Message-ID: <20060315143301.GA7790@mipter.zuzino.mipt.ru>
References: <1142425657.5597.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142425657.5597.13.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2006 at 12:27:36PM +0000, Alan Cox wrote:
> First large chunk of code cleanup. The split between this and #3 and #4
> is fairly arbitary and due to the message length limit on the list.
> These patches continue the process of ripping out macros and typedefs
> while cleaning up lots of 32bit assumptions. Several inlines for
> compatibility also get removed and that causes a lot of noise.

> --- linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/rioparam.c
> +++ linux-2.6.16-rc6-mm1/drivers/char/rio/rioparam.c
> @@ -247,7 +240,7 @@
>  	}
>
>  	rio_dprintk(RIO_DEBUG_PARAM, "can_add_transmit() returns %x\n", res);
> -	rio_dprintk(RIO_DEBUG_PARAM, "Packet is 0x%x\n", (int) PacketP);
> +	rio_dprintk(RIO_DEBUG_PARAM, "Packet is 0x%p\n", PacketP);
						^^^^

Just %p.

> @@ -466,10 +459,10 @@
>  	rio_dprintk(RIO_DEBUG_TTY, "port close SysPort %d\n", PortP->PortNum);
>
>  	/* PortP = p->RIOPortp[SysPort]; */
> -	rio_dprintk(RIO_DEBUG_TTY, "Port is at address 0x%x\n", (int) PortP);
> +	rio_dprintk(RIO_DEBUG_TTY, "Port is at address 0x%p\n", PortP);
>  	/* tp = PortP->TtyP; *//* Get tty */
>  	tty = PortP->gs.tty;
> -	rio_dprintk(RIO_DEBUG_TTY, "TTY is at address 0x%x\n", (int) tty);
> +	rio_dprintk(RIO_DEBUG_TTY, "TTY is at address 0x%p\n", tty);

Ditto.

