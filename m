Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280820AbRKLPnc>; Mon, 12 Nov 2001 10:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280821AbRKLPnW>; Mon, 12 Nov 2001 10:43:22 -0500
Received: from green.mif.pg.gda.pl ([153.19.42.8]:9220 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S280820AbRKLPnK>; Mon, 12 Nov 2001 10:43:10 -0500
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200111121448.PAA01060@green.mif.pg.gda.pl>
Subject: Re: [PATCH] VIA timer fix was removed?
To: pellegrini@mpcnet.com.br (Jeronimo Pellegrini)
Date: Mon, 12 Nov 2001 15:48:24 +0100 (CET)
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
In-Reply-To: <20011112111409.A2617@socrates> from "Jeronimo Pellegrini" at Nov 12, 2001 11:14:09 AM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The following patch (introduced by Vojtech Pavlik some time ago) was
> removed somewhere between 2.4.14 and 2.4.15-pre3.
> Without it, the timer counter is reset to a wrong value and
> gettimeofday() starts to return strange values
> 
> Nothing aboutit is mentioned in the changelog, so I suppose it wasn't
> supposed to be removed?

Maybe, it happens because somebody forgot to comment why this code is
necessary here ?
Just a guess...

> --- linux-2.4.15-pre3/arch/i386/kernel/time.c	Sun Nov 11 21:33:31 2001
> +++ linux-2.4.15-pre3-new/arch/i386/kernel/time.c	Mon Nov 12 10:45:57 2001
> @@ -501,6 +501,14 @@
>  
>  		count = inb_p(0x40);    /* read the latched count */
>  		count |= inb(0x40) << 8;
> +
> +		if (count > LATCH-1) {
> +			outb_p(0x34, 0x43);
> +		        outb_p(LATCH & 0xff, 0x40);
> +			outb(LATCH >> 8, 0x40);
> +			count = LATCH - 1;
> +		}
> +
>  		spin_unlock(&i8253_lock);

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
