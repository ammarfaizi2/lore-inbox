Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315599AbSGJKsF>; Wed, 10 Jul 2002 06:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315607AbSGJKsE>; Wed, 10 Jul 2002 06:48:04 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:59520 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S315599AbSGJKsD>; Wed, 10 Jul 2002 06:48:03 -0400
Date: Wed, 10 Jul 2002 12:24:14 +0200
From: Richard Zidlicky 
	<Richard.Zidlicky@stud.informatik.uni-erlangen.de>
To: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
Cc: "'Bartlomiej Zolnierkiewicz'" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org, "'axboe@suse.de'" <axboe@suse.de>
Subject: Re: (RE:  using 2.5.25 with IDE) On sparc64.....
Message-ID: <20020710122414.B2142@linux-m68k.org>
References: <61DB42B180EAB34E9D28346C11535A783A7B56@nocmail101.ma.tmpw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <61DB42B180EAB34E9D28346C11535A783A7B56@nocmail101.ma.tmpw.net>; from bruce.holzrichter@monster.com on Tue, Jul 09, 2002 at 09:46:10AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2002 at 09:46:10AM -0500, Holzrichter, Bruce wrote:

> Patch below to get 2.4 forward port of IDE to compile on Sparc64...
> --- linus-2.5/include/asm-sparc64/ide.h	Tue Jul  9 08:53:10 2002
> +++ sparctest/include/asm-sparc64/ide.h	Tue Jul  9 09:11:24 2002


> @@ -178,6 +182,20 @@
>  #endif
>  }
>  
> +#define ide_request_irq(irq,hand,flg,dev,id)
> request_irq((irq),(hand),(flg),(dev),(id))
> +#define ide_free_irq(irq,dev_id)		free_irq((irq), (dev_id))
> +#define ide_check_region(from,extent)		check_region((from),
> (extent))
> +#define ide_request_region(from,extent,name)	request_region((from),
> (extent), (name))
> +#define ide_release_region(from,extent)
> release_region((from), (extent))
> +
> +/*
> + * The following are not needed for the non-m68k ports
> + */
> +#define ide_ack_intr(hwif)		(1)
> +#define ide_fix_driveid(id)		do {} while (0)
           ^^^^^^^^^^^^^^^

the comment is misleading, this is actually needed on more than m68k
so not a big surprise it doesn't work. Cut&paste from 2.4.

Richard
