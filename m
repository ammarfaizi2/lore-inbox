Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267245AbTBQOiV>; Mon, 17 Feb 2003 09:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267199AbTBQOhG>; Mon, 17 Feb 2003 09:37:06 -0500
Received: from mail.zmailer.org ([62.240.94.4]:45723 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S267157AbTBQOFx>;
	Mon, 17 Feb 2003 09:05:53 -0500
Date: Mon, 17 Feb 2003 16:15:50 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH *] use 64 bit jiffies
Message-ID: <20030217141550.GM1073@mea-ext.zmailer.org>
References: <20030204092936.GA14495@wohnheim.fh-wedel.de> <Pine.LNX.4.33.0302041401010.1267-100000@gans.physik3.uni-rostock.de> <20030217135505.GF6282@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030217135505.GF6282@wohnheim.fh-wedel.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2003 at 02:55:05PM +0100, Jörn Engel wrote:

With:

> +#ifdef CONFIG_DEBUG_JIFFIESWRAP
> +  /* Make the jiffies counter wrap around sooner. */
> +# define INITIAL_JIFFIES ((unsigned long)(-300*HZ))
> +#else
> +# define INITIAL_JIFFIES 0
> +#endif

This will store constants into  jiffies_msb_flips:
("1" for DEBUG_JIFFIESWRAP, "0" otherwise.)
Wouldn't zero be what will always be needed ?

> -unsigned long volatile jiffies;
> +unsigned long volatile jiffies = INITIAL_JIFFIES;
>  #ifdef NEEDS_JIFFIES_64
> -static unsigned int volatile jiffies_msb_flips;
> +static unsigned int volatile
> +	jiffies_msb_flips = INITIAL_JIFFIES>>(BITS_PER_LONG-1);
>  #endif

/Matti Aarnio
