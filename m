Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWCCP6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWCCP6R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 10:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWCCP6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 10:58:16 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:65495 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1751228AbWCCP6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 10:58:16 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 5/9] ns558: adjust pnp_register_driver signature
Date: Fri, 3 Mar 2006 08:58:12 -0700
User-Agent: KMail/1.8.3
Cc: Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org,
       Jaroslav Kysela <perex@suse.cz>,
       Matthieu Castet <castet.matthieu@free.fr>,
       Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>
References: <200603021601.27467.bjorn.helgaas@hp.com> <200603021609.37525.bjorn.helgaas@hp.com> <20060303125543.GC11899@suse.cz>
In-Reply-To: <20060303125543.GC11899@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603030858.12495.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 March 2006 05:55, Vojtech Pavlik wrote:
> On Thu, Mar 02, 2006 at 04:09:37PM -0700, Bjorn Helgaas wrote:
> > Remove the assumption that pnp_register_driver() returns the number of
> > devices claimed.
> > 
> > Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> Wouldn't a diff like
> 
> --- a/drivers/input/gameport/ns558.c	2006-03-02 12:40:45.000000000 -0700
> +++ b/drivers/input/gameport/ns558.c	2006-03-02 12:43:58.000000000 -0700
> @@ -258,7 +256,7 @@
>  {
>  	int i = 0;
>  
> -	if (pnp_register_driver(&ns558_pnp_driver) >= 0)
> +	if (!pnp_register_driver(&ns558_pnp_driver))
>  		pnp_registered = 1;
>   
>   /*
> 
> be enough? The err variable isn't used anywhere else.

Yup, that'd be fine, and in fact my first version of the patch
did just that.  I introduced "err" because most of the other
drivers I had to touch used "err," and it seemed a bit clearer to me
because it gives an extra hint that pnp_register_driver() returns
only an error code.

But I don't care either way, so say the word, and I'll send
Andrew your patch to replace mine.

Bjorn

> > Index: work-mm4/drivers/input/gameport/ns558.c
> > ===================================================================
> > --- work-mm4.orig/drivers/input/gameport/ns558.c	2006-03-02 12:40:45.000000000 -0700
> > +++ work-mm4/drivers/input/gameport/ns558.c	2006-03-02 12:43:58.000000000 -0700
> > @@ -256,9 +256,10 @@
> >  
> >  static int __init ns558_init(void)
> >  {
> > -	int i = 0;
> > +	int i = 0, err;
> >  
> > -	if (pnp_register_driver(&ns558_pnp_driver) >= 0)
> > +	err = pnp_register_driver(&ns558_pnp_driver);
> > +	if (!err)
> >  		pnp_registered = 1;
> >  
> >  /*
> > 
> > 
> 
