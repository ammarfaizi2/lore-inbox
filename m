Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266720AbSKHCsA>; Thu, 7 Nov 2002 21:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266722AbSKHCsA>; Thu, 7 Nov 2002 21:48:00 -0500
Received: from [192.58.209.91] ([192.58.209.91]:19874 "HELO handhelds.org")
	by vger.kernel.org with SMTP id <S266720AbSKHCr7>;
	Thu, 7 Nov 2002 21:47:59 -0500
From: George France <france@handhelds.org>
To: Richard Henderson <rth@twiddle.net>,
       axp-list mailing list <axp-list@redhat.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] eliminate compile warnings
Date: Thu, 7 Nov 2002 21:54:29 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
References: <20021106214705.A15525@Marvin.DL8BCU.ampr.org> <20021107202855.B17028@Marvin.DL8BCU.ampr.org> <20021107173349.A4017@twiddle.net>
In-Reply-To: <20021107173349.A4017@twiddle.net>
Cc: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
MIME-Version: 1.0
Message-Id: <02110721542901.28099@shadowfax.middleearth>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Richard,

As I said earlier, I did not have time to look at the patch today, but
I was going to save it with some other alpha kernel patches and
was going to look at it next week.  From the snippet of code that
you included in this e-mail, I agree 100% with your analysis of this
patch and the correct way to proceed.  I would not want you to
apply such a jumbo patch.

Today we were mostly absorbed in discussing where  or too whom
should Thorsten send the patch instead of the patch itself, since
there is no maintainer in the MAINTAINERS file.

Thank you very much for taking the time to review and consider
this patch.

Best Regards,


--George


On Thursday 07 November 2002 20:33, Richard Henderson wrote:
> As for the patch itself, it's not correct.  At a glance,
>
> > 	addr = arch_get_unmapped_area_1 (PAGE_ALIGN(addr), len, limit);
> > -	if (addr != -ENOMEM)
> > +	if (addr != (unsigned) -ENOMEM)
>
> addr is unsigned long.  If you truncate -ENOMEM to 32-bits, it will
> never match.  There appears to be much more int/long confusion later.
>
> You have to be /exceedingly/ careful to fix these warnings without
> introducing new bugs.  If you change the type of a variable, you
> have to examine each and every use of the variable to determine if
> the semantics are unchanged.  If you add a cast, you have to be sure
> that you cast to a type of the correct width.  If you're adding lots
> of casts, you should think about changing the type of one or more
> variables.
>
> It's enough to make me wish we had -Wno-sign-compare in CFLAGS by
> default for the nonce.  Which, incidentally, is what I've been doing
> for my own builds.
>
> There's absolutely no way I'm going to apply a jumbo patch that
> changes hundreds of these at once.  If you still want to fix these,
> then you'll need to send them one at a time and include analysis of
> why each change is correct.
>
>
> r~
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
