Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271719AbRIVQFX>; Sat, 22 Sep 2001 12:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271787AbRIVQFN>; Sat, 22 Sep 2001 12:05:13 -0400
Received: from fep01-0.kolumbus.fi ([193.229.0.41]:17620 "EHLO
	fep01-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id <S271719AbRIVQEy>; Sat, 22 Sep 2001 12:04:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hristo Grigorov <Hristo.Grigorov@Kolumbus.FI>
To: Martin Heiss <mheiss99@uni.de>, linux-kernel@vger.kernel.org
Subject: Re: Kernel PPP driver broken in 2.4.10-pre14
Date: Sat, 22 Sep 2001 17:54:36 -0400
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <200109221547.f8MFlUP06141@bau1.a-city.de>
In-Reply-To: <200109221547.f8MFlUP06141@bau1.a-city.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010922160519.ZZGN11276.fep01-app.kolumbus.fi@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Next time do not waste your time; check the mailing list beforehand...

That problem was found, fixed and now waiting on some very-very long
queue to be merged.

H.

On Saturday 22 September 2001 11:47, Martin Heiss wrote:
> Hi,
> the linux kernel 2.4.10-pre14 ppp driver seems to be broken for me.
> In kernels <= 2.4.9 it used to work fine!
>
> When i try to insmod the "ppp_async" module it complains about "unresolved
> symbol tty_register_ldisc" and therefore refuses to load.
>
> After looking at the changes being introduced in 2.4.10-pre I was able to
> fix the problem:
>
> The problem is caused by the fact, that in 2.4.10-pre* the line
> 	EXPORT_SYMBOL(tty_register_ldisc);
> has been _removed_ from 'net/netsyms.c'
>
> after readding this line (i added the "EXPORT_SYMBOL(tty_register_ldisc);"
> right under the tty_register_ldisc declaration in "drivers/char/tty_io.c",
> but "net/netsyms.c" should work too) and recompiling everything now works
> fine for me. (ppp_async now loads correctly again)
>
> Therefore I recommend you to readd the
> 	EXPORT_SYMBOL(tty_register_ldisc);
> line whereever you consider it the right place (e.g. drivers/char/tty_io.c
> etc)
>
> cu
>
>    Martin Heiss
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Regards, Hristo.

