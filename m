Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267984AbUIFNLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267984AbUIFNLl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 09:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267393AbUIFNJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 09:09:38 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:27471 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S267985AbUIFNH7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 09:07:59 -0400
Date: Mon, 6 Sep 2004 15:11:06 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: akpm@osdl.org, zwane@linuxpower.ca, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.9-rc1-mm3] [m32r] Change from EXPORT_SYMBOL_NOVERS to EXPORT_SYMBOL
Message-ID: <20040906131106.GA8202@mars.ravnborg.org>
Mail-Followup-To: Hirokazu Takata <takata@linux-m32r.org>,
	akpm@osdl.org, zwane@linuxpower.ca, linux-kernel@vger.kernel.org
References: <20040903104239.A3077@infradead.org> <Pine.LNX.4.58.0409030814100.4481@montezuma.fsmlabs.com> <Pine.LNX.4.58.0409030823530.4481@montezuma.fsmlabs.com> <20040906.215512.861025296.takata.hirokazu@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040906.215512.861025296.takata.hirokazu@renesas.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2004 at 09:55:12PM +0900, Hirokazu Takata wrote:
> Hi, 
> 
> From: Zwane Mwaikambo <zwane@linuxpower.ca>
> Subject: Re: 2.6.9-rc1-mm3
> Date: Fri, 3 Sep 2004 08:48:27 -0400 (EDT)
> > Just a few comments.
> Thank you.
> 
> > - There appears to be yet another smc 91C111 driver in there, Takata,
> >   there should be a unified one in drivers/net/smc91x.c.
> Yes.  I would like to use drivers/net/smc91x.c.  Now investigating it...
> 
> > - arch/m32r/Kconfig could do with some trimming.
> Yes.  I am going to clean up it.
> 
> > - arch/m32r/kernel/irq.c shows that we really could do with that irq
> >   consolidation.
> I see.  Some i386 code and comments are remained in there.
> 
> > - arch/m32r/kernel/m32r_ksyms, EXPORT_SYMBOL_NOVERS is deprecated, use
> >   EXPORT_SYMBOL.
> Here is a patch for that.
> 
> Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
> 
> 
> diff -rup linux-2.6.9-rc1-mm3.orig/arch/m32r/kernel/m32r_ksyms.c linux-2.6.9-rc1-mm3/arch/m32r/kernel/m32r_ksyms.c
> --- linux-2.6.9-rc1-mm3.orig/arch/m32r/kernel/m32r_ksyms.c	2004-09-03 20:46:13.000000000 +0900
> +++ linux-2.6.9-rc1-mm3/arch/m32r/kernel/m32r_ksyms.c	2004-09-06 17:12:18.000000000 +0900
> @@ -48,9 +48,9 @@ EXPORT_SYMBOL(__udelay);
>  EXPORT_SYMBOL(__delay);
>  EXPORT_SYMBOL(__const_udelay);
>  
> -EXPORT_SYMBOL_NOVERS(__get_user_1);
> -EXPORT_SYMBOL_NOVERS(__get_user_2);
> -EXPORT_SYMBOL_NOVERS(__get_user_4);
> +EXPORT_SYMBOL(__get_user_1);
> +EXPORT_SYMBOL(__get_user_2);
> +EXPORT_SYMBOL(__get_user_4);
......

The convention these days is to put the EXPORT right uder the funtion definition
when appropriate.

So something like:
int foo(int l)
{
	...
}
EXPORT_SYMBOL(foo);

No one just took their time to get rid of the rest of the *ksyms files.

	Sam
