Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263703AbRFKJTH>; Mon, 11 Jun 2001 05:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263554AbRFKJS5>; Mon, 11 Jun 2001 05:18:57 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:7940 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S263605AbRFKJSl>;
	Mon, 11 Jun 2001 05:18:41 -0400
Date: Fri, 8 Jun 2001 19:32:25 +0000
From: Pavel Machek <pavel@suse.cz>
To: Bernd Jendrissek <berndj@prism.co.za>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
Message-ID: <20010608193224.A36@toy.ucw.cz>
In-Reply-To: <20010607124621.A30328@prism.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010607124621.A30328@prism.co.za>; from berndj@prism.co.za on Thu, Jun 07, 2001 at 12:46:22PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> If this solves your problem, use it; if your name is Linus or Alan,
> ignore or do it right please.

Well I guess you should do CONDITIONAL_SCHEDULE (if it is not defined
as macro, do if (current->need_resched) schedule()).

That modulo is likely slower than dereference.

> diff -u -r1.1 -r1.2
> --- linux-hack/mm/filemap.c     2001/06/06 21:16:28     1.1
> +++ linux-hack/mm/filemap.c     2001/06/07 08:57:52     1.2
> @@ -2599,6 +2599,11 @@
>                 char *kaddr;
>                 int deactivate = 1;
>  
> +               /* bernd-hack: give other processes a chance to run */
> +               if (count % 256 == 0) {
> +                       schedule();
> +               }
> +
>                 /*
>                  * Try to find the page in the cache. If it isn't there,
>                  * allocate a free page.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.0.4 (GNU/Linux)
> Comment: For info see http://www.gnupg.org
> 
> iD8DBQE7H1tb/FmLrNfLpjMRAguAAJ0fYInFbAa6LjFC/CWZbRPQxzZwrwCeNqT0
> /Kod15Nx7AzaM4v0WhOgp88=
> =pyr6
> -----END PGP SIGNATURE-----
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

