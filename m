Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276988AbRKAAuY>; Wed, 31 Oct 2001 19:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277000AbRKAAuO>; Wed, 31 Oct 2001 19:50:14 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:19409 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S276988AbRKAAuA>;
	Wed, 31 Oct 2001 19:50:00 -0500
Date: Thu, 1 Nov 2001 01:50:15 +0100
From: David Weinehall <tao@acc.umu.se>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linus Torvlads <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Thomas Hood <jdthood@mail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Stop APM readers from responding to events
Message-ID: <20011101015015.G25701@khan.acc.umu.se>
In-Reply-To: <20011101012900.1a2f3287.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011101012900.1a2f3287.sfr@canb.auug.org.au>; from sfr@canb.auug.org.au on Thu, Nov 01, 2001 at 01:29:00AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2001 at 01:29:00AM +1100, Stephen Rothwell wrote:
> Hi Linus,
> 
> This is just a small patch, but fills a hole.  Thanks to Thomas Hood for a
> patch.
> 
> Alan, This will also apply to 2.4.13-ac5.

Shouldn't this be done using capabilities instead?!

> diff -ruN 2.4.14-pre5/arch/i386/kernel/apm.c 2.4.14-pre5-APM.1/arch/i386/kernel/apm.c
> --- 2.4.14-pre5/arch/i386/kernel/apm.c	Wed Oct 24 16:12:20 2001
> +++ 2.4.14-pre5-APM.1/arch/i386/kernel/apm.c	Thu Nov  1 01:09:48 2001
> @@ -1471,7 +1471,7 @@
>  	as = filp->private_data;
>  	if (check_apm_user(as, "ioctl"))
>  		return -EIO;
> -	if (!as->suser)
> +	if ((!as->suser) || (!as->writer))
>  		return -EPERM;
>  	switch (cmd) {
>  	case APM_IOC_STANDBY:


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
