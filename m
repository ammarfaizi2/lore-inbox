Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262656AbTCIWxB>; Sun, 9 Mar 2003 17:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262657AbTCIWxB>; Sun, 9 Mar 2003 17:53:01 -0500
Received: from phobos.planet.net.au ([203.15.90.5]:32522 "HELO
	phobos.planet.net.au") by vger.kernel.org with SMTP
	id <S262656AbTCIWxA>; Sun, 9 Mar 2003 17:53:00 -0500
Date: Mon, 10 Mar 2003 09:48:29 +1100 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Memleak in ircomm_core
In-Reply-To: <20030309211434.GA31791@linuxhacker.ru>
Message-ID: <Pine.LNX.4.05.10303100944220.5706-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Mar 2003, Oleg Drokin wrote:

> Hello!
> 
>    There seems to be a memleak on error exit path. The same patch should apply
>    to 2.5 and 2.4
> 
>    Found with help of smatch + enhanced unfree script.
> 
> Bye,
>     Oleg
> 
> ===== net/irda/ircomm/ircomm_core.c 1.5 vs edited =====
> --- 1.5/net/irda/ircomm/ircomm_core.c	Tue Aug  6 22:23:24 2002
> +++ edited/net/irda/ircomm/ircomm_core.c	Mon Mar 10 00:10:10 2003
> @@ -121,8 +121,10 @@
>  	} else
>  		ret = ircomm_open_tsap(self);
>  
> -	if (ret < 0)
> +	if (ret < 0) {
> +		kfree(self);
>  		return NULL;
> +	}
>  
>  	self->service_type = service_type;
>  	self->line = line;
> -

Must be an old one - looks like the same patch is needed in 2.2.24-rc5.

HTH,
Neale.

