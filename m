Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132392AbRCaOBy>; Sat, 31 Mar 2001 09:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132395AbRCaOBp>; Sat, 31 Mar 2001 09:01:45 -0500
Received: from balu.sch.bme.hu ([152.66.224.40]:57329 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S132392AbRCaOB0>;
	Sat, 31 Mar 2001 09:01:26 -0500
Date: Sat, 31 Mar 2001 16:00:27 +0200
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem in drivers/block/Config.in (PATCH)
Message-ID: <20010331160027.A26494@balu.sch.bme.hu>
Mail-Followup-To: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200103302017.f2UKH8S07176@wildsau.idv-edu.uni-linz.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200103302017.f2UKH8S07176@wildsau.idv-edu.uni-linz.ac.at>; from herp@wildsau.idv-edu.uni-linz.ac.at on Fri, Mar 30, 2001 at 10:17:08PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 30, 2001 at 10:17:08PM +0200, Herbert Rosmanith wrote:
> 
> hi,
> 
> I noticed that the option CONFIG_PARIDE_PARPORT will always be "y",
> even if CONFIG_PARIDE_PARPORT="n". I checked with kernels 2.2.18
> and 2.2.19.
> 
> the file responsible is "drivers/block/Config.in", around line 126.
> it reads:
> 
> # PARIDE doesn't need PARPORT, but if PARPORT is configured as a module,
> # PARIDE must also be a module.  The bogus CONFIG_PARIDE_PARPORT option
> # controls the choices given to the user ...
> 
> if [ "$CONFIG_PARPORT" = "y" -o "$CONFIG_PARPORT" = "n" ] ; then
>    define_bool CONFIG_PARIDE_PARPORT y
> else
>    define_bool CONFIG_PARIDE_PARPORT m
> fi
> 
> so, as you can see, CONFIG_PARIDE_PARPORT will be set to "yes" even
> if CONFIG_PARPORT="no".
> 
> why not simply write:
> 
> 	define_bool CONFIG_PARIDE_PARPORT $CONFIG_PARPORT
> 
> instead?

In fact, if we want to get what is said in the comment, we should write:

if [ "$CONFIG_PARPORT" = "m" -a "$CONFIG_PARIDE_PARPORT" = "y" ] ; then
   define_bool CONFIG_PARIDE_PARPORT m
fi

regards,
Balazs Pozsar.
