Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270017AbUJTLlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270017AbUJTLlk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 07:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270077AbUJTLFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 07:05:45 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:23718 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S269880AbUJTKx6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 06:53:58 -0400
Date: Wed, 20 Oct 2004 12:53:53 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH (updated)] Avoid annoying build warning on 32-bit
 platforms
Message-ID: <20041020125353.6af0aad6@phoebee>
In-Reply-To: <20041020102343.GA6901@taniwha.stupidest.org>
References: <200410200956.i9K9ujOu026178@harpo.it.uu.se>
	<20041020102343.GA6901@taniwha.stupidest.org>
X-Mailer: Sylpheed-Claws 0.9.12cvs53 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.7-rc2-mm2 i686 Intel(R) Pentium(R) 4
 CPU 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__20_Oct_2004_12_53_53_+0200_Nn2V7WxyrOJqBYCz"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__20_Oct_2004_12_53_53_+0200_Nn2V7WxyrOJqBYCz
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 20 Oct 2004 03:23:43 -0700
Chris Wedgwood <cw@f00f.org> bubbled:

> On Wed, Oct 20, 2004 at 11:56:45AM +0200, Mikael Pettersson wrote:
> 
> > There's a coding idiom for doing this: just break up
> > the ">> 32" in two steps, like: ((time >> 31) >> 1).
> 
> i assumed gcc would complain there too but it doesn't and it does
> optimize this away (i checked)
> 
> > Definitely preferable over #ifdef:s.
> 
> indeed
> 
> 
> 
> Avoid annoying gcc warning on 32-bit platforms.
> 
> Signed-off-by: cw@f00f.org
> 
> ===== drivers/char/random.c 1.57 vs edited =====
> --- 1.57/drivers/char/random.c	2004-10-05 14:21:53 -07:00
> +++ edited/drivers/char/random.c	2004-10-20 03:19:17 -07:00
> @@ -818,12 +818,10 @@ static void add_timer_randomness(struct 
>  	 * jiffies.
>  	 */
>  	time = get_cycles();
> -	if (time != 0) {
> -		if (sizeof(time) > 4)
> -			num ^= (u32)(time >> 32);
> -	} else {
> +	if (time)
> +		num ^= (u32)((time >> 32) >> 1);
                                      ^^ errr ... should be 31 ?!?!
> +	else
>  		time = jiffies;
> -	}
>  
>  	/*
>  	 * Calculate number of bits of randomness we probably added.
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
MyExcuse:
We've run out of licenses

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature=_Wed__20_Oct_2004_12_53_53_+0200_Nn2V7WxyrOJqBYCz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBdkPBmjLYGS7fcG0RAh9gAJ4gLmIStpSGhy01XbfIj1U9P3CDHACfbAaN
scp6VKyDmq4YzCAeHHnXQqs=
=dgyG
-----END PGP SIGNATURE-----

--Signature=_Wed__20_Oct_2004_12_53_53_+0200_Nn2V7WxyrOJqBYCz--
