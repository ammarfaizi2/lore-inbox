Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264993AbTFQW4R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 18:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264994AbTFQW4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 18:56:17 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:42707 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264993AbTFQW4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 18:56:13 -0400
Date: Wed, 18 Jun 2003 01:10:01 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Joe Thornber <thornber@sistina.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] dm: Replace __HIGH() and __LOW() macros
Message-ID: <20030617231000.GH29247@fs.tum.de>
References: <20030609142946.GA11331@fib011235813.fsnet.co.uk> <20030609143440.GB11331@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030609143440.GB11331@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 09, 2003 at 03:34:40PM +0100, Joe Thornber wrote:
> Replace __HIGH() and __LOW() with max() and min_not_zero().
> --- diff/drivers/md/dm-table.c	2003-05-21 11:50:15.000000000 +0100
> +++ source/drivers/md/dm-table.c	2003-06-09 15:04:57.000000000 +0100
> @@ -78,22 +78,33 @@
>  	return result;
>  }
>  
> -#define __HIGH(l, r) if (*(l) < (r)) *(l) = (r)
> -#define __LOW(l, r) if (*(l) == 0 || *(l) > (r)) *(l) = (r)
> +/*
> + * Returns the minimum that is _not_ zero, unless both are zero.
> + */
> +#define min_not_zero(l, r) (l == 0) ? r : ((r == 0) ? l : min(l, r))
>...

Are there potential other users of min_not_zero?
If yes, shouldn't it go into kernel.h?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

