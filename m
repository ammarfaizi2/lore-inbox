Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbWGSCol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbWGSCol (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 22:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWGSCol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 22:44:41 -0400
Received: from in.cluded.net ([195.159.98.120]:4747 "EHLO in.cluded.net")
	by vger.kernel.org with ESMTP id S932461AbWGSCok (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 22:44:40 -0400
Message-ID: <44BD9BA8.7070202@cluded.net>
Date: Wed, 19 Jul 2006 02:40:40 +0000
From: "Daniel K." <daniel@cluded.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9a1) Gecko/20060307 SeaMonkey/1.5a
MIME-Version: 1.0
To: Panagiotis Issaris <takis@lumumba.uhasselt.be>
CC: linux-kernel@vger.kernel.org, len.brown@intel.com, chas@cmf.nrl.navy.mil,
       miquel@df.uba.ar, kkeil@suse.de, benh@kernel.crashing.org,
       video4linux-list@redhat.com, rmk+mmc@arm.linux.org.uk,
       Neela.Kolli@engenio.com, jgarzik@pobox.com, vandrove@vc.cvut.cz,
       adaplas@pol.net, thomas@winischhofer.net, weissg@vienna.at,
       philb@gnu.org, linux-pcmcia@lists.infradead.org, jkmaline@cc.hut.fi,
       paulus@samba.org
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset to k(z|c)alloc.
References: <20060719004659.GA30823@lumumba.uhasselt.be>
In-Reply-To: <20060719004659.GA30823@lumumba.uhasselt.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Panagiotis Issaris wrote:
> diff --git a/drivers/char/rio/rio_linux.c b/drivers/char/rio/rio_linux.c
> index 3fa80aa..7c84863 100644
> --- a/drivers/char/rio/rio_linux.c
> +++ b/drivers/char/rio/rio_linux.c
> @@ -802,12 +802,7 @@ static int rio_init_drivers(void)
>  
>  static void *ckmalloc(int size)
>  {
> -	void *p;
> -
> -	p = kmalloc(size, GFP_KERNEL);
> -	if (p)
> -		memset(p, 0, size);
> -	return p;
> +	return kzalloc(size, GFP_KERNEL);
>  }
>  
>  
> diff --git a/drivers/char/rio/riocmd.c b/drivers/char/rio/riocmd.c
> index 4df6ab2..593940f 100644
> --- a/drivers/char/rio/riocmd.c
> +++ b/drivers/char/rio/riocmd.c
> @@ -556,9 +556,7 @@ struct CmdBlk *RIOGetCmdBlk(void)
>  {
>  	struct CmdBlk *CmdBlkP;
>  
> -	CmdBlkP = (struct CmdBlk *)kmalloc(sizeof(struct CmdBlk), GFP_ATOMIC);
> -	if (CmdBlkP)
> -		memset(CmdBlkP, 0, sizeof(struct CmdBlk));
> +	CmdBlkP = kzalloc(sizeof(struct CmdBlk), GFP_ATOMIC);
>  	return CmdBlkP;
>  }
>  

Why not return kzalloc(...) here? Alternatively, return (type *) kzalloc(...),
if you believe in explicit type casting of void pointers.

> diff --git a/drivers/serial/ip22zilog.c b/drivers/serial/ip22zilog.c
> index 5ff269f..ca0e9f2 100644
> --- a/drivers/serial/ip22zilog.c
> +++ b/drivers/serial/ip22zilog.c
> @@ -925,11 +925,7 @@ static int zilog_irq = -1;
>  static void * __init alloc_one_table(unsigned long size)
>  {
>  	void *ret;
> -
> -	ret = kmalloc(size, GFP_KERNEL);
> -	if (ret != NULL)
> -		memset(ret, 0, size);
> -
> +	ret = kzalloc(size, GFP_KERNEL);
>  	return ret;
>  }
>  

And here as well.

What is preferred by developers?


Daniel K.
