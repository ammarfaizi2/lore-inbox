Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261668AbSKHHcR>; Fri, 8 Nov 2002 02:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266767AbSKHHcR>; Fri, 8 Nov 2002 02:32:17 -0500
Received: from p50829A93.dip.t-dialin.net ([80.130.154.147]:42254 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id <S261668AbSKHHcQ>; Fri, 8 Nov 2002 02:32:16 -0500
Date: Fri, 8 Nov 2002 07:38:45 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: Richard Henderson <rth@redhat.com>, George France <france@handhelds.org>,
       axp-list mailing list <axp-list@redhat.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] eliminate compile warnings
Message-ID: <20021108073845.A17905@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: Richard Henderson <rth@redhat.com>,
	George France <france@handhelds.org>,
	axp-list mailing list <axp-list@redhat.com>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <20021106214705.A15525@Marvin.DL8BCU.ampr.org> <02110709222600.14483@shadowfax.middleearth> <20021107202855.B17028@Marvin.DL8BCU.ampr.org> <20021107173349.A4017@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20021107173349.A4017@twiddle.net>; from rth@twiddle.net on Thu, Nov 07, 2002 at 05:33:49PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 05:33:49PM -0800, Richard Henderson wrote:
> As for the patch itself, it's not correct.  At a glance,
> 
> > 	addr = arch_get_unmapped_area_1 (PAGE_ALIGN(addr), len, limit);
> > -	if (addr != -ENOMEM)
> > +	if (addr != (unsigned) -ENOMEM)
> 
> addr is unsigned long.  If you truncate -ENOMEM to 32-bits, it will
> never match.  There appears to be much more int/long confusion later.

I will give my patch another thought and I will feed it to you in smaller 
pieces and with comments.

> You have to be /exceedingly/ careful to fix these warnings without
> introducing new bugs.  If you change the type of a variable, you 
> have to examine each and every use of the variable to determine if
> the semantics are unchanged.  If you add a cast, you have to be sure
> that you cast to a type of the correct width.  If you're adding lots
> of casts, you should think about changing the type of one or more
> variables.

Generally I'm aware of this - maybe a case of more coffee needed :)

> It's enough to make me wish we had -Wno-sign-compare in CFLAGS by
> default for the nonce.  Which, incidentally, is what I've been doing
> for my own builds.
> 
> There's absolutely no way I'm going to apply a jumbo patch that
> changes hundreds of these at once.  If you still want to fix these,
> then you'll need to send them one at a time and include analysis of
> why each change is correct.

Will do.

Thanks for your time.

Thorsten

-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Niemannsweg 30, 49201 Dissen, Germany |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
