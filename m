Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267534AbTALVcX>; Sun, 12 Jan 2003 16:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267536AbTALVcX>; Sun, 12 Jan 2003 16:32:23 -0500
Received: from 5-116.ctame701-1.telepar.net.br ([200.193.163.116]:33408 "EHLO
	5-116.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S267534AbTALVcW>; Sun, 12 Jan 2003 16:32:22 -0500
Date: Sun, 12 Jan 2003 19:40:50 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Rob Wilkens <robw@optonline.net>
cc: Matti Aarnio <matti.aarnio@zmailer.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
In-Reply-To: <1042406849.3162.121.camel@RobsPC.RobertWilkens.com>
Message-ID: <Pine.LNX.4.50L.0301121939170.26759-100000@imladris.surriel.com>
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com>
 <1042400094.1208.26.camel@RobsPC.RobertWilkens.com> <20030112211530.GP27709@mea-ext.zmailer.org>
 <1042406849.3162.121.camel@RobsPC.RobertWilkens.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jan 2003, Rob Wilkens wrote:
> On Sun, 2003-01-12 at 16:15, Matti Aarnio wrote:

> > At first, read   Documentation/CodingStyle   of the kernel.
> > Then have a look into:
> >
> >     fs/open.c  file    do_sys_truncate()  function.

> -	if (S_ISDIR(inode->i_mode))
> -		goto dput_and_out;
> +	if (S_ISDIR(inode->i_mode)){
> +		path_release(&nd);
> +		return error;
> +	}

	[snip same change in a few more changes]

OK, now imagine the dcache locking changing a little bit.
You need to update this piece of (duplicated) code in half
a dozen places in just this function and no doubt in dozens
of other places all over fs/*.c.

>From a maintenance point of view, a goto to a single block
of error handling code is easier to maintain.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
