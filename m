Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262030AbSI3MXl>; Mon, 30 Sep 2002 08:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262036AbSI3MXl>; Mon, 30 Sep 2002 08:23:41 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:6138 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262030AbSI3MXk>; Mon, 30 Sep 2002 08:23:40 -0400
Subject: Re: 2.3.39 compile errors on Alpha
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Jochen Friedrich <jochen@scram.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.NEB.4.44.0209301257210.12605-100000@mimas.fachschaften.tu-muenchen.de>
References: <Pine.NEB.4.44.0209301257210.12605-100000@mimas.fachschaften.tu-muenchen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Sep 2002 13:35:40 +0100
Message-Id: <1033389340.16337.14.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-30 at 12:08, Adrian Bunk wrote:
> this is a known issue, the following patch (already in Linus' BK tree)
> fixes it:
> 
> --- linux-2.5.35-VIRGIN/drivers/atm/atmtcp.c	2002-08-24 00:08:21.000000000 -0700
> +++ linux-2.5.35/drivers/atm/atmtcp.c	2002-09-16 21:04:30.000000000 -0700
> @@ -275,7 +275,7 @@
>  		result = -ENOBUFS;
>  		goto done;
>  	}
> -	new_skb->stamp = xtime;
> +	do_gettimeofday(&new_skb->stamp);

Is this actually safe - suppose the machine has no tsc counter (eg old
x86 or indeed new x86 numa, speedstep using, etc). In that case
do_gettimeofday doesn't appear to be either IRQ safe or fast enough to
use in this way ?

Alan

