Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263761AbUELVKC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbUELVKC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 17:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbUELVHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 17:07:38 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:30850 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265235AbUELVDO (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 17:03:14 -0400
Message-Id: <200405122103.i4CL3AUp014523@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Netdev <netdev@oss.sgi.com>
Subject: Re: MSEC_TO_JIFFIES is messed up... 
In-Reply-To: Your message of "Wed, 12 May 2004 22:50:28 +0200."
             <20040512205028.GA18806@elte.hu> 
From: Valdis.Kletnieks@vt.edu
References: <20040512020700.6f6aa61f.akpm@osdl.org> <20040512181903.GG13421@kroah.com> <40A26FFA.4030701@pobox.com> <20040512193349.GA14936@elte.hu> <200405121947.i4CJlJm5029666@turing-police.cc.vt.edu> <Pine.LNX.4.58.0405121255170.11950@bigblue.dev.mdolabs.com> <200405122007.i4CK7GPQ020444@turing-police.cc.vt.edu> <20040512202807.GA16849@elte.hu> <20040512203500.GA17999@elte.hu>
            <20040512205028.GA18806@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-725252706P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 12 May 2004 17:03:10 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-725252706P
Content-Type: text/plain; charset=us-ascii

On Wed, 12 May 2004 22:50:28 +0200, Ingo Molnar said:

> Content-Disposition: attachment; filename="hz-cleanup-2.6.6-A2"
> 
> --- linux/include/linux/time.h.orig	
> +++ linux/include/linux/time.h	
> @@ -177,6 +177,24 @@ struct timezone {
>  	(SH_DIV((MAX_JIFFY_OFFSET >> SEC_JIFFIE_SC) * TICK_NSEC, NSEC_PER_SEC, 
1) - 1)
>  
>  #endif
> +
> +/*
> + * Convert jiffies to milliseconds and back.
> + *
> + * Avoid unnecessary multiplications/divisions in the
> + * two most common HZ cases:
> + */
> +#if HZ == 1000
> +# define JIFFIES_TO_MSECS(x)	(x)
> +# define MSECS_TO_JIFFIES(x)	(x)
> +#elif HZ == 100
> +# define JIFFIES_TO_MSECS(x)	((x) * 10)
> +# define MSECS_TO_JIFFIES(x)	((x) / 10)
> +#else
> +# define JIFFIES_TO_MSECS(x)	((x) * 1000 / HZ)
> +# define MSECS_TO_JIFFIES(x)	((x) * HZ / 1000)
> +#endif
> +

Looks good to me.. :)

--==_Exmh_-725252706P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAopEOcC3lWbTT17ARArOzAKDM3xA1BVYCfW4BJhF7WIRcbbVVlACfciAe
ZNSdcKBxy1tXpJvpoUky7w0=
=8oxt
-----END PGP SIGNATURE-----

--==_Exmh_-725252706P--
