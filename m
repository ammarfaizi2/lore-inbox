Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261639AbREXMHl>; Thu, 24 May 2001 08:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261679AbREXMHb>; Thu, 24 May 2001 08:07:31 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:60171 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S261639AbREXMHT>; Thu, 24 May 2001 08:07:19 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200105241201.OAA32046@green.mif.pg.gda.pl>
Subject: Re: [PATCH] drivers/net/others
To: tori@unhappy.mine.nu (Tobias Ringstrom)
Date: Thu, 24 May 2001 14:01:14 +0200 (CEST)
Cc: jgarzik@mandrakesoft.com, alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <Pine.LNX.4.33.0105241035230.10914-100000@boris.prodako.se> from "Tobias Ringstrom" at May 24, 2001 10:45:25 AM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for your impressive clean-up patch.  I have a couple of comments
> regarding your clean-up of the dmfe.c driver.

Thanks for your response.
 
> On Thu, 24 May 2001, Andrzej Krzysztofowicz wrote:
> 
> > @@ -395,7 +395,7 @@
> >  	u32 dev_rev, pci_pmr;
> >
> >  	if (!printed_version++)
> > -		printk(version);
> > +		printk("%s", version);
> >
> >  	DMFE_DBUG(0, "dmfe_init_one()", 0);
> >
> 
> Could you please explain the purpose of this change?  To me it looks less
> efficient in both performance and memory usage.

Basically I also preferred to avoid the extra string here. But Alan suggests
it may cause problems while somebody wants to add a literal % to the version
string. Moreover, IMHO it is better to have a standard here, i.e. either all
drivers contain the format or none does.

If you still complain, I'll drop this change.

> > @@ -2024,8 +2027,10 @@
> >  {
> >  	int rc;
> >
> > -	printk(version);
> > +#ifdef MODULE
> > +	printk("s", version);
> >  	printed_version = 1;
> > +#endif /* MODULE */
> >
> >  	DMFE_DBUG(0, "init_module() ", debug);
> >
> 
> Whoups...  And why did you add the ifdef, btw?

AFAIK module_init becomes __initcall while compiled into kernel. So it is
called (IMO) always and the previous "version" printing (around line 400)
would never be executed (printed_version == 1). 
And we do not want to print version for built-in drivers which do not detect
hardware, do we ?

Andrzej

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  tel.  (0-58) 347 14 61
Wydz.Fizyki Technicznej i Matematyki Stosowanej Politechniki Gdanskiej
