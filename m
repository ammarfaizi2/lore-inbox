Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVB1Nhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVB1Nhj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 08:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVB1Ngv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 08:36:51 -0500
Received: from alog0457.analogic.com ([208.224.222.233]:36992 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261598AbVB1Nep
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 08:34:45 -0500
Date: Mon, 28 Feb 2005 08:33:24 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: colbuse@ensisun.imag.fr
cc: linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [patch 3/2] drivers/char/vt.c: remove unnecessary code
In-Reply-To: <1109595479.422315570842d@webmail.imag.fr>
Message-ID: <Pine.LNX.4.61.0502280828090.26885@chaos.analogic.com>
References: <1109595479.422315570842d@webmail.imag.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2005 colbuse@ensisun.imag.fr wrote:

> We could change an affectation into an incrementation by this patch, and,
> so far I know, incrementing is quicker than or as quick as setting
> a variable (depends on the architecture).
>
> Please _don't_ apply this, but tell me what you think about it.
> Note that npar is unsigned.
>
> Signed-off-by: Emmanuel Colbus <emmanuel.colbus@ensimag.imag.fr>
>

Since it is common practice to write code as:
                for(npar = 0 ; npar < NPAR ; npar++)
... it is quite likely that the compiler does a better job with
that code than what you substitute. And, if you did a check
of the code generation, it might be different between different
compiler versions.


This kind of "code optimization" won't optimize anything in
the long-run.


> --- old/drivers/char/vt.c       2004-12-24 22:35:25.000000000 +0100
> +++ new/drivers/char/vt.c       2005-02-28 12:53:57.933256631 +0100
> @@ -1655,9 +1655,9 @@
>                        vc_state = ESnormal;
>                return;
>        case ESsquare:
> -               for(npar = 0 ; npar < NPAR ; npar++)
> +               for(npar = NPAR-1; npar < NPAR; npar--)
>                        par[npar] = 0;
> +               npar++;
> -               npar = 0;
>                vc_state = ESgetpars;
>                if (c == '[') { /* Function key */
>                        vc_state=ESfunckey;
>
>
> --
> Emmanuel Colbus
> Club GNU/Linux
> ENSIMAG - departement telecoms
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
